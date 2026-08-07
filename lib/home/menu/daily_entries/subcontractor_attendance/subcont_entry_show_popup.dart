// import '../../../../controller/dailyentries_controller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SubContEntryShowPopup extends StatefulWidget {
//   const SubContEntryShowPopup({Key? key, required this.list}) : super(key: key);
//   final List list;
//
//   @override
//   State<SubContEntryShowPopup> createState() => _SubContEntryShowPopupState();
// }
//
// class _SubContEntryShowPopupState extends State<SubContEntryShowPopup> {
//   DailyEntriesController dailyEntriesController =
//       Get.put(DailyEntriesController());
//
//   @override
//   void initState() {
//     dailyEntriesController.nosAndothrsZerovalueset(widget.list);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: Stack(children: <Widget>[
//         SingleChildScrollView(
//           child: Container(
//             height: BaseUtitiles.getheightofPercentage(context, 63),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(top: 5),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 100),
//                   height: BaseUtitiles.getheightofPercentage(context, 3),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                           flex: 9,
//                           child: Center(
//                               child: Text(
//                             RequestConstant.CATEGORY,
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold),
//                           ))),
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           height:
//                               BaseUtitiles.getheightofPercentage(context, 3),
//                           width: BaseUtitiles.getWidthtofPercentage(context, 5),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Image.asset('assets/cancle.png'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 9),
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     border: Border.all(
//                         color: Colors.black, // Set border color
//                         width: 3.0), // Set border width
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         RequestConstant.WAGES,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       Text(RequestConstant.HEAD_NOS,
//                           style: TextStyle(color: Colors.white)),
//                       Container(
//                           width:
//                               BaseUtitiles.getWidthtofPercentage(context, 18),
//                           child: Text("Morning OT Hrs",
//                               style: TextStyle(color: Colors.white))),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: BaseUtitiles.getheightofPercentage(context, 1),
//                 ),
//                 Container(
//                   width: BaseUtitiles.getWidthtofPercentage(context, 100),
//                   height: BaseUtitiles.getheightofPercentage(context, 40),
//                   child: ListView.builder(
//                     itemCount: widget.list.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       dailyEntriesController.textControllersInitiate();
//                       return Column(children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(bottom: 5),
//                                 //  height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   width: BaseUtitiles.getWidthtofPercentage(context, 25),
//                                   child: Text(
//                                     widget.list[index].categoryName.toString(),
//                                     style:
//                                         TextStyle(color: Colors.red, fontSize: 13),
//                                   ),
//                                 ),
//                                 Text(RequestConstant.CURRENCY_SYMBOL +
//                                     widget.list[index].wages.toString()),
//                               ],
//                             ),
//                             Container(
//                               height: BaseUtitiles.getheightofPercentage(
//                                   context, 4),
//                               width: BaseUtitiles.getWidthtofPercentage(
//                                   context, 20),
//                               child: TextField(
//                                 textAlign: TextAlign.center,
//                                 controller: dailyEntriesController
//                                     .NosControllers[index],
//                                 keyboardType: TextInputType.number,
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
//                               ),
//                             ),
//                             Container(
//                               height: BaseUtitiles.getheightofPercentage(
//                                   context, 4),
//                               width: BaseUtitiles.getWidthtofPercentage(
//                                   context, 20),
//                               child: TextField(
//                                 textAlign: TextAlign.center,
//                                 controller: dailyEntriesController
//                                     .OtHrsController[index],
//                                 keyboardType: TextInputType.number,
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
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(
//                           color: Colors.red,
//                         ),
//                       ]);
//                     },
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Theme.of(context).primaryColor,
//                     //background color of button
//                     side: BorderSide(width: 3, color: Colors.brown),
//                     //border width and color
//                     elevation: 3,
//                     //elevation of button
//                     shape: RoundedRectangleBorder(
//                         //to set border radius to button
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   onPressed: () async {
//                     await dailyEntriesController.saveSubContDetTableDatas(context);
//                     dailyEntriesController.getDetTablesDatas();
//                   },
//                   child: Text(RequestConstant.OK),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
