// import '../../../../controller/comman_controller.dart';
// import '../../../../controller/dailyentries_controller.dart';
//
// import '../../../../controller/sitecontroller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// class SubAttendanceSiteEntryList extends StatefulWidget {
//   SubAttendanceSiteEntryList({Key? key}) : super(key: key);
//
//   @override
//   State<SubAttendanceSiteEntryList> createState() => _SubAttendanceSiteEntryListState();
// }
//
// class _SubAttendanceSiteEntryListState extends State<SubAttendanceSiteEntryList> {
//   TextEditingController editingController = TextEditingController();
//   final DailyEntriesController dailyEntryController =
//   Get.put(DailyEntriesController());
//    CommanController commanController = Get.put(CommanController());
//   final SiteController siteController = Get.put(SiteController());
//
//
//
//   @override
//   void initState() {
//     var duration = Duration(seconds: 0);
//     Future.delayed(duration,() async {
//
//       setState(() {
//         dailyEntryController.Entrylist.value.clear();
//         dailyEntryController.AttenEtyList.value.clear();
//       });
//       dailyEntryController.Entrylist.value.clear();
//       dailyEntryController.AttenEtyList.value.clear();
//       DateTime currentDate = DateTime.now();
//       DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
//       dailyEntryController.FromdateController.text = lastDayOfMonth.toString().substring(0, 10);
//       dailyEntryController.TodateController.text = BaseUtitiles.initiateCurrentDateFormat();
//       await dailyEntryController.getAttenEntryList();
//       dailyEntryController.Entrylist.value=dailyEntryController.AttenEtyList.value;
//
//     });
//
//
//
//     super.initState();
//   }
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
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Container(
//                     width: BaseUtitiles.getWidthtofPercentage(context,40),
//                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                     margin: EdgeInsets.only(top: 10),
//                     decoration: BoxDecoration(
//                     ),
//                     child: TextField(
//                       readOnly: true,
//                       controller: dailyEntryController.FromdateController,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.date_range_sharp,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       onTap: () async {
//                         dailyEntryController.Entrylist.value.clear();
//                         var Frdate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.light(
//                                   primary: Theme.of(context).primaryColor, // header background color
//                                   onPrimary: Colors.white, // header text color
//                                   onSurface: Colors.black, // body text color
//                                 ),
//                                 textButtonTheme: TextButtonThemeData(
//                                   style: TextButton.styleFrom(
//                                     primary: Colors.black, // button text color
//                                   ),
//                                 ),
//                               ),
//                                 child: child!,
//                               );
//                             }
//
//                             );
//                         dailyEntryController.FromdateController.text =
//                             Frdate.toString().substring(0, 10);
//                         dailyEntryController.getAttenEntryList();
//                       },
//                     ),
//                   ),
//                   Container(
//                     width: BaseUtitiles.getWidthtofPercentage(context,40),
//                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                     margin: EdgeInsets.only(top: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: TextField(
//                       readOnly: true,
//                       controller: dailyEntryController.TodateController,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.date_range_sharp,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       onTap: () async {
//                         dailyEntryController.Entrylist.value.clear();
//                         var Frdate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.light(
//                                   primary: Theme.of(context).primaryColor, // header background color
//                                   onPrimary: Colors.white, // header text color
//                                   onSurface: Colors.black, // body text color
//                                 ),
//                                 textButtonTheme: TextButtonThemeData(
//                                   style: TextButton.styleFrom(
//                                     primary: Colors.black, // button text color
//                                   ),
//                                 ),
//                               ),
//                                 child: child!,
//                               );
//                             });
//                         dailyEntryController.TodateController.text =
//                             Frdate.toString().substring(0, 10);
//                         dailyEntryController.getAttenEntryList();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left:10,top: 10,right: 10),
//               height: BaseUtitiles.getheightofPercentage(context, 5),
//               child: TextField(
//                  onChanged: (value) async {
//                    setState((){
//                      dailyEntryController.Entrylist.value=BaseUtitiles.filterSearchResults(value,dailyEntryController.AttenEtyList);
//                    });
//
//                  },
//                 controller: editingController,
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.SEARCH,
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//               ),
//             ),
//             Divider(
//               color: Colors.red,
//             ),
//             ListDetails(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget ListDetails() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 3,left: 3,right: 3),
//       height: BaseUtitiles.getheightofPercentage(context, 70),
//       width: BaseUtitiles.getWidthtofPercentage(context, 100),
//       child: Obx(
//             () => ListView.builder(
//             shrinkWrap: true,
//             physics: ScrollPhysics(),
//             itemCount:  dailyEntryController.Entrylist.value.length,
//             itemBuilder: (context, index) {
//               return Slidable(
//                 actionPane: SlidableDrawerActionPane(),
//                 secondaryActions: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Visibility(
//                         visible: commanController.deleteMode == 1 ? true : false,
//                         child: IconSlideAction(
//                             icon: Icons.delete,
//                             color: Colors.white10,
//                             foregroundColor: Colors.red,
//                             caption: RequestConstant.DELETE,
//                             onTap: () {
//                               setState(() {
//                                 dailyEntryController.DeleteAlert(context,index);
//                               });
//                             }),
//                       ),
//                       Visibility(
//                         visible: commanController.editMode == 1 ? true : false,
//                         child: IconSlideAction(
//                             icon: Icons.edit,
//                             color: Colors.white10,
//                             foregroundColor: Colors.green,
//                             caption: RequestConstant.EDIT,
//                             onTap: () async {
//                               dailyEntryController.entrycheck=1;
//                               dailyEntryController.deleteSubcontDetTableDatas();
//                               dailyEntryController.readListdata.value.clear();
//                               dailyEntryController.getAttendanceDetailsDto().clear();
//                               FocusScope.of(context).unfocus();
//                               await dailyEntryController. subContEntryList_EditApi(dailyEntryController.Entrylist.value[index].subcontLabrAttnId,context,0);
//
//                             }),
//                       ),
//                     ],
//                   )
//                 ],
//
//                 child: Container(
//                   height: BaseUtitiles.getheightofPercentage(context, 20),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 200),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//
//                     color: Colors.indigo.shade800,
//                     child: Container(
//                       margin: EdgeInsets.all(3),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 dailyEntryController.Entrylist.value[index].labrAttnNo
//                                     .toString(),
//                                 style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 dailyEntryController.Entrylist.value[index].labrAttnDate
//                                     .toString(),
//                                 style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
//                               ),
//                               // Icon(Icons.remove_red_eye,color: Theme.of(context).primaryColor,)
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.PROJECT_NAME,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyEntryController.Entrylist.value[index].project
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.TOTAL_LABOURS,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyEntryController.Entrylist.value[index].totNos
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.TOTAL_AMT,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyEntryController.Entrylist.value[index].totAmt
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.WRK_DETAILS,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyEntryController.Entrylist.value[index].workType
//                                       .toString() +
//                                       "|" +
//                                       dailyEntryController.Entrylist.value[index].workshift
//                                           .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.CONTNAME,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyEntryController.Entrylist.value[index].subconName
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text(RequestConstant.PREPARED_BY,style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(dailyEntryController.Entrylist.value[index]
//                                       .preparedByName
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//               //
//             }),
//       ),
//     );
//   }
// }
