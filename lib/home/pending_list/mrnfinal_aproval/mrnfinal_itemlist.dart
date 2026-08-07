
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_theme/app_colors.dart';
import '../../../commonpopup/mrnfinal_aproval_detalert.dart';
import '../../../controller/mrn_finalapproval_controller.dart';
import '../../../controller/mrn_preapproval_controller.dart';
import '../../../controller/mrn_request_indent_controller.dart';
import '../../../controller/pendinglistcontroller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/requestconstant.dart';
import '../onclickpending_list.dart';

class MrnfinalItemList extends StatefulWidget {
  const MrnfinalItemList({Key? key}) : super(key: key);

  @override
  State<MrnfinalItemList> createState() => _MrnfinalItemListState();
}

class _MrnfinalItemListState extends State<MrnfinalItemList> {
  PendingListController pendingListController=Get.put(PendingListController());
  MrnFinalApprovalController mrnFinalApprovalController=Get.put(MrnFinalApprovalController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  MrnPreApprovalController mrnPreApprovalController=Get.put(MrnPreApprovalController());
  List<String> list = ["PO","Rental WorkOrder","Transfer","Cancel","Pending"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Item List",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ))
                    ],
                  ),
                ),

                ListDetails(),
                // Container(
                //   height: BaseUtitiles.getheightofPercentage(context,4),
                //   margin: EdgeInsets.only(top: 15, bottom: 5),
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         primary: Theme.of(context).primaryColor,
                //         side: BorderSide(width: 3, color: Colors.black),
                //         elevation: 3,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30)),
                //       ),
                //       child: Text("Approve"),
                //       onPressed: ()  {
                //         if(check()){
                //           BaseUtitiles.showToast("Please select FromProject Name");
                //         }
                //         else{
                //          // BaseUtitiles.showToast("Success");
                //           showDialog(
                //             context: context,
                //             builder: (context) => AlertDialog(
                //               title: Text('Alert!'),
                //               content: Text('Do you want to Approve?'),
                //               actions: [
                //                 ElevatedButton(
                //                   onPressed: () => Navigator.of(context).pop(),
                //                   child: Text('No'),
                //                 ),
                //                 ElevatedButton(
                //                   onPressed: () {
                //                     Navigator.of(context).pop();
                //                     mrnFinalApprovalController.ApproveAPI(context);
                //                     Navigator.of(context).pop();
                //                   },
                //                   child: Text('Yes'),
                //                 ),
                //               ],
                //             ),
                //           );
                //         }
                //       }),
                // ),

              ],
            ),
          ),

          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                // Expanded(
                //   child: InkWell(
                //     child: Container(
                //       margin: EdgeInsets.only(left: 20, right: 20),
                //       height: BaseUtitiles.getheightofPercentage(context, 4),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         color: mrnFinalApprovalController.checkColor == 0
                //             ? Colors.white
                //             : Theme.of(context).primaryColor,
                //       ),
                //       alignment: Alignment.center,
                //       child: Text(
                //         "Reset",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: RequestConstant.Lable_Font_SIZE,
                //             color: mrnFinalApprovalController.checkColor == 0
                //                 ? Theme.of(context).primaryColor
                //                 : Colors.white),
                //       ),
                //     ),
                //     onTap: () {
                //       setState(() {
                //         mrnFinalApprovalController.checkColor = 1;
                //         ResetAlert(context);
                //       });
                //     },
                //   ),
                // ),

                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: mrnFinalApprovalController.checkColor == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(  RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: mrnFinalApprovalController.checkColor == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: () {
                    mrnFinalApprovalController.checkColor = 0;
                    if(check()){
                      BaseUtitiles.showToast("Please select FromProject Name");
                    }
                    // else if(mrnFinalApprovalController.projectId  ){
                    //
                    // }
                    else{
                      SubmitAlert(context);
                    }

                    // if(mrn_request_controller.Material_itemview_GetDbList.value.length < 1){
                    //   BaseUtitiles.showToast("Plese select item list");
                    // }
                    // else if (_formKey.currentState!.validate()) {
                    //   SubmitAlert(context);
                    // }
                    // else {
                    //
                    // }

                  },
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }


 bool check(){
    int i=0;
    var data=false;
    mrnFinalApprovalController.mrnfinalAppDetList.forEach((element) {
      mrnFinalApprovalController.itemlist_textControllersInitiate();
      if(mrnFinalApprovalController.Approval_ListController[i].text=="Transfer" && double.parse(mrnFinalApprovalController.projectId[i].text)==0){
        data=true;
      }
      i++;
    });
    return data;
  }

  // Widget ListDetails() {
  //   return
  //         Container(
  //           margin: EdgeInsets.only(top: 10),
  //           height: BaseUtitiles.getheightofPercentage(context,90),
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 height: BaseUtitiles.getheightofPercentage(context,85),
  //                 child: Obx(() => ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: BouncingScrollPhysics(),
  //                   padding: EdgeInsets.zero,
  //                   itemCount: mrnFinalApprovalController.mrnfinalAppDetList.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     mrnFinalApprovalController.itemlist_textControllersInitiate();
  //                     return Card(
  //                       color: Colors.white,
  //                       margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             margin: EdgeInsets.only(left: 5,right: 3,bottom: 3, top: 5),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Expanded(
  //                                   flex: 5,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(left: 5,right: 5,bottom:3, top: 5),
  //                                     child:  Text(mrnFinalApprovalController.mrnfinalAppDetList[index].material.toString()+" - " + mrnFinalApprovalController.mrnfinalAppDetList[index].scale.toString(),style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
  //                                   ),
  //                                 ),
  //
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: InkWell(
  //                                     child: Container(
  //                                       height: BaseUtitiles.getheightofPercentage(context, 3),
  //                                       width: BaseUtitiles.getWidthtofPercentage(context, 4),
  //                                       margin: EdgeInsets.only(left: 5,right: 5,bottom:3, top: 5),
  //                                       decoration: BoxDecoration(
  //                                         color: Theme.of(context).primaryColor,
  //                                         borderRadius: BorderRadius.circular(3),
  //                                       ),
  //                                       child: Icon(Icons.search_off, color: white,),
  //                                     ),
  //                                     onTap: (){
  //                                       mrnPreApprovalController.getStock_MaterialWise(
  //                                           mrnFinalApprovalController.mrnfinalAppDetList[index].materialid,
  //                                           mrnFinalApprovalController.mrnfinalAppDetList[index].material.toString(),
  //                                           mrnFinalApprovalController.mrnfinalAppDetList[index].scale.toString(),
  //                                           context);
  //                                     },
  //                                   ),
  //                                 ),
  //
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Expanded(
  //                                     flex: 2,
  //                                     child: Text("Bal Qty",style: TextStyle(color: Colors.black),)),
  //                                 Expanded(
  //                                   flex: 3,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(right: 11),
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     //width: BaseUtitiles.getWidthtofPercentage(context, 38),
  //                                     child:
  //                                     TextField(
  //                                       readOnly: true,
  //                                       cursorColor:Theme.of(context).primaryColor,
  //                                       textAlign: TextAlign.center,
  //                                       controller: mrnFinalApprovalController.BalQty_ListController[index],
  //                                       keyboardType: TextInputType.number,
  //                                       decoration: InputDecoration(
  //                                         contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                         focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                         enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                       ),
  //                                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                       onChanged: (value) {
  //
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                     flex: 2,
  //                                     child: Text("Req Qty",style: TextStyle(color: Colors.black),)),
  //                                 Expanded(
  //                                   flex: 3,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(right: 11),
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                    // width: BaseUtitiles.getWidthtofPercentage(context, 38),
  //                                     child:
  //                                     TextField(
  //                                       readOnly: true,
  //                                       cursorColor:Theme.of(context).primaryColor,
  //                                       textAlign: TextAlign.center,
  //                                       controller: mrnFinalApprovalController.ReqQty_ListController[index],
  //                                       keyboardType: TextInputType.number,
  //                                       decoration: InputDecoration(
  //                                         contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                         focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                         enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                       ),
  //                                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                       onChanged: (value) {
  //
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Expanded(
  //                                     flex: 2,
  //                                     child: Text("App Qty",style: TextStyle(color: Colors.black),)),
  //                                 Expanded(
  //                                   flex: 3,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(right: 11),
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     //width: BaseUtitiles.getWidthtofPercentage(context, 38),
  //                                     child:
  //                                     TextField(
  //                                       cursorColor:Theme.of(context).primaryColor,
  //                                       textAlign: TextAlign.center,
  //                                       controller: mrnFinalApprovalController.ApprQty_ListController[index],
  //                                       keyboardType: TextInputType.number,
  //                                       decoration: InputDecoration(
  //                                         contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                         focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                         enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                       ),
  //                                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                       onChanged: (value) {
  //                                         mrnFinalApprovalController.finalApproval_MaterialItemlist_clickEdit();
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                     flex: 2,
  //                                     child: Text("App Type",style: TextStyle(color: Colors.black),)),
  //                                 Expanded(
  //                                   flex: 3,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(right: 11),
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     child:
  //                                     TextField(
  //                                       readOnly: true,
  //                                       cursorColor:Theme.of(context).primaryColor,
  //                                       textAlign: TextAlign.center,
  //                                       controller: mrnFinalApprovalController.Approval_ListController[index],
  //                                       keyboardType: TextInputType.number,
  //                                       decoration: InputDecoration(
  //                                         contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                         focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                         enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                       ),
  //                                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                       onTap: (){
  //                                         setState(() {
  //                                           showDialog(
  //                                               context: context,
  //                                               builder: (BuildContext context) {
  //                                                 return MrnfinalApprovalDetAlert(data: mrnFinalApprovalController.mrnfinalAppDetList[index].reqMasDetId);
  //                                               });
  //                                         });
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //
  //
  //
  //                           Visibility(
  //                             visible:  mrnFinalApprovalController.Approval_ListController[index].text != "Transfer" ? false : true ,
  //                             child: Container(
  //                               margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Expanded(
  //                                       flex: 3,
  //                                       child: Text("Transfer From Project",style: TextStyle(color: Colors.black),)),
  //                                   Expanded(
  //                                     flex: 4,
  //                                     child: Container(
  //                                       margin: EdgeInsets.only(right: 11),
  //                                       height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                       //width: BaseUtitiles.getWidthtofPercentage(context, 38),
  //                                       child:
  //                                       TextField(
  //                                         readOnly: true,
  //                                         cursorColor:Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                         controller: mrnFinalApprovalController.TransfrProject_ListController[index],
  //                                         keyboardType: TextInputType.number,
  //                                         decoration: InputDecoration(
  //                                           contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                           focusedBorder: OutlineInputBorder(
  //                                               borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                               borderRadius: BorderRadius.all(
  //                                                   Radius.circular(10))),
  //                                           enabledBorder: OutlineInputBorder(
  //                                               borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                               borderRadius: BorderRadius.all(
  //                                                   Radius.circular(10))),
  //                                         ),
  //                                         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                       onTap: () async {
  //                                         await mrnFinalApprovalController.getProjectList(context,mrnFinalApprovalController.mrnfinalAppDetList[index].reqMasDetId);
  //                                       },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //
  //                           Container(
  //                             margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Expanded(
  //                                     flex: 3,
  //                                     child: Text("Description",style: TextStyle(color: Colors.black),)),
  //                                 Expanded(
  //                                   flex: 4,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(right: 11),
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     //width: BaseUtitiles.getWidthtofPercentage(context, 38),
  //                                     child:
  //                                     TextField(
  //                                       cursorColor:Theme.of(context).primaryColor,
  //                                       textAlign: TextAlign.center,
  //                                       controller: mrnFinalApprovalController.Description_ListController[index],
  //                                       decoration: InputDecoration(
  //                                         contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                         focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                         enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                       ),
  //                                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                       onChanged: (value) {
  //                                         mrnFinalApprovalController.finalApproval_updateConsumTables();
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Expanded(
  //                                     flex: 3,
  //                                     child: Text("Remarks",style: TextStyle(color: Colors.black),)),
  //                                 Expanded(
  //                                   flex: 4,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(right: 11),
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     //width: BaseUtitiles.getWidthtofPercentage(context, 38),
  //                                     child:
  //                                     TextField(
  //                                       cursorColor:Theme.of(context).primaryColor,
  //                                       textAlign: TextAlign.center,
  //                                       controller: mrnFinalApprovalController.Remarks_ListController[index],
  //                                       decoration: InputDecoration(
  //                                         contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                         focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                         enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10))),
  //                                       ),
  //                                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                       onChanged: (value) {
  //                                         mrnFinalApprovalController.finalApproval_updateConsumTables();
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //
  // }

  Widget ListDetails() {
    return
      Container(
        margin: EdgeInsets.only(top: 10),
        height: BaseUtitiles.getheightofPercentage(context,90),
        child: Column(
          children: <Widget>[
            Container(
              height: BaseUtitiles.getheightofPercentage(context,85),
              child: Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: mrnFinalApprovalController.mrnfinalAppDetList.length,
                itemBuilder: (BuildContext context, int index) {
                  mrnFinalApprovalController.itemlist_textControllersInitiate();
                  return Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5,right: 3,bottom: 3, top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child:  Text(mrnFinalApprovalController.mrnfinalAppDetList[index].material.toString()+" - " + mrnFinalApprovalController.mrnfinalAppDetList[index].scale.toString(),style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      child: Container(
                                        height: BaseUtitiles.getheightofPercentage(context, 3),
                                        width: BaseUtitiles.getWidthtofPercentage(context, 4),
                                        margin: const EdgeInsets.only(left: 5,right: 5,bottom:3, top: 5),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        child: Icon(Icons.search_off, color: white,),
                                      ),
                                      onTap: (){
                                        mrnPreApprovalController.getStock_MaterialWise(
                                            mrnFinalApprovalController.mrnfinalAppDetList[index].materialid,
                                            mrnFinalApprovalController.mrnfinalAppDetList[index].material.toString(),
                                            mrnFinalApprovalController.mrnfinalAppDetList[index].scale.toString(),
                                            context);
                                      },
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5,right: 3,top: 3,bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // const Expanded(
                                  //     flex: 2,
                                  //     child: Text("Bal Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                  // Expanded(
                                  //   flex: 3,
                                  //   child: Container(
                                  //     margin: const EdgeInsets.only(right: 11),
                                  //     height: BaseUtitiles.getheightofPercentage(context, 4),
                                  //     //width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                  //     child:
                                  //     TextField(
                                  //       readOnly: true,
                                  //       cursorColor:Theme.of(context).primaryColor,
                                  //       textAlign: TextAlign.center,
                                  //       controller: mrnFinalApprovalController.BalQty_ListController[index],
                                  //       keyboardType: TextInputType.number,
                                  //       decoration: InputDecoration(
                                  //         contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                  //         focusedBorder: OutlineInputBorder(
                                  //             borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                  //             borderRadius: BorderRadius.all(
                                  //                 Radius.circular(10))),
                                  //         enabledBorder: OutlineInputBorder(
                                  //             borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                  //             borderRadius: BorderRadius.all(
                                  //                 Radius.circular(10))),
                                  //       ),
                                  //       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
                                  //       onChanged: (value) {
                                  //
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text("Req Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 11),
                                      height: BaseUtitiles.getheightofPercentage(context, 4),
                                      child:
                                      TextField(
                                        readOnly: true,
                                        cursorColor:Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: mrnFinalApprovalController.ReqQty_ListController[index],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
                                        onChanged: (value) {

                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Text("App Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 11),
                                      height: BaseUtitiles.getheightofPercentage(context, 4),
                                      //width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                      child:
                                      TextField(
                                        cursorColor:Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: mrnFinalApprovalController.ApprQty_ListController[index],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                        ),
                                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
                                        onChanged: (value) {
                                            mrnFinalApprovalController.finalApproval_MaterialItemlist_clickEdit();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                      flex: 3,
                                      child: Text("App Type",style: TextStyle(color: Colors.black),)),
                                  Expanded(
                                    flex: 4,
                                    child: SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4,right: 11),
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              border: Border.all(color: Theme.of(context).primaryColor)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8, right: 16),
                                            child: DropdownButton(
                                                hint: const Text(
                                                  "Select",
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 20.0, color: Theme.of(context).primaryColor,
                                                ),
                                                isExpanded: true,
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                value: mrnFinalApprovalController.Approval_ListController[index].text,
                                                underline: const SizedBox(),
                                                items: list.map((items) {
                                                  return DropdownMenuItem(
                                                    value: items.toString(),
                                                    child: Align(alignment: Alignment.center,child: Text(items.toString(),style: const TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) async {
                                                  setState(() {
                                                    mrnFinalApprovalController.Approval_ListController[index].text = value!;
                                                    mrnFinalApprovalController.approvalType = value;
                                                    mrnFinalApprovalController.projectId[index].text = "0";
                                                    mrnFinalApprovalController.Approval_ListController[index].text != "Transfer"
                                                        ? mrnFinalApprovalController.TransfrProject_ListController[index].text = "--Select--"  : null;
                                                  });

                                                  // for (int i = 0; i < list.length; i++) {
                                                  //   mrnFinalApprovalController.Approval_ListController[i].text =
                                                  //   mrnFinalApprovalController.approvalType!;
                                                  //   mrnFinalApprovalController.itemlist_textControllersInitiate();
                                                  //
                                                  //   if (mrnFinalApprovalController.approvalType == list[i].toString()) {
                                                  //     mrnFinalApprovalController.Approval_ListController[i].text =
                                                  //         list[i].toString();
                                                  //   }
                                                  //
                                                  //   print(mrnFinalApprovalController.Approval_ListController[i].text);
                                                  // }
                                                  await mrnFinalApprovalController.finalApproval_updateConsumTables();
                                                }
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),



                            Visibility(
                              visible:  mrnFinalApprovalController.Approval_ListController[index].text != "Transfer" ? false : true ,
                              child: Container(
                                margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                        flex: 3,
                                        child: Text("Transfer From Project",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 11),
                                        height: BaseUtitiles.getheightofPercentage(context, 4),
                                        //width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                        child: TextField(
                                          readOnly: true,
                                          cursorColor:Theme.of(context).primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: mrnFinalApprovalController.TransfrProject_ListController[index],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14.0),
                                          onTap: () async {
                                            // await mrnFinalApprovalController.getProjectList(context,mrnFinalApprovalController.mrnfinalAppDetList[index].reqMasDetId);
                                            await mrnFinalApprovalController.gettingProjectName(mrnFinalApprovalController.mrnfinalAppDetList[index].reqMasDetId,mrnFinalApprovalController.mrnfinalAppDetList[index].materialid,projectController.selectedProjectId.value,context);

                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Text("Description",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 11),
                                      height: BaseUtitiles.getheightofPercentage(context, 4),
                                      //width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                      child:
                                      TextField(
                                        cursorColor:Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: mrnFinalApprovalController.Description_ListController[index],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
                                        onChanged: (value) {
                                          mrnFinalApprovalController.finalApproval_updateConsumTables();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Text("Remarks",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 11),
                                      height: BaseUtitiles.getheightofPercentage(context, 4),
                                      //width: BaseUtitiles.getWidthtofPercentage(context, 38),
                                      child:
                                      TextField(
                                        cursorColor:Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: mrnFinalApprovalController.Remarks_ListController[index],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
                                        onChanged: (value) {
                                          mrnFinalApprovalController.finalApproval_updateConsumTables();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              ),
            ),
          ],
        ),
      );

  }

  // Future ResetAlert(BuildContext context) async {
  //   return await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Alert!'),
  //       content: Text('Are you sure to Reset?'),
  //       actions:[
  //         Container(
  //           margin: EdgeInsets.only(left: 20,right: 20),
  //           child: IntrinsicHeight(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Expanded(
  //                   child: TextButton(onPressed: (){
  //                     Navigator.pop(context);
  //                   }, child: Text("Cancle", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
  //                 ),
  //                 VerticalDivider(
  //                   color: Colors.grey.shade400,  //color of divider
  //                   width: 5, //width space of divider
  //                   thickness: 2, //thickness of divier line
  //                   indent: 15, //Spacing at the top of divider.
  //                   endIndent: 15, //Spacing at the bottom of divider.
  //                 ),
  //                 Expanded(
  //                   child: TextButton(
  //                       onPressed: ()  {
  //                         pendingListController.mrnfinalapprovallist.forEach((element) {
  //                           mrnFinalApprovalController.RequestNoText.text=element.no.toString();
  //                           mrnFinalApprovalController.RequestDateText.text=element.date.toString();
  //                           mrnFinalApprovalController.DueDateText.text=element.dueDate.toString();
  //                           mrnFinalApprovalController.ApprovalNoText.text=element.appNo.toString();
  //                           projectController.projectname.text=element.projectName.toString();
  //                           projectController.selectedProjectId.value=element.ProjectId!;
  //                           siteController.selectedsiteId.value=element.SiteId!;
  //                           siteController.Sitename.text=element.siteName.toString();
  //                           mrnFinalApprovalController.PreparedbyText.text=element.preparedBy.toString();
  //                           mrnFinalApprovalController.ApprovalDateText.text=BaseUtitiles.initiateCurrentDateFormat();
  //                           mrnFinalApprovalController.ApprovedbyText.text=element.PreapprovedBy.toString();
  //                           mrnFinalApprovalController.VerifiedbyText.text=element.VerifiedBy.toString();
  //                         });
  //                         int i=0;
  //                         pendingListController.mrnfinalAppDetList.forEach((element) {
  //                           mrnFinalApprovalController.itemlist_textControllersInitiate();
  //                           mrnFinalApprovalController.BalQty_ListController[i].text=element.balQty.toString();
  //                           mrnFinalApprovalController.ReqQty_ListController[i].text=element.reqQty.toString();
  //                           mrnFinalApprovalController.ApprQty_ListController[i].text=element.qty.toString();
  //                           mrnFinalApprovalController.Approval_ListController[i].text=element.appType=="P"?"PO" : element.appType=="O"? "Rentel WorkOder" :  element.appType=="I"? "Cash Inward" : element.appType=="T" ? "Transfer" : element.appType=="C" ? "Cancel" :  element.appType=="W" ? "Pending" : "" ;
  //                           mrnFinalApprovalController.TransfrProject_ListController[i].text=element.project.toString();
  //                           mrnFinalApprovalController.projectId[i].text=element.refProjectid.toString();
  //
  //                           // mrnFinalApprovalController.Approval_ListController[i].text=element.type=="P"?"PO":element.type=="H"?"Cash PO":element.type=="O"?"Rental Workorder":element.type=="I"?"Petty Cash":element.type=="T"?"Transfer":element.type=="C"?"Cancel":"Pending";
  //                           // mrnFinalApprovalController.TransfrProject_ListController[i].text=element.Project.toString();
  //                           // mrnFinalApprovalController.projectId[i].text=element.refProjectid.toString();
  //                           i++;
  //                         });
  //                         mrnFinalApprovalController.entrycheck=1;
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text("Reset", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //
  //       ],
  //     ),
  //   );
  // }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(
            'Are you sure to Approval?' ),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
    if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
      await mrnFinalApprovalController
          .getFinalApp_MaterialsItemlist_TableDatas();
      await mrnFinalApprovalController.ApproveAPI(context);
    }                        },
                        child: Text(  RequestConstant.APPROVAL,
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),

          // ElevatedButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   child:Text('No'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     entrycheck=0;
          //     editCheck=0;
          //     Material_EntryList_DeleteApi(MrnReqEtyList.value[index].reqMasId,MrnReqEtyList.value[index].reqOrdNo);
          //     MrnReqEtyList.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),

        ],
      ),
    );
  }

}
