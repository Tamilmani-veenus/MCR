import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/fromproject_ccontroller.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/mrn_preapproval_controller.dart';
import '../../../controller/mrn_request_indent_controller.dart';
import '../../../controller/pendinglistcontroller.dart';
import '../../../controller/projectcontroller.dart';
import '../../../controller/sitecontroller.dart';
import '../../../utilities/baseutitiles.dart';
import '../../../utilities/requestconstant.dart';


class MrnPreapprovalItemlist extends StatefulWidget {
  const MrnPreapprovalItemlist({Key? key}) : super(key: key);

  @override
  State<MrnPreapprovalItemlist> createState() => _MrnPreapprovalItemlistState();
}

class _MrnPreapprovalItemlistState extends State<MrnPreapprovalItemlist> {

  PendingListController pendingListController=Get.put(PendingListController());
  MrnPreApprovalController mrnPreApprovalController=Get.put(MrnPreApprovalController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  LoginController loginController=Get.put(LoginController());
  FromProjectController fromprojectController = Get.put(FromProjectController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  List<String> list = ["PO","Rental WorkOrder","Transfer","Cancel","Pending"];

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
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Item List",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
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
                //           // BaseUtitiles.showToast("Success");
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
                //                     mrnPreApprovalController.ApproveAPI(context);
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
                //         color: mrnPreApprovalController.checkColor == 0
                //             ? Colors.white
                //             : Theme.of(context).primaryColor,
                //       ),
                //       alignment: Alignment.center,
                //       child: Text(
                //         "Reset",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: RequestConstant.Lable_Font_SIZE,
                //             color: mrnPreApprovalController.checkColor == 0
                //                 ? Theme.of(context).primaryColor
                //                 : Colors.white),
                //       ),
                //     ),
                //     onTap: () {
                //       setState(() {
                //         mrnPreApprovalController.checkColor = 1;
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
                      color: mrnPreApprovalController.checkColor == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text( "Pre Approve",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: mrnPreApprovalController.checkColor == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: () {
                    mrnPreApprovalController.checkColor = 0;
                    if(check()){
                      BaseUtitiles.showToast("Please select FromProject Name");
                    }else{
                      SubmitAlert(context);
                    }
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
    mrnPreApprovalController.mrnPreAppDetList.forEach((element) {
      mrnPreApprovalController.itemlist_textControllersInitiate();
      if(mrnPreApprovalController.mrnpre_Approval_ListController[i].text=="Transfer" && double.parse(mrnPreApprovalController.mrnpre_projectId[i].text)==0){
        data=true;
      }
      i++;
    });
    return data;
  }

  // Widget ListDetails() {
  //   return Container(
  //           margin: EdgeInsets.only(top: 10),
  //           height: BaseUtitiles.getheightofPercentage(context,83),
  //           child: Column(
  //             children: <Widget>[
  //               Expanded(
  //                 child: Container(
  //                   margin: EdgeInsets.only(top: 10),
  //                   height: BaseUtitiles.getheightofPercentage(context,80),
  //                   child: Obx(() => ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: BouncingScrollPhysics(),
  //                     padding: EdgeInsets.zero,
  //                     itemCount: mrnPreApprovalController.MaterialAppr_itemview_GetDbList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       mrnPreApprovalController.itemlist_textControllersInitiate();
  //                       return Card(
  //                         color: Colors.white,
  //                         margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   flex: 5,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(left: 5,right: 5,bottom:3, top: 5),
  //                                     child: Text(mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialname.toString()+" - "+mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].scale.toString(),style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
  //                                   ),
  //                                 ),
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
  //                                           mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialid,
  //                                           mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialname.toString(),
  //                                           mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].scale.toString(),
  //                                           context);
  //                                     },
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             Container(
  //                               margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Expanded(
  //                                       flex: 2,
  //                                       child: Text("Bal Qty",style: TextStyle(color: Colors.black),)),
  //                                   Expanded(
  //                                     flex: 3,
  //                                     child: Container(
  //                                       margin: EdgeInsets.only(right: 11),
  //                                       height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                       //width: BaseUtitiles.getWidthtofPercentage(context, 38),
  //                                       child:
  //                                       TextField(
  //                                         readOnly: true,
  //                                         cursorColor:Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                        controller: mrnPreApprovalController.mrnpre_BalQty_ListController[index],
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
  //                                         onChanged: (value) {
  //
  //                                         },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Expanded(
  //                                       flex: 2,
  //                                       child: Text("Req Qty",style: TextStyle(color: Colors.black),)),
  //                                   Expanded(
  //                                     flex: 3,
  //                                     child: Container(
  //                                       margin: EdgeInsets.only(right: 11),
  //                                       height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                       child:
  //                                       TextField(
  //                                         readOnly: true,
  //                                         cursorColor:Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                        controller: mrnPreApprovalController.mrnpre_ReqQty_ListController[index],
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
  //                                         onChanged: (value) {
  //
  //                                         },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Container(
  //                               margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Expanded(
  //                                       flex: 2,
  //                                       child: Text("App Qty",style: TextStyle(color: Colors.black),)),
  //                                   Expanded(
  //                                     flex: 3,
  //                                     child: Container(
  //                                       margin: EdgeInsets.only(right: 11),
  //                                       height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                       child:
  //                                       TextField(
  //                                         cursorColor:Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                         controller: mrnPreApprovalController.mrnpre_ApprQty_ListController[index],
  //                                         keyboardType: TextInputType.number,
  //                                         decoration: InputDecoration(
  //                                           contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                           focusedBorder: OutlineInputBorder(
  //                                               borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                               borderRadius: BorderRadius.all(Radius.circular(10))),
  //                                           enabledBorder: OutlineInputBorder(
  //                                               borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                               borderRadius: BorderRadius.all(Radius.circular(10))),
  //                                         ),
  //                                         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                         onChanged: (value) {
  //                                           mrnPreApprovalController.Approval_MaterialItemlist_clickEdit();
  //                                         },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Expanded(
  //                                       flex: 2,
  //                                       child: Text("Approval",style: TextStyle(color: Colors.black),)),
  //                                   Expanded(
  //                                     flex: 3,
  //                                     child: Container(
  //                                       margin: EdgeInsets.only(right: 11),
  //                                       height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                       child:
  //                                       TextField(
  //                                         readOnly: true,
  //                                         cursorColor:Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                         controller: mrnPreApprovalController.mrnpre_Approval_ListController[index],
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
  //                                         onTap: (){
  //                                           setState(() {
  //                                             showDialog(
  //                                                 context: context,
  //                                                 builder: (BuildContext context) {
  //                                                   return MrnPreapprovalDetAlert(data: mrnPreApprovalController.mrnPreAppDetList[index].reqMasDetId);
  //                                                 });
  //                                           });
  //
  //                                         },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //
  //                             Visibility(
  //                               visible:  mrnPreApprovalController.mrnpre_Approval_ListController[index].text != "Transfer" ? false : true,
  //                               child: Container(
  //                                 margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                                 child: Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Expanded(
  //                                         flex: 3,
  //                                         child: Text("Transfer From Project",style: TextStyle(color: Colors.black),)),
  //                                     Expanded(
  //                                       flex: 4,
  //                                       child: Container(
  //                                         margin: EdgeInsets.only(right: 11),
  //                                         height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                         child:
  //                                         TextField(
  //                                           readOnly: true,
  //                                           cursorColor:Theme.of(context).primaryColor,
  //                                           textAlign: TextAlign.center,
  //                                           controller: mrnPreApprovalController.mrnpre_TransfrProject_ListController[index],
  //                                           keyboardType: TextInputType.number,
  //                                           decoration: InputDecoration(
  //                                             contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
  //                                             focusedBorder: OutlineInputBorder(
  //                                                 borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                                 borderRadius: BorderRadius.all(Radius.circular(10))),
  //                                             enabledBorder: OutlineInputBorder(
  //                                                 borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                                 borderRadius: BorderRadius.all(
  //                                                     Radius.circular(10))),
  //                                           ),
  //                                           style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
  //                                           onTap: () async {
  //                                              await mrnPreApprovalController.getProjectList(context,mrnPreApprovalController.mrnPreAppDetList[index].reqMasDetId);
  //                                             // await bottomsheetControllers.FromProjectName(context, fromprojectController.getdropDownvalue.value);
  //                                             // await bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
  //                                           },
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //
  //                             Container(
  //                               margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Expanded(
  //                                       flex: 3,
  //                                       child: Text("Description",style: TextStyle(color: Colors.black),)),
  //                                   Expanded(
  //                                     flex: 4,
  //                                     child: Container(
  //                                       margin: EdgeInsets.only(right: 11),
  //                                       height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                       child:
  //                                       TextField(
  //                                         cursorColor:Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                         controller: mrnPreApprovalController.mrnpre_Description_ListController[index],
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
  //                                         onChanged: (value) {
  //                                           mrnPreApprovalController.Approval_updateConsumTables();
  //                                         },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Container(
  //                               margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 8),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Expanded(
  //                                       flex: 3,
  //                                       child: Text("Remarks",style: TextStyle(color: Colors.black),)),
  //                                   Expanded(
  //                                     flex: 4,
  //                                     child: Container(
  //                                       margin: EdgeInsets.only(right: 11),
  //                                       height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                       //width: BaseUtitiles.getWidthtofPercentage(context, 38),
  //                                       child:
  //                                       TextField(
  //                                         cursorColor:Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                        controller: mrnPreApprovalController.mrnpre_Remarks_ListController[index],
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
  //                                         onChanged: (value) {
  //                                           mrnPreApprovalController.Approval_updateConsumTables();
  //                                         },
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  // }


  Widget ListDetails() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: BaseUtitiles.getheightofPercentage(context,83),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: BaseUtitiles.getheightofPercentage(context,80),
              child: Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: mrnPreApprovalController.MaterialAppr_itemview_GetDbList.length,
                itemBuilder: (BuildContext context, int index) {
                  mrnPreApprovalController.itemlist_textControllersInitiate();
                  return Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5,right: 5,bottom:3, top: 5),
                                    child: Text(mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialname.toString()+" - "+mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].scale.toString(),style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: Container(
                                      height: BaseUtitiles.getheightofPercentage(context, 3),
                                      width: BaseUtitiles.getWidthtofPercentage(context, 4),
                                      margin: EdgeInsets.only(left: 5,right: 5,bottom:3, top: 5),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Icon(Icons.search_off, color: white,),
                                    ),
                                    onTap: (){
                                      mrnPreApprovalController.getStock_MaterialWise(
                                          mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialid,
                                          mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].materialname.toString(),
                                          mrnPreApprovalController.MaterialAppr_itemview_GetDbList[index].scale.toString(),
                                          context);
                                    },
                                  ),
                                ),
                              ],
                            ),


                            Container(
                              margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Expanded(
                                  //     flex: 2,
                                  //     child: Text("Bal Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                  // Expanded(
                                  //   flex: 3,
                                  //   child: Container(
                                  //     margin: EdgeInsets.only(right: 11),
                                  //     height: BaseUtitiles.getheightofPercentage(context, 4),
                                  //     child: TextField(
                                  //       readOnly: true,
                                  //       cursorColor:Theme.of(context).primaryColor,
                                  //       textAlign: TextAlign.center,
                                  //       controller: mrnPreApprovalController.mrnpre_BalQty_ListController[index],
                                  //       keyboardType: TextInputType.number,
                                  //       decoration: InputDecoration(
                                  //         contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
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
                                  Expanded(
                                      flex: 3,
                                      child: Text("Req Qty",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 11),
                                      height: BaseUtitiles.getheightofPercentage(context, 4),
                                      child:
                                      TextField(
                                        readOnly: true,
                                        cursorColor:Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: mrnPreApprovalController.mrnpre_ReqQty_ListController[index],
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
                                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
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
                                      child:
                                      TextField(
                                        cursorColor:Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: mrnPreApprovalController.mrnpre_ApprQty_ListController[index],
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
                                          mrnPreApprovalController.Approval_MaterialItemlist_clickEdit();
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
                                  const Expanded(
                                      flex: 3,
                                      child: Text("Approval",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
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
                                                hint: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "       --Select--",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 20.0, color: Theme.of(context).primaryColor,
                                                ),
                                                isExpanded: true,
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                value: mrnPreApprovalController.mrnpre_Approval_ListController[index].text,
                                                underline: const SizedBox(),
                                                items: list.map((items) {
                                                  return DropdownMenuItem(
                                                    value: items.toString(),
                                                    child: Align(alignment: Alignment.center,child: Text(items.toString(),style: const TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) async {
                                                  setState(() {
                                                    mrnPreApprovalController.mrnpre_Approval_ListController[index].text = value!;
                                                    mrnPreApprovalController.approvalType = value;
                                                    mrnPreApprovalController.mrnpre_projectId[index].text = "0";
                                                    mrnPreApprovalController.mrnpre_Approval_ListController[index].text != "Transfer"
                                                        ? mrnPreApprovalController.mrnpre_TransfrProject_ListController[index].text = "--Select--"  : null;
                                                  });

                                                  // for (int i = 0; i < list.length; i++) {
                                                  //   mrnPreApprovalController.mrnpre_Approval_ListController[i].text =
                                                  //   mrnPreApprovalController.approvalType!;
                                                  //   mrnPreApprovalController.itemlist_textControllersInitiate();
                                                  //
                                                  //   if (mrnPreApprovalController.approvalType == list[i].toString()) {
                                                  //     mrnPreApprovalController.mrnpre_Approval_ListController[i].text =
                                                  //         list[i].toString();
                                                  //   }
                                                  //
                                                  //   print(mrnPreApprovalController.mrnpre_Approval_ListController[i].text);
                                                  // }

                                                  await mrnPreApprovalController.Approval_updateConsumTables();
                                                }
                                              // onChanged: (value) async {
                                              //   setState(() {
                                              //     mrnPreApprovalController.approvalType = value;
                                              //   });
                                              //   for(int i = 0; i <= list.length; i++){
                                              //     mrnPreApprovalController.mrnpre_Approval_ListController[i].text = mrnPreApprovalController.approvalType!;
                                              //     mrnPreApprovalController.itemlist_textControllersInitiate();
                                              //     // if(element.reqMasDetId== mrnPreApprovalController.mrnPreAppDetList[index].reqMasDetId){
                                              //     if( mrnPreApprovalController.approvalType == list[i].toString()){
                                              //       mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[i].toString();
                                              //     // }
                                              //     // else  if(mrnPreApprovalController.approvalType == list[i].toString()){
                                              //     //   mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[i];
                                              //     // // }
                                              //     // // else  if(mrnPreApprovalController.approvalType == list[i].toString()){
                                              //     //   mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[i];
                                              //     //
                                              //     // }
                                              //     // else  if(mrnPreApprovalController.approvalType == list[i].toString()){
                                              //     //   mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[i];
                                              //     // }
                                              //     // else  if(mrnPreApprovalController.approvalType == list[i].toString()){
                                              //     //   mrnPreApprovalController.mrnpre_Approval_ListController[i].text=list[i];
                                              //     // }
                                              //     }
                                              //     print(mrnPreApprovalController.mrnpre_Approval_ListController[i].text);
                                              //     await mrnPreApprovalController.Approval_updateConsumTables();
                                              //   }
                                              //
                                              //
                                              // },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                    // Container(
                                    //   margin: const EdgeInsets.only(right: 11),
                                    //   height: BaseUtitiles.getheightofPercentage(context, 4),
                                    //   child: TextField(
                                    //     readOnly: true,
                                    //     cursorColor:Theme.of(context).primaryColor,
                                    //     textAlign: TextAlign.center,
                                    //     controller: mrnPreApprovalController.mrnpre_Approval_ListController[index],
                                    //     keyboardType: TextInputType.number,
                                    //     decoration: InputDecoration(
                                    //       contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
                                    //       focusedBorder: OutlineInputBorder(
                                    //           borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                    //           borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    //       enabledBorder: OutlineInputBorder(
                                    //           borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                    //           borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    //     ),
                                    //     style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                    //     onTap: (){
                                    //       setState(() {
                                    //         showDialog(
                                    //             context: context,
                                    //             builder: (BuildContext context) {
                                    //               return MrnPreapprovalDetAlert(data: mrnPreApprovalController.mrnPreAppDetList[index].reqMasDetId);
                                    //             });
                                    //       });
                                    //
                                    //     },
                                    //   ),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:  mrnPreApprovalController.mrnpre_Approval_ListController[index].text != "Transfer" ? false : true,
                              child: Container(
                                margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text("Transfer From Project",style: TextStyle(color: Colors.black,fontSize: 14.0),)),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 11),
                                        height: BaseUtitiles.getheightofPercentage(context, 4),
                                        child:
                                        TextField(
                                          readOnly: true,
                                          cursorColor:Theme.of(context).primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: mrnPreApprovalController.mrnpre_TransfrProject_ListController[index],
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
                                            // await mrnPreApprovalController.getProjectList(context,mrnPreApprovalController.mrnPreAppDetList[index].reqMasDetId);
                                            // await bottomsheetControllers.FromProjectName(context, fromprojectController.getdropDownvalue.value);
                                            // await bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
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
                                      child:
                                      TextField(
                                        cursorColor:Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: mrnPreApprovalController.mrnpre_Description_ListController[index],
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
                                          mrnPreApprovalController.Approval_updateConsumTables();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 8),
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
                                        controller: mrnPreApprovalController.mrnpre_Remarks_ListController[index],
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
                                          mrnPreApprovalController.Approval_updateConsumTables();
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
          ),
        ],
      ),
    );
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
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
                          pendingListController.mrnPreapprovallist.forEach((element) {
                            mrnPreApprovalController.mrnpre_RequestNoText.text=element.no.toString();
                            mrnPreApprovalController.mrnpre_RequestDateText.text=element.date.toString();
                            mrnPreApprovalController.mrnpre_DueDateText.text=element.dueDate.toString();
                            mrnPreApprovalController.mrnpre_ApprovalNoText.text=pendingListController.mrn_preapproval_autoYrsWise.value;
                            projectController.projectname.text=element.projectName.toString();
                            projectController.selectedProjectId.value=element.ProjectId!;
                            siteController.selectedsiteId.value=element.SiteId!;
                            siteController.Sitename.text=element.siteName.toString();
                            mrnPreApprovalController.mrnpre_PreparedbyText.text=element.preparedBy.toString();
                            mrnPreApprovalController.mrnpre_ApprovalDateText.text=BaseUtitiles.initiateCurrentDateFormat();
                            mrnPreApprovalController.mrnpre_ApprovedbyText.text=loginController.EmpName();
                            mrnPreApprovalController.mrnpre_VerifiedbyText.text=element.VerifiedBy.toString();
                          });
                          int i=0;
                          mrnPreApprovalController.mrnPreAppDetList.forEach((element) {
                            mrnPreApprovalController.itemlist_textControllersInitiate();
                            mrnPreApprovalController.mrnpre_BalQty_ListController[i].text=element.balQty.toString();
                            mrnPreApprovalController.mrnpre_ReqQty_ListController[i].text=element.reqQty.toString();
                            mrnPreApprovalController.mrnpre_ApprQty_ListController[i].text=element.qty.toString();
                            mrnPreApprovalController.mrnpre_Approval_ListController[i].text="PO";
                            mrnPreApprovalController.mrnpre_TransfrProject_ListController[i].text="--Select--";
                            mrnPreApprovalController.mrnpre_projectId[i].text="0";
                            i++;
                          });
                          mrnPreApprovalController.entrycheck=1;
                          Navigator.pop(context);
                        },
                        child: Text("Reset", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(
        'Are you sure to Pre Approve?' ),
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
                          if(mrnPreApprovalController.mrnpre_TransfrProject_ListController == "--SELECT--"){
                           BaseUtitiles.showToast("Please select treansfer from project");
                          }
                          else {
                            if (await BaseUtitiles.checkNetworkAndShowLoader(
                                context)) {
                              await mrnPreApprovalController
                                  .getMaterialsItemlist_TableDatas();
                              mrnPreApprovalController.ApproveAPI(context);
                            }
                          }
                        },
                        child: Text( "Pre Approve",
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
