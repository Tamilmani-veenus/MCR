import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mcr/home/dashboard/radius_view.dart';
import 'package:mcr/home/dashboard/search_field.dart';
import 'package:mcr/home/dashboard/radius_view.dart';
import 'package:mcr/home/dashboard/search_field.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/logincontroller.dart';
import '../../controller/punch_in_controller.dart';
import '../../controller/site_location_controller.dart';
import '../../splash/splash.dart';
import '../../utilities/baseutitiles.dart';
import '../punch_in_out/punch_in.dart';
import '../punch_in_out/punch_out.dart';



class SiteLocationView extends StatefulWidget {
  const SiteLocationView({super.key});

  @override
  State<SiteLocationView> createState() => _SiteLocationViewState();
}

class _SiteLocationViewState extends State<SiteLocationView> {

  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  LoginController loginController = Get.put(LoginController());
  static const IconData fingerprintOutlined = IconData(0xf075, fontFamily: 'MaterialIcons');
  PunchInController punchInController = Get.put(PunchInController());

  @override
  void initState() {
    if(netWorkStatus == true) {
      siteLocationController.getProjectName();
    }
    punchInController.getOndutyPunchInSts();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      siteLocationController.projectNameSearch.text = "";
    });    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return WillPopScope(
      onWillPop: () async {
        punchIn = false;
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Select your project name",
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 20.r,
                ),
                onPressed: () {
                  Get.back();
                  punchIn = false;
                }),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

              // Card(elevation: 8,
              //   child: Container(
              //     padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
              //     width: MediaQuery.sizeOf(context).width,
              //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'On Duty',
              //           overflow: TextOverflow.ellipsis,
              //           style: TextStyle(
              //             fontSize: ScreenUtil().setSp(14),
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         GestureDetector(
              //           onTap: () async {
              //             var punchStatus=siteLocationController.projectNameList?.map((value)=>value.punchStatus).toList();
              //
              //               if(punchStatus?.contains("True")==true){
              //                 Fluttertoast.showToast(msg: "You are not in On Duty");
              //               }else{
              //                 if (punchInController.resPunchSts.value=="false" && punchInController.isOnDuty.value==0 ) {
              //                   setState(() {
              //                     punchInController.isOnDuty.value=1;
              //                     punchInController.update();
              //                   });
              //                   await Get.to(()=>PunchIn(
              //                       latitude: "",
              //                       longitude: "",
              //                       radius: ""));
              //                 }
              //                 else{
              //                   await Get.to(()=>PunchOut(
              //                       latitude: "",
              //                       longitude: "",
              //                       radius: ""));
              //                 }
              //               }
              //
              //           },
              //           child: Container(
              //                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              //             // height: MediaQuery.sizeOf(context).height*0.05,
              //             decoration: BoxDecoration(
              //               color: Theme.of(context).primaryColor,
              //               borderRadius: BorderRadius.all(
              //                 Radius.circular(10),
              //               ),
              //               gradient: LinearGradient(
              //                 begin: Alignment.topLeft,
              //                 end: Alignment.bottomRight,
              //                 colors: [
              //                   purple,
              //                   blue,
              //                 ],
              //               ),
              //             ),
              //             child: Row(
              //               children: [
              //                 Icon((punchInController.isOnDuty.value==1 && punchInController.resPunchSts.value=="true")?Icons.arrow_circle_left_outlined:Icons.arrow_circle_right_outlined,color: Colors.white,),
              //                 Obx(()=>
              //                    Text(
              //                      punchInController.isOnDuty.value==1 && punchInController.resPunchSts.value=="true"? ' Punch Out':' Punch In',
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: ScreenUtil().setSp(14),
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              Expanded(
                flex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        "Search",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 16.r,
                        left: 16.r,
                      ),
                      child: TextInputSearchField(
                        keyboardType: TextInputType.text,
                        hintText: "Search",
                        controller: siteLocationController.projectNameSearch,
                        onChange: (value) {
                          if(netWorkStatus == true) {
                            setState(() {
                              Future.delayed(
                                  const Duration(seconds: 0), () async {
                                await siteLocationController.getProjectName();
                              });
                            });
                            setState(() {});
                            Future.delayed(const Duration(seconds: 1), () async {
                              setState(() {
                                siteLocationController.getProjectName();
                              });
                            });
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        "Discover your project",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AzoSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.only(top: 4.r, right: 4.r, left: 4.r),
                    child: siteLocationController.projectNameList!.isNotEmpty
                        ? ListView.builder(
                      itemCount: siteLocationController.projectNameList!.length,
                      itemBuilder: (context, i) {
                        return StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              return GestureDetector(
                                onTap: () async {

                                  var punchStatus=siteLocationController.projectNameList?.map((value)=>value.punchStatus).toList();

                                  FocusScope.of(context).unfocus();
                                  siteLocationController.projectNameSearch.text = "";
                                  if (loginController.user.value.userType == "A") {
                                    siteLocationController.projectId = siteLocationController.projectNameList![i].projectId.toString();

                                    Get.to(() => RadiusView(ProjectId: siteLocationController.projectId));
                                  }
                                  else {
                                    if(netWorkStatus == true){
                                      await loginController.getPunchInStatus();
                                    }
                                    //first punch in
                                    if (punchIn == true && punchInController.resPunchSts.value=="false" && punchInController.isOnDuty.value==0) {
                                      if (siteLocationController.projectNameList![i].pinStatus == "True" && punchStatus!.every((status) => status == "False") ?? false) {
                                        siteLocationController.projectId = siteLocationController.projectNameList![i].projectId.toString();
                                        siteLocationController.locId = siteLocationController.projectNameList![i].locid.toString();
                                        Get.to(()=>PunchIn(
                                            latitude: siteLocationController.projectNameList![i].latitude.toString(),
                                            longitude: siteLocationController.projectNameList![i].longitude.toString(),
                                            radius: siteLocationController.projectNameList![i].radius.toString()));
                                      }

                                      else {
                                        Fluttertoast.showToast(msg: "This project doesn't pin the map");
                                      }
                                    }
                                    //already punch in
                                    else if(punchStatus?.contains("True") == true && punchIn == true && punchInController.resPunchSts.value=="true"){
                                      Fluttertoast.showToast(msg: "Already Punch In made");
                                    }
                                    //first punch out
                                    else if(punchIn == false && punchInController.resPunchSts.value=="true"){
                                      if (siteLocationController.projectNameList![i].punchStatus == "False" && siteLocationController.projectNameList![i].pinStatus == "True")
                                      {
                                        siteLocationController.projectId = siteLocationController.projectNameList![i].projectId.toString();
                                        siteLocationController.locId = siteLocationController.projectNameList![i].locid.toString();
                                        print("sssss...${siteLocationController.locId}");
                                        // punchInController.punchInID.value = siteLocationController.projectNameList![i].punchID.toString();
                                        punchInController.update();
                                        Get.to(() => PunchOut(
                                            latitude: siteLocationController.projectNameList![i].latitude.toString(),
                                            longitude: siteLocationController.projectNameList![i].longitude.toString(),
                                            radius: siteLocationController.projectNameList![i].radius.toString()));
                                      }
                                      else if(siteLocationController.projectNameList![i].punchStatus == "False" && siteLocationController.projectNameList![i].pinStatus == "False"){
                                        Fluttertoast.showToast(msg: "This project doesn't pin the map");
                                      }
                                      else{
                                        Fluttertoast.showToast(msg: "Can't allow");
                                      }
                                    }
                                    //punchout without punchin
                                    else if(punchIn == false && punchInController.resPunchSts.value=="false" && punchStatus?.contains("False") == true) {
                                      Fluttertoast.showToast(msg: "Can't allow without Punch In");
                                    }
                                    else {
                                      Fluttertoast.showToast(msg: "Please check On duty punch status");
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 4.r),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: Color(0xFFF5F5F5),
                                            child: ConstIcons.projectName,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(16.r),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 250.r,
                                                    child: Text(
                                                      siteLocationController.projectNameList![i].projectName.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil().setSp(14),
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          siteLocationController.projectNameList![i].punchStatus == "True" ? Padding(
                                            padding: EdgeInsets.only(right: 8.r),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Icon(fingerprintOutlined,size: 25,
                                                    // color: Color(0xFF69e772)
                                                    color: Colors.red
                                                ),
                                              ),
                                            ),
                                          ) : Container(),
                                          siteLocationController.projectNameList![i].pinStatus.toString() == "True"
                                              ? Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Image.asset("assets/select_check.png"),
                                            ),
                                          )
                                              : Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: const Color(0xFF69e772)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black12,
                                        height: 2,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    )
                        : const SizedBox(
                      child: Center(
                        child: Text(
                          "No details found",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
