
import 'package:flutter/material.dart';
import '../../../../utilities/baseutitiles.dart';

import '../../../../utilities/requestconstant.dart';
class ApprovedAlertPopup extends StatefulWidget {
  const ApprovedAlertPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<ApprovedAlertPopup> createState() => _ApprovedAlertPopupState();
}

class _ApprovedAlertPopupState extends State<ApprovedAlertPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade800,
          child: Column(
            children: <Widget>[

              Container(
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context, 55),
                child: ListView.builder(
                    itemCount: widget.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.blueGrey,
                        child: Container(
                          margin: EdgeInsets.only(top: 4,left: 3,right: 2,bottom: 2),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Date              ",style: TextStyle(color: Colors.white)),
                                  Text(widget.list[index].labrAttnDate.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold,color: Colors.yellow)),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Atten No",style: TextStyle(color: Colors.white)),
                                    Text(widget.list[index].labrAttnNo.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold,color: Colors.yellow)),
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Status",style: TextStyle(color: Colors.white)),
                                    Text(widget.list[index].appStatus.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold,color: Colors.yellow)),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
