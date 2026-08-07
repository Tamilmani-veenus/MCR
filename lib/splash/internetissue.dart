import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mcr/splash/splash.dart';
import 'package:mcr/utilities/print_logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upgrader/upgrader.dart';
import '../constants/storage_constant.dart';
import '../controller/logincontroller.dart';
import '../controller/punch_in_controller.dart';
import '../controller/site_location_controller.dart';
import '../home/dashboard/site_locations_view.dart';
import '../login/animation_signinpage/signin_page.dart';
import '../utilities/baseutitiles.dart';

///-----------Lost net connection------------

class InternetLostConnection extends StatefulWidget {
  const InternetLostConnection({super.key});

  @override
  State<InternetLostConnection> createState() => _InternetLostConnectionState();
}

class _InternetLostConnectionState extends State<InternetLostConnection> {
  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  PunchInController punchInController = Get.put(PunchInController());

  @override
  initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      SignInPage.checkVersion(context);
      punchStatus = await ServiceLocalDatabaseService.getLocalStateProp("punchStatus");
      printToLog("Initial punch status :: $punchStatus");
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        printToLog('Current connectivity status: $result');
        setState(() {
          _connectivityResult = result;
        });
      });
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("MCR Construction"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              exit(0);
            },
          ),
          backgroundColor: const Color(0xFF09a3f3),
        ),
        body: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/lostnetwork.png'),
                ],
              ),
              Container(
                margin: EdgeInsets.all(4.r),
                child: const Text(
                  "Oops! No Network Connection",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              const Text("Please check your internet connection...!"),
              SizedBox(
                height: 50.h,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_connectivityResult == ConnectivityResult.wifi || _connectivityResult == ConnectivityResult.mobile) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Splash()));
                  } else {
                    openAppSettings();
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    backgroundColor: const Color(0xFF09a3f3), // Use the color #09a3f3
                    minimumSize: const Size(150, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                child: const Text('Try Again'),
              ),
              // punchStatus == "false"
              //     ?
                ElevatedButton(
                      onPressed: () async {
                        punchIn = true;
                        Get.to(()=> const SiteLocationView());
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          backgroundColor: const Color(0xFF09a3f3), // Use the color #09a3f3
                          minimumSize: const Size(150, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                      child: const Text('Punch In'),
                    ),
                  // : Container(),
              // punchStatus == "true"
              //     ?
                  ElevatedButton(
                      onPressed: () {
                        punchIn = false;
                        Get.to(()=> const SiteLocationView());
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          backgroundColor:
                              const Color(0xFF09a3f3), // Use the color #09a3f3
                          minimumSize: const Size(150, 40),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      child: const Text('Punch Out'),
                    ),
                  // : Container(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
