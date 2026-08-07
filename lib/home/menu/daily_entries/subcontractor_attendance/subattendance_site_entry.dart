// import '../../../../commonpopup/worktype_alert.dart';
// import '../../../../controller/auto_yrwise_no_controller.dart';
// import '../../../../controller/companycontroller.dart';
// import '../../../../controller/dailyentries_controller.dart';
// import '../../../../controller/projectcontroller.dart';
// import '../../../../controller/sitecontroller.dart';
// import '../../../../controller/subcontcontroller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SubattendanceSiteEntry extends StatefulWidget {
//   SubattendanceSiteEntry({Key? key}) : super(key: key);
//
//   @override
//   State<SubattendanceSiteEntry> createState() => _SubAttendanceSiteEntryState();
//
// }
//
//
// class _SubAttendanceSiteEntryState extends State<SubattendanceSiteEntry> {
//
//   CompanyController companyController = Get.put(CompanyController());
//   ProjectController projectController = Get.put(ProjectController());
//   SubcontractorController subcontractorController = Get.put(SubcontractorController());
//   SiteController siteController = Get.put(SiteController());
//   DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
//   AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
//
//   @override
//   void initState() {
//     var duration = const Duration(seconds:0);
//     Future.delayed(duration,() async {
//       await autoYearWiseNoController.AutoYearWise();
//       dailyEntriesController.autoYearWiseNoController.text=autoYearWiseNoController.SubcontAttendance_autoYrsWise.value;
//       if(dailyEntriesController.editcheck==1){
//         dailyEntriesController.EditListResDatas.value.forEach((element) {
//           dailyEntriesController.saveButton.value = RequestConstant.RESUBMIT;
//           dailyEntriesController.attendId=element.attenId!;
//           dailyEntriesController.ButtonChanges(element.attenId!,dailyEntriesController.aprovedButton);
//           dailyEntriesController.AttendDateController.text =element.attenDate.toString();
//           dailyEntriesController.autoYearWiseNoController.text=element.attenNo.toString();
//           projectController.projectname.text=element.projectName.toString();
//           projectController.selectedProjectId.value=element.projectId;
//           subcontractorController.Subcontractorname.text=element.subContName.toString();
//           subcontractorController.selectedSubcontId.value=element.subContId;
//           siteController.Sitename.text=element.attendanceDet[0].siteName.toString();
//           siteController.selectedsiteId.value=element.attendanceDet[0].siteId;
//           dailyEntriesController.Nmr_Rate.value= element.workType!;
//           dailyEntriesController.RemarksController.text=element.remarks.toString();
//           dailyEntriesController.WorkTypeTextController.text=dailyEntriesController.Nmr_Rate.value=="N"?"NMR":"RATE";
//         });
//       }
//
//       if(dailyEntriesController.entrycheck==0){
//         dailyEntriesController.entrycheck=0;
//         dailyEntriesController.saveButton.value = "Submit";
//         dailyEntriesController.deleteSubcontDetTableDatas();
//         dailyEntriesController.readListdata.value.clear();
//         siteController.selectedsiteId.value=0;
//         subcontractorController.selectedSubcontId.value=0;
//         siteController.selectedsitedropdownName="--Select--".obs;
//         siteController.getSiteDropdownvalue.value.clear();
//         dailyEntriesController.saveButton.value=RequestConstant.SAVE;
//         dailyEntriesController.attendId=0;
//         projectController.selectedProjectId=0.obs;
//         dailyEntriesController.AttendDateController.text = BaseUtitiles.initiateCurrentDateFormat();
//         dailyEntriesController.autoYearWiseNoController.text=autoYearWiseNoController.SubcontAttendance_autoYrsWise.value;
//         dailyEntriesController.RemarksController.text="";
//         projectController.projectname.text=RequestConstant.SELECT;
//         subcontractorController.Subcontractorname.text=RequestConstant.SELECT;
//         subcontractorController.selectedSubcontId.value=0;
//         siteController.Sitename.text=RequestConstant.SELECT;
//         siteController.siteDropdownName.clear();
//         dailyEntriesController.WorkTypeTextController.text="NMR";
//         dailyEntriesController.Nmr_Rate.value = RequestConstant.N;
//       }
//     });
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus &&
//             currentFocus.focusedChild != null) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         }
//       },
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             const SizedBox(
//               height: 8,
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 20, bottom:2),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: SizedBox(
//                       height: BaseUtitiles.getheightofPercentage(context, 4),
//                       child: TextField(
//                         controller: dailyEntriesController.autoYearWiseNoController,
//                         readOnly: true,
//                         textAlign: TextAlign.center,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                           ),
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       height: BaseUtitiles.getheightofPercentage(context, 4),
//                       margin: EdgeInsets.only(left: 10, right: 20),
//                       decoration: BoxDecoration(),
//                       child: TextField(
//                         readOnly: true,
//                         controller: dailyEntriesController.AttendDateController,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                           ),
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.date_range_sharp,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                         onTap: () async {
//                           if(dailyEntriesController.saveButton.value == RequestConstant.APPROVAL){
//
//                           }
//                           else{
//                             var Frdate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime.now().subtract(Duration(days: 2)),
//                                 lastDate: DateTime.now(),
//                                 builder: (context, child) {
//                                   return Theme(data: Theme.of(context).copyWith(
//                                     colorScheme: ColorScheme.light(
//                                       primary: Theme.of(context).primaryColor, // header background color
//                                       onPrimary: Colors.white, // header text color
//                                       onSurface: Colors.black, // body text color
//                                     ),
//                                     textButtonTheme: TextButtonThemeData(
//                                       style: TextButton.styleFrom(
//                                         primary: Colors.black, // button text color
//                                       ),
//                                     ),
//                                   ),
//                                     child: child!,
//                                   );
//                                 }
//                             );
//                             dailyEntriesController.AttendDateController.text =BaseUtitiles.selectDateFormat(Frdate!);
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(top: 10,bottom: 10),
//                           height: BaseUtitiles.getheightofPercentage(context, 5),
//                           width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                           child: TextField(
//                             style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                             readOnly: true,
//                             controller: projectController.projectname,
//                             decoration: new InputDecoration(
//                               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                               labelText: RequestConstant.PROJECT_NAME+" *",
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                               ),
//
//                             ),
//                             onTap: () {
//                               if(dailyEntriesController.editcheck==1){
//
//                               }
//                               else{
//                                 projectController.getProjectList(context,0);
//                                 textclear();
//                               }
//                             },
//                           ),
//
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(bottom: 10),
//                           height: BaseUtitiles.getheightofPercentage(context, 5),
//                           width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                           child: TextField(
//                             style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                             readOnly: true,
//                             controller: subcontractorController.Subcontractorname,
//                             decoration: new InputDecoration(
//                               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                               labelText: "Contractor Name *",
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                               ),
//
//                             ),
//                             onTap: () {
//                               if(dailyEntriesController.editcheck==1){
//
//                               }
//                               else{
//                                 subcontractorController.getSubcontList(context,projectController.selectedProjectId.value, subcontractorController.checkScreen);
//                                 textclear();
//                               }
//                             },
//                           ),
//
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 10),
//               height: BaseUtitiles.getheightofPercentage(context, 5),
//               width: BaseUtitiles.getWidthtofPercentage(context, 90),
//               child: TextField(
//                 style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                 readOnly: true,
//                 controller: dailyEntriesController.WorkTypeTextController,
//                 decoration: new InputDecoration(
//                   contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                   labelText: "Work Type",
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                   ),
//                 ),
//                 onTap: () {
//                   if(dailyEntriesController.editcheck==1){
//
//                   }
//                   else{
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return  WorkTypeAlert();
//                         });
//                   }
//                 },
//               ),
//
//             ),
//             Container(
//               height: BaseUtitiles.getheightofPercentage(context, 5),
//               width: BaseUtitiles.getWidthtofPercentage(context, 90),
//               child:
//               TextField(
//                 textAlign: TextAlign.center,
//                 controller: dailyEntriesController.RemarksController,
//                 decoration: new InputDecoration(
//                   contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                   labelText: RequestConstant.REMARKS,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 10),
//               height: BaseUtitiles.getheightofPercentage(context, 5),
//               width: BaseUtitiles.getWidthtofPercentage(context, 90),
//               child: TextField(
//                 style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                 readOnly: true,
//                 controller: siteController.Sitename,
//                 decoration: new InputDecoration(
//                   contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                   labelText:RequestConstant.SITE_NAME+" *",
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                   ),
//                 ),
//
//                 onTap: () {
//                 if(dailyEntriesController.saveButton.value==RequestConstant.SAVE)
//                   siteController.subcont_SiteEntry_SiteDropdowntList(context,0);
//                 else
//                   siteController.subcont_SiteEntry_SiteDropdowntList(context,1);
//                 },
//               ),
//
//             ),
//             Container(
//               height: BaseUtitiles.getheightofPercentage(context, 4),
//               width: BaseUtitiles.getWidthtofPercentage(context, 30),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Theme.of(context).primaryColor,
//                   //background color of button
//                   side: BorderSide(width: 3, color: Colors.black),
//                   //border width and color
//                   elevation: 3,
//                   //elevation of button
//                   shape: RoundedRectangleBorder(
//                     //to set border radius to button
//                       borderRadius: BorderRadius.circular(30)),
//                 ),
//                 onPressed: () {
//                   if(siteController.selectedsiteId!=0) {
//                     dailyEntriesController.getShowClickPopList(context, 0);
//                     dailyEntriesController.subcontModelList.clear();
//                   }
//                   else{
//
//                   }
//                 },
//                 child: Text(RequestConstant.SHOW),
//               ),
//             ),
//
//             Obx(() => Visibility(
//                 visible: dailyEntriesController.readListdata.value.isEmpty
//                     ? false
//                     : true,
//                 child: ListDetails())),
//             Obx(() => Visibility(
//               visible: dailyEntriesController.readListdata.value.isEmpty
//                   ? false
//                   : true,
//               child: Container(
//                 margin: EdgeInsets.only(top: 10),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Theme.of(context).primaryColor,
//                     //background color of button
//                     side: BorderSide(width: 3, color: Colors.black),
//                     //border width and color
//                     elevation: 3,
//                     //elevation of button
//                     shape: RoundedRectangleBorder(
//                       //to set border radius to button
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   onPressed: () async {
//                     // Save & Update & Approval
//                     await dailyEntriesController.getDetTablesDatas();
//                     if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
//                       dailyEntriesController.Save_EntryScreen(context,dailyEntriesController.attendId!=0?dailyEntriesController.attendId:0,dailyEntriesController.aprovedButton);
//                  }
//                   },
//                   child: Text(dailyEntriesController.saveButton.value),
//                 ),
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget ListDetails() {
//     return Container(
//       height: dailyEntriesController.readListdata.length<=1? BaseUtitiles.getheightofPercentage(context,31):BaseUtitiles.getheightofPercentage(context,50),
//       color: Colors.white24,
//       margin: EdgeInsets.only(top: 10),
//       child: Container(
//         height: BaseUtitiles.getheightofPercentage(context,48),
//         child: Obx(() => ListView.builder(
//           itemCount: dailyEntriesController.readListdata.length,
//           itemBuilder: (BuildContext context, int index) {
//             dailyEntriesController.textControllersInitiate();
//             return SingleChildScrollView(
//               child: Container(
//                 color: Colors.black,
//                // margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       height: BaseUtitiles.getheightofPercentage(context, 3),
//                       width: BaseUtitiles.getheightofPercentage(context, 45),
//                       color: Theme.of(context).primaryColor,
//                       child: Center(
//                         child: Text(dailyEntriesController.readListdata.value[index].siteName,style: TextStyle(color: Colors.white),),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 10,left: 10),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 25,
//                             child: Text(
//                               dailyEntriesController
//                                   .readListdata.value[index].catName,
//                               style: TextStyle(
//                                   color: Colors.blue),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 8,
//                             child: Text(
//                               RequestConstant.CURRENCY_SYMBOL +
//                                   dailyEntriesController
//                                       .readListdata.value[index].wages
//                                       .toString(),
//                               style: TextStyle(color: Colors.red),
//                             ),
//                           ),
//
//                           Expanded(
//                             flex: 3,
//                             child:
//                             Container(
//                               height: BaseUtitiles.getheightofPercentage(context,2),
//                               width: BaseUtitiles.getWidthtofPercentage(context, 8),
//                               child: InkWell(
//                                 onTap: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) =>
//                                         AlertDialog(
//                                           title: Text(RequestConstant.DO_YOU_WANT_DELETE),
//                                           actions: <Widget>[
//                                             // FlatButton(
//                                             //     child: Text(RequestConstant.NO),
//                                             //     onPressed: () {
//                                             //       Navigator.pop(context);
//                                             //     }
//                                             // ),
//                                             // FlatButton(
//                                             //     child: Text(RequestConstant.YES),
//                                             //     onPressed: () {
//                                             //       dailyEntriesController.deleteParticularList(dailyEntriesController.readListdata[index]);
//                                             //       dailyEntriesController. getDetTablesDatas();
//                                             //       dailyEntriesController.readListdata.remove(dailyEntriesController.readListdata[index]);
//                                             //       Navigator.pop(context,dailyEntriesController.readListdata);
//                                             //     }
//                                             // ),
//                                           ],
//                                         ),
//                                   );
//                                 },
//                                 child: Image.asset('assets/cancle.png'),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top:5,left: 10,right: 3),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Container(
//                             child: Text("Nos            ",
//                               style: TextStyle(
//                                   color: Colors.white),
//                             ),
//                           ),
//                           Container(
//                             width: BaseUtitiles.getWidthtofPercentage(context,20),
//                             height: BaseUtitiles.getheightofPercentage(context, 4),
//                             child: TextField(
//                                 style: TextStyle(
//                                     color: Colors.white),
//                                 controller: dailyEntriesController.EntrySCreenNosControllers[index],
//                                 cursorColor: Colors.red,
//                                 keyboardType: TextInputType.number,
//                                 textAlign: TextAlign.center,
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                 ),
//                                 onChanged:(value){
//                                   setState(() {
//                                     dailyEntriesController.clickEdit();
//                                   });
//
//                                 }
//                             ),
//                           ),
//                           Text("Extras",
//                             style: TextStyle(
//                                 color: Colors.white),
//                           ),
//                           Container(
//                               width: BaseUtitiles.getWidthtofPercentage(context,20),
//                               height: BaseUtitiles.getheightofPercentage(context, 4),
//                               child: TextField(
//                                   style: TextStyle(
//                                       color: Colors.white),
//                                   controller: dailyEntriesController.ExtrasControllers[index],
//                                   cursorColor: Colors.white,
//                                   keyboardType: TextInputType
//                                       .number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                   ),
//                                   onChanged:(value){
//                                     dailyEntriesController.clickEdit();
//                                   }
//
//                               ))],
//                       ),
//                     ),
//
//
//                     Container(
//                       margin: EdgeInsets.only(top:5,left: 10,right: 3),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Container(
//                             child: Text("Mrg OT Hrs     ",
//                               style: TextStyle(
//                                   color: Colors.white),
//                             ),
//                           ),
//                           Container(
//                             width: BaseUtitiles.getWidthtofPercentage(context,20),
//                             height: BaseUtitiles.getheightofPercentage(context, 4),
//                             child: TextField(
//                                 style: TextStyle(
//                                     color: Colors.white),
//                                 controller: dailyEntriesController.MrngOtHrsControllers[index],
//                                 cursorColor: Colors.red,
//                                 keyboardType: TextInputType.number,
//                                 textAlign: TextAlign.center,
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                 ),
//                                 onChanged:(value){
//                                   dailyEntriesController.clickEdit();
//                                 }
//                             ),
//                           ),
//                           Text(
//                            " Mrg OT Amt",
//                             style: TextStyle(
//                                 color: Colors.white),
//                           ),
//                           Container(
//                               width: BaseUtitiles.getWidthtofPercentage(context,20),
//                               height: BaseUtitiles.getheightofPercentage(context, 4),
//                               child: TextField(
//                                   readOnly: true,
//                                   style: TextStyle(
//                                       color: Colors.white),
//                                   controller: dailyEntriesController.MrngOtAmtControllers[index],
//                                   cursorColor: Colors.white,
//                                   keyboardType: TextInputType
//                                       .number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                   ),
//                               ))],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top:5,left: 10,right: 3),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Container(
//                             child: Text(
//                               "Evg OT Hrs     ",
//                               style: TextStyle(
//                                   color: Colors.white),
//                             ),
//                           ),
//                           Container(
//                             width: BaseUtitiles.getWidthtofPercentage(context,20),
//                             height: BaseUtitiles.getheightofPercentage(context, 4),
//                             child: TextField(
//                                 style: TextStyle(
//                                     color: Colors.white),
//                                 controller: dailyEntriesController.EvgOtHrsControllers[index],
//                                 cursorColor: Colors.red,
//                                 keyboardType: TextInputType.number,
//                                 textAlign: TextAlign.center,
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                 ),
//                                 onChanged:(value){
//                                   dailyEntriesController.clickEdit();
//                                 }
//                             ),
//                           ),
//                           Text(
//                             "Evg OT Amt",
//                             style: TextStyle(
//                                 color: Colors.white),
//                           ),
//                           Container(
//                               width: BaseUtitiles.getWidthtofPercentage(context,20),
//                               height: BaseUtitiles.getheightofPercentage(context, 4),
//                               child: TextField(
//                                   readOnly: true,
//                                   style: TextStyle(
//                                       color: Colors.white),
//                                   controller: dailyEntriesController.EvgOtAmtControllers[index],
//                                   cursorColor: Colors.white,
//                                   keyboardType: TextInputType
//                                       .number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                   ),
//                               ))],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top:5,left: 10,right: 3),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Container(
//                             child: Text(
//                               "Evg Ext Amt",
//                               style: TextStyle(
//                                   color: Colors.white),
//                             ),
//                           ),
//                           Container(
//                             width: BaseUtitiles.getWidthtofPercentage(context,20),
//                             height: BaseUtitiles.getheightofPercentage(context, 4),
//                             child: TextField(
//
//                                 style: TextStyle(
//                                     color: Colors.white),
//                                 controller: dailyEntriesController.EvgExtraAmtControllers[index],
//                                 cursorColor: Colors.red,
//                                 keyboardType: TextInputType.number,
//                                 textAlign: TextAlign.center,
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                 ),
//                                 onChanged:(value){
//                                   dailyEntriesController.clickEdit();
//                                 }
//                             ),
//                           ),
//                           Text(
//                             "Net Amt",
//                             style: TextStyle(
//                                 color: Colors.white),
//                           ),
//                           Container(
//                               width: BaseUtitiles.getWidthtofPercentage(context,20),
//                               height: BaseUtitiles.getheightofPercentage(context, 4),
//                               child: TextField(
//                                 readOnly: true,
//                                   style: TextStyle(
//                                       color: Colors.white),
//                                   controller: dailyEntriesController.NetAmtController[index],
//                                   cursorColor: Colors.white,
//                                   keyboardType: TextInputType
//                                       .number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                   ),
//                               ))],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 10,left: 10,right: 3,bottom: 8),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 3,
//                             child: Text(
//                               RequestConstant.REMARKSES,
//                               style: TextStyle(
//                                   color: Colors.white),
//                             ),
//                           ),
//                           Expanded(
//                               flex: 11,
//                               child: Container(
//                                 margin: EdgeInsets.only(left: 0),
//                                 height: BaseUtitiles
//                                     .getheightofPercentage(
//                                     context, 4),
//                                 child: TextField(
//                                   style: TextStyle(
//                                       color: Colors.white),
//                                   textAlign: TextAlign.center,
//                                   controller:dailyEntriesController.RemarksControllers[index],
//                                   cursorColor: Colors.red,
//                                   keyboardType: TextInputType
//                                       .name,
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0,0.0),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                   ),
//                                   onChanged: (value){
//                                     setState(() {
//                                       dailyEntriesController.updateSubcontDetValue();
//                                     });
//                                   },
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//         ),
//       ),
//     );
//   }
//
//
//   void textclear() {
//     siteController.siteDropdownName.clear();
//     siteController.setSelectedMRNListName(0);
//     siteController.setSelectedSiteID(RequestConstant.SELECT);
//   }
// }
//
//
//
