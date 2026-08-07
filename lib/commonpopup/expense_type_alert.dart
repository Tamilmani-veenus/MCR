import '../controller/consumption_controller.dart';

import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ExpenseTypeAlert extends StatefulWidget {
  const ExpenseTypeAlert({Key? key}) : super(key: key);

  @override
  State<ExpenseTypeAlert> createState() => _ExpenseTypeAlertState();
}

class _ExpenseTypeAlertState extends State<ExpenseTypeAlert> {

  Consumption_Controller consumption_controller=Get.put(Consumption_Controller());

  final list=["Usage","Scrap","Repair"];

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
                child: Center(child: Text("Type",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,10),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  {
                          if(index==0){
                            consumption_controller.expenseTypeController.text="Usage";
                            consumption_controller.expenseType="EXP";
                          }
                          else if(index==1) {
                            consumption_controller.expenseTypeController.text="Scrap";
                            consumption_controller.expenseType="SCR";
                          }
                          else{
                            consumption_controller.expenseTypeController.text="Repair";
                            consumption_controller.expenseType="REP";
                          }
                          // dailyWrkDone_DPR_Controller.dpr_getSubcotType();
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
