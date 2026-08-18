import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/attendancecontroller.dart';
import '../controller/dailyentries_controller.dart';
import '../controller/dailywrk_done_dpr_controller.dart';
import '../controller/dailywrk_done_dprnew_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

//-----DPR------------
class WorkTypeAlert extends StatefulWidget {
  const WorkTypeAlert({Key? key}) : super(key: key);

  @override
  State<WorkTypeAlert> createState() => _WorkTypeAlertState();
}

class _WorkTypeAlertState extends State<WorkTypeAlert> {

  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());

  final list=["NMR","RATE"];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: Center(child: Text("Work Type",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,10),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  {
                          if(index==0){
                            dailyEntriesController.WorkTypeTextController.text="NMR";
                            dailyEntriesController.Nmr_Rate.value = RequestConstant.N;
                          }
                          else {
                            dailyEntriesController.WorkTypeTextController.text="RATE";
                            dailyEntriesController.Nmr_Rate.value = RequestConstant.R;

                          }
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width:
                                    BaseUtitiles.getWidthtofPercentage(
                                        context, 60),
                                    child: Text(list[index]
                                        .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(
                                  color: Theme.of(context).primaryColorLight,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---------DPR REPORT-------------
class wrkTypeAlertAll extends StatefulWidget {
  const wrkTypeAlertAll({Key? key}) : super(key: key);

  @override
  State<wrkTypeAlertAll> createState() => _wrkTypeAlertAllState();
}

class _wrkTypeAlertAllState extends State<wrkTypeAlertAll> {
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());

  final list=["ALL","NMR","RATE"];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              color: Theme.of(context).primaryColor,
              child: Center(child: Text("Work Type",style: TextStyle(color: Colors.white),)),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context,13),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: ()  {
                        if(index==0){
                          dailyWrkDone_DPR_Controller.workType_DPR_Controller.text="ALL";
                          dailyWrkDone_DPR_Controller.wrktype_DPR.value = "0";
                        }
                        else if(index==1){
                          dailyWrkDone_DPR_Controller.workType_DPR_Controller.text="NMR";
                          dailyWrkDone_DPR_Controller.wrktype_DPR.value = "NMR";
                        }
                        else {
                        dailyWrkDone_DPR_Controller.workType_DPR_Controller.text="RATE";
                        dailyWrkDone_DPR_Controller.wrktype_DPR.value= "RATE";
                        }
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width:
                                  BaseUtitiles.getWidthtofPercentage(
                                      context, 60),
                                  child: Text(list[index]
                                      .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                              Divider(
                                color: Theme.of(context).primaryColorLight,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

//--------Attendance Report-----------

class WorkType_AttendRPT extends StatefulWidget {
  const WorkType_AttendRPT({Key? key}) : super(key: key);

  @override
  State<WorkType_AttendRPT> createState() => _WorkType_AttendRPTState();
}

class _WorkType_AttendRPTState extends State<WorkType_AttendRPT> {
  AttendanceController attendanceController =Get.put(AttendanceController());

  final list=["NMR","RATE"];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              color: Theme.of(context).primaryColor,
              child: Center(child: Text("Work Type",style: TextStyle(color: Colors.white),)),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context,13),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: ()  {
                        if(index==0){
                          attendanceController.workTypeController.text="NMR";
                          attendanceController.wrktype.value = "NMR";
                        }
                        else {
                          attendanceController.workTypeController.text="RATE";
                          attendanceController.wrktype.value= RequestConstant.R;
                        }
                        attendanceController.attendanceDatas.value.clear();
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width:
                                  BaseUtitiles.getWidthtofPercentage(
                                      context, 60),
                                  child: Text(list[index]
                                      .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                              Divider(
                                color: Theme.of(context).primaryColorLight,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

