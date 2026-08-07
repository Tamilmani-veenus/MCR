import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mcr/controller/punch_in_controller.dart';
import 'package:mcr/controller/site_location_controller.dart';
import 'package:mcr/models/punch_in_model.dart';
import '../constants/storage_constant.dart';
import '../controller/logincontroller.dart';
import '../db_helper/db_manager.dart';
import '../login/animation_signinpage/signin_page.dart';
import '../newhome/maindashboard/dashboard.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/print_logger.dart';
import 'internetissue.dart';
import 'package:http/http.dart' as http;

final http.Client _httpClient = http.Client();

/// Send Request.....

Future<http.StreamedResponse> send(http.BaseRequest request) async {
  return _httpClient.send(request);
}


bool? netWorkStatus = false;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  PunchInController punchInController = Get.put(PunchInController());

  ConnectivityResult? connectivityResult;
  bool? isConnectionSuccessful;

  String versionName = "";
  String code = "";

  Future<void> checkingPunchDetails() async {
    if (punchInController.punchInDetails.isNotEmpty) {
      setState(() {
        loginController.punchInStatus = true;
        printToLog("No internet punch in status :: ${loginController.punchInStatus}");
      });
    } else {
      loginController.punchInStatus = false;
      printToLog("No internet punch in status :: ${loginController.punchInStatus}");
    }

    if (punchInController.punchOutDetails.isNotEmpty) {
      setState(() {
        loginController.punchOutStatus = true;
        printToLog("No internet punch in status :: ${loginController.punchOutStatus}");
      });
    } else {
      setState(() {
        loginController.punchOutStatus = false;
        printToLog("No internet punch in status :: ${loginController.punchOutStatus}");
      });
    }
  }

  Future<void> sendPunchDetails() async {
    if (punchInController.punchInDetails.isNotEmpty && loginController.punchInStatus == true) {
      DateTime check = DateTime.now();
      DateTime date = DateTime.parse(punchInController.punchInDetails[0].dateIn.toString());
        if (date.year == check.year && date.month == check.month && date.day == check.day) {
          printToLog("Selected date is the current date");
          for (int i = 0; i < punchInController.punchInDetails.length; i++) {
            PunchInSaveModel data =
                PunchInSaveModel(
                    empId: punchInController.punchInDetails[i].empId.toString(),
                    dateIn: punchInController.punchInDetails[i].dateIn.toString(),
                    entryMode: punchInController.punchInDetails[i].entryMode.toString(),
                    locId: punchInController.punchInDetails[i].locId.toString(),
                    userId: punchInController.punchInDetails[i].userId.toString(),
                    deviceName: punchInController.punchInDetails[i].deviceName.toString(),
                    punchTimeIn: punchInController.punchInDetails[i].punchTimeIn.toString());
            Uri uri = Uri.parse(ApiConstant.PUNCH_IN);
            printToLog("Image Sending Uri ::::: $uri");
            var request = http.MultipartRequest("POST", uri);
            dynamic bodyData = data.toJson();
            request.files.add(
              await http.MultipartFile.fromPath(
                'File',
                punchInController.punchInDetails[i].imagePath!,
                contentType: MediaType('image', 'jpeg'),
                filename: 'image.jpeg',
              ),
            );
            for (var field in bodyData.keys) {
              var value = bodyData[field];
              if (value is String) {
                request.fields[field] = value;
              }
            }
            request.headers["content-type"] = "application/json; charset=utf-8";
            final response = await http.Response.fromStream(await request.send());
            printToLog("Request Data :: ${request.fields}");
            printToLog("Request Data :: ${request.files}");
            printToLog("Response Data :: ${response.body}");
          }
          await punchInController.deletePunchInDetails();
          loginController.punchInStatus = false;
        } else {
          printToLog("Selected date is not current date");
          loginController.punchInStatus = false;
        }
    }
    if (punchInController.punchOutDetails.isNotEmpty && loginController.punchOutStatus == true) {
      DateTime check = DateTime.now();
      DateTime punchOutDate =
          DateTime.parse(punchInController.punchOutDetails[0].date.toString());
        if (punchOutDate.year == check.year && punchOutDate.month == check.month && punchOutDate.day == check.day) {
          for (int i = 0; i < punchInController.punchOutDetails.length; i++) {
            PunchOutUpdate data = PunchOutUpdate(
                empId: punchInController.punchOutDetails[i].empId.toString(),
                entryMode: punchInController.punchOutDetails[i].entryMode.toString(),
                userId: punchInController.punchOutDetails[i].userId.toString(),
                deviceName: punchInController.punchOutDetails[i].deviceName.toString(),
                date: punchInController.punchOutDetails[i].date.toString(),
                timeOut: punchInController.punchOutDetails[i].timeOut.toString(),
                locId: punchInController.punchOutDetails[i].locId.toString());
            Uri uri = Uri.parse(ApiConstant.PUNCH_OUT);
            printToLog(uri.toString());
            String method = "PUT";
            var bodyData = data.toJson();
            http.Request request = http.Request(method, uri);
            request.headers['Content-Type'] = 'application/json';
            request.body = jsonEncode(bodyData);
            http.StreamedResponse streamRes = await send(request);
            http.Response response = await http.Response.fromStream(streamRes);
            printToLog("Request Data :: $bodyData");
            printToLog("Response Data ::  ${response.body}");
          }
          await punchInController.deletePunchOutDetails();
          loginController.punchInStatus = false;
          printToLog("Selected date is the current date");
        } else {
          printToLog("Selected date is not current date");
          loginController.punchInStatus = false;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    loginController.getLoginDetailsShared();
    siteLocationController.getSiteLocationDetails();
    punchInController.getPunchInDetailsShared();
    punchInController.getPunchOutDetailsShared();
    Future.delayed(const Duration(seconds: 0), () async {
      punchStatus = await ServiceLocalDatabaseService.getLocalStateProp("punchStatus");
      printToLog("Initial punch status :: $punchStatus");
    });
    var duration = const Duration(seconds: 3);
    Future.delayed(duration, () async {
      final ConnectivityResult result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        netWorkStatus = true;
        await checkingPunchDetails();
        await sendPunchDetails();
        SessionCheck();
        BaseUtitiles.getDeviceDetails();
        DBManager dbManager = DBManager();
        dbManager.database;
      } else {
        netWorkStatus = false;
        Navigator.push(context, MaterialPageRoute(builder: (context) => const InternetLostConnection()));
      }
    });
  }

  void SessionCheck() async {
    final value = await SessionStorage.readUser();
    loginController.seassion_values = value;
    if (value != null) {
      await loginController.getLoginNew_seassionvalues(context);
      if (loginController.user.value.userPassword.toString() ==
              loginController.seassion_values.userPassword.toString() &&
          loginController.user.value.userAppActive.toString() ==
              loginController.seassion_values.userAppActive.toString() &&
          loginController.user.value.userActive.toString() ==
              loginController.seassion_values.userActive.toString() &&
          loginController.user.value.userType.toString() ==
              loginController.seassion_values.userType.toString()) {
        if (loginController.user.value.userType == "A") {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard_screen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
        }
      } else {
        SessionStorage.removeUser();
        BaseUtitiles.showToast(
            "Please Contact Your Administrator User is InActive");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Image.asset('assets/images/loading.gif'),
            ),
          ],
        ),
      ),
    );
  }
}
