import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/storage_constant.dart';
import '../db_model/login_details_model.dart';
import '../db_services/login_details_service.dart';
import '../login/animation_signinpage/signin_page.dart';
import '../models/login_details_payload.dart';
import '../models/punch_in_model.dart';
import '../models/usertokenrequest_model.dart';
import '../newhome/maindashboard/dashboard.dart';
import '../models/authendication_model.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../provider/authendication_provider.dart';
import '../provider/common_provider.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  String deviceTokenToSendPushNotification = "";
  bool? punchInStatus = false;
  bool? punchOutStatus = false;
  List<LoginDetailsPayload> loginDetails= [];

  var user = User().obs;
  var version;

  bool ckeck = true;
  var seassion_values;

  XFile? imageFile;

  String UserId() => user.value.userId.toString();

  String UserName() => user.value.userName.toString();

  String UserPassword() => user.value.userPassword.toString();

  String UserType() => user.value.userType.toString();

  String UserActive() => user.value.userActive.toString();

  String EmpName() => user.value.empName.toString();

  String EmpId() => user.value.empId.toString();

  List logindatas = [];

  getLoginDetails(BuildContext context) async {
    await AuthendicationProvider.getAuthendication(username_controller.text, password_controller.text,context).then((value) async {
      logindatas = value;
      if (value != null) {
        user.value = value[0];
        if (user.value.userAppActive == 1) {
          SessionStorage.writeUser(value[0]);
          await getDeviceTokenToSendNotification();
          await Savetoken(context);
          if (user.value.userType == "A") {
            Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard_screen()));
          } else {
            Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
          }
        } else {
          Navigator.pop(context);
          BaseUtitiles.showToast("Please Contact Your Administrator User is InActive");
        }
      } else {
        Navigator.pop(context);
        BaseUtitiles.showToast("Login Failed");
      }
    });
    await deleteLoginDetails();
    await storeLoginDetails();
    await getLoginDetailsShared();
    return logindatas;
  }

  /// ----- 2nd time login-seassionvalue -----

  /// ----- ****************** ------

  List logincheck = [];
  // Future getLoginNewSeassionvalues(BuildContext context) async {
  //   var value = await AuthendicationProvider.getAuthendication(
  //       seassion_values.userName.toString(),
  //       seassion_values.userPassword.toString(),
  //       context);
  //   logincheck = value;
  //   if (logincheck.isNotEmpty) {
  //     // user.value = value[0];
  //     if (logincheck[0].userAppActive == 1) {
  //       print("LoginValue :: ${logincheck[0].userAppActive}");
  //       user.value.userId = logincheck[0].userId;
  //       user.value.userName = logincheck[0].userName.toString();
  //       user.value.userPassword = logincheck[0].userPassword.toString();
  //       user.value.userType = logincheck[0].userType.toString();
  //       user.value.userActive = logincheck[0].userActive.toString();
  //       user.value.userAppActive = logincheck[0].userAppActive;
  //       user.value.empId = logincheck[0].empId;
  //       user.value.empName = logincheck[0].empName.toString();
  //       SessionStorage.writeUser(value[0]);
  //       await getDeviceTokenToSendNotification();
  //       await Savetoken(context);
  //       if (logincheck[0].userType == "A") {
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard_screen()));
  //       } else {
  //         await getPunchInStatus("0");
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
  //         // print("Hello two :: ");
  //         // DateTime time = DateTime.now();
  //         // bool isPastEightPm = time.hour < 20;
  //         // print("Current time :: ${time.hour}");
  //         // print("Time Value :: $isPastEightPm");
  //         // if (isPastEightPm == true) {
  //         //   print("Hello four :: ");
  //         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard_screen()));
  //         // } else {
  //         //   print("Hello three :: ");
  //         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PunchOut()));
  //         // }
  //       }
  //     } else {
  //       SessionStorage.removeUser();
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage()));
  //       BaseUtitiles.showToast("Please Contact Your Administrator User is InActive");
  //     }
  //   } else {
  //     BaseUtitiles.showToast("LoginFailed");
  //   }
  // }

  /// ----- Need for reference -----

  Future getLoginNew_seassionvalues(BuildContext context) async {
    var value = await AuthendicationProvider.getAuthendication(
        seassion_values.userName.toString(),
        seassion_values.userPassword.toString(),context);
    if (value != null) {
      user.value = value[0];
      if (user.value.userAppActive == 1) {
        print("LoginValue :: ${user.value.userAppActive}");
        SessionStorage.writeUser(value[0]);
        await getDeviceTokenToSendNotification();
        await Savetoken(context);
        if (user.value.userType == "A") {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Dashboard_screen()));
          // if(punchStatus == "False"){
          //   print("Hello One :: ");
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard_screen()));
          // }else{
          //   print("Hello two :: ");
          //   DateTime time = DateTime.now();
          //   bool isPastEightPm = time.hour < 20;
          //   print("Current time :: ${time.hour}");
          //   print("Time Value :: $isPastEightPm");
          //   if (isPastEightPm == true) {
          //     print("Hello four :: ");
          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard_screen()));
          //   } else {
          //     print("Hello three :: ");
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => const PunchOut()));
          //   }
          // }
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardScreen_OtherUser()));
        }
      } else {
        Navigator.pop(context);
        BaseUtitiles.showToast(
            "Please Contact Your Administrator User is InActive");
      }
    } else {
      Navigator.pop(context);
      BaseUtitiles.showToast("LoginFailed");
    }
  }

  Future<void> getDeviceTokenToSendNotification() async {
    FirebaseMessaging.instance.requestPermission();
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token " + deviceTokenToSendPushNotification);
  }

  Future Savetoken(BuildContext context) async {
    String body = usertokenRequestToJson(UsertokenRequest(
      userId: UserId(),
      deviceId: BaseUtitiles.deviceName,
      token: deviceTokenToSendPushNotification,
    ));
    await CommonProvider.Savetoken(body);
  }

  Future usertoken_DeleteApi() async {
    await CommonProvider.Usertoken_deleteAPI(UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  /// Get punch in status .....

  Future getPunchInStatus() async {
    PunchInSaveRes punchInSaveRes = await AuthendicationProvider().getPunchInStatusProvider(user.value.empId.toString());
    punchStatus = punchInSaveRes.status.toString();
    await ServiceLocalDatabaseService.saveLocalStateProp("punchStatus",punchInSaveRes.status.toString());
    punchStatus = await ServiceLocalDatabaseService.getLocalStateProp("punchStatus");
    print("Punch in status ::${punchStatus.toString()}");
    return punchInSaveRes;
  }

  /// Save to local DB login user details......

  var loginInsert = LoginDetailsModel();
  var loginservices = LoginDetailsService();
  List<LoginDetailsModel> loginvalues = <LoginDetailsModel>[];
  RxList getloginvalues = [].obs;

  /// ------ Shared preference ------

  /// ----- Stored login details values -----

  Future<void> storeLoginDetails() async {
    loginDetails.clear();
    loginDetails.add(LoginDetailsPayload(
      userId: user.value.userId.toString(),
      empId: user.value.empId.toString(),
      empName: user.value.empName.toString(),
      userActive: user.value.userActive.toString(),
      userName: user.value.userName.toString(),
      userType: user.value.userType.toString(),
    ));
    await ServiceLocalDatabaseService.saveLoginDetails(loginDetails, "login");
  }

  /// ----- Get the stored login details values -----

  Future<void> getLoginDetailsShared() async {
    List<LoginDetailsPayload> loginDetail = await ServiceLocalDatabaseService.getLoginDetails("login");
    loginDetails = loginDetail;
    if(loginDetails.isNotEmpty){
      print("Getting values :: ${loginDetails[0].userId}");
    } else {
      print("No details found");
    }
  }

  /// ----- Delete the stored login details values -----

  Future<void> deleteLoginDetails() async {
    await ServiceLocalDatabaseService.deleteLoginDetails("login");
  }


}
