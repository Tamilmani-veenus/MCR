import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcr/newhome/reports/punch_reports/punch_in_out_reports.dart';
import '../../../utilities/baseutitiles.dart';
import '../../app_theme/app_colors.dart';
import '../../controller/attendancecontroller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/punch_in_controller.dart';
import '../../controller/staffcontroller.dart';
import '../../controller/stocksite_controller.dart';
import '../../home/attendance_report/attendance_report.dart';
import '../../home/dpr_report/dpr_report.dart';
import '../../home/inward_report/inward_report.dart';
import '../../home/mrn_report/mrn_report.dart';
import '../../home/mrn_req_tracker_report/mrn_req_tracker_report.dart';
import '../../home/stock_site/stock_site.dart';
import '../maindashboard/dashboard.dart';
import '../maindashboard/dashboard_otheruser.dart';

class Reports_screen extends StatefulWidget {
  const Reports_screen({Key? key}) : super(key: key);

  @override
  State<Reports_screen> createState() => _Reports_screenState();
}

class _Reports_screenState extends State<Reports_screen> {
  LoginController loginController = Get.put(LoginController());
  PunchInController punchInController = Get.put(PunchInController());
  StaffController staffController = Get.put(StaffController());
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final StockSiteController stockSiteController =
      Get.put(StockSiteController());
  static const IconData fingerprintOutlined =
      IconData(0xf075, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    stockSiteController.projectShowList.value.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      body: SingleChildScrollView(
        child: WillPopScope(
          onWillPop: () => homeScreen(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: BaseUtitiles.getheightofPercentage(context, 15),
                      width: BaseUtitiles.getWidthtofPercentage(context, 45),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.indigo.shade50,
                                      child: Icon(
                                        Icons.read_more,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  const Text("Attendance Report"),
                                ],
                              )),
                          onTap: () {
                            attendanceController.attendanceDatas.value.clear();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AttendanceReport()));
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        height: BaseUtitiles.getheightofPercentage(context, 15),
                        width: BaseUtitiles.getWidthtofPercentage(context, 45),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.indigo.shade50,
                                      child: Icon(Icons.add_business,
                                          size: 30,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const Text("DPR Report"),
                                ],
                              )),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DPRReport()));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: BaseUtitiles.getheightofPercentage(context, 15),
                      width: BaseUtitiles.getWidthtofPercentage(context, 45),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.indigo.shade50,
                                      child: Icon(Icons.add_card,
                                          size: 30,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  Text("MRN Report"),
                                ],
                              )),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MRNReport()));
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: BaseUtitiles.getheightofPercentage(context, 15),
                        width: BaseUtitiles.getWidthtofPercentage(context, 45),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.indigo.shade50,
                                      child: Icon(Icons.add_chart,
                                          size: 30,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const Text("Inward Report"),
                                ],
                              )),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const InwardReport()));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: SizedBox(
                        height: BaseUtitiles.getheightofPercentage(context, 15),
                        width: BaseUtitiles.getWidthtofPercentage(context, 45),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.indigo.shade50,
                                      child: Icon(Icons.compare_arrows_rounded,
                                          size: 30,
                                          color: Theme.of(context).primaryColor)),
                                  const Text("Stock at site"),
                                ],
                              )),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const StockSite()));
                      },
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        height: BaseUtitiles.getheightofPercentage(context, 15),
                        width: BaseUtitiles.getWidthtofPercentage(context, 45),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.indigo.shade50,
                                      child: Icon(
                                          fingerprintOutlined,
                                          size: 30,
                                          color: Theme.of(context).primaryColor)),
                                  const Text("Punch reports"),
                                ],
                              )),
                        ),
                      ),
                      onTap: () async {
                        punchInController.todayDate.text = BaseUtitiles.initiateCurrentDateFormat();
                        await punchInController.todayPunchInController(punchInController.todayDate.text);
                        punchInController.fromDate.text = BaseUtitiles.initiateCurrentDateFormat();
                        punchInController.toDate.text = BaseUtitiles.initiateCurrentDateFormat();
                        punchInController.punchFilterList!.clear();
                        punchInController.punchFilterRxList.value=[];
                        if (loginController.user.value.userType == "A") {
                          staffController.Staffname.text = "SELECT";
                          staffController.selectedstaffId.value = 0;
                          await staffController.get_staffDropdowntList(context);
                        }else {
                          staffController.Staffname.text = loginController.user.value.empName.toString();
                          staffController.selectedstaffId.value = loginController.user.value.empId!;
                          await punchInController.punchFilterController(punchInController.fromDate.text, punchInController.toDate.text, staffController.selectedstaffId.value,
                          );
                        }
                        Get.to(() => const PunchInOutReports());

                      }
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: SizedBox(
                        height: BaseUtitiles.getheightofPercentage(context, 15),
                        width: BaseUtitiles.getWidthtofPercentage(context, 45),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.indigo.shade50,
                                      child: Icon(Icons.track_changes,
                                          size: 30,
                                          color: Theme.of(context).primaryColor)),
                                  const Text("MRN - Request Tracker"),
                                ],
                              )),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MRN_ReqTracker_Report()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  homeScreen() {
    if (loginController.user.value.userType == "A") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Dashboard_screen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
    }
  }
}
