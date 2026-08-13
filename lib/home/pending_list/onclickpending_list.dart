import '../../../../app_theme/app_colors.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/inward_pending_controller.dart';
import '../../../../controller/pendinglistcontroller.dart';
import '../../../../controller/transferbw_project_controller.dart';
import '../../../../models/onclick_pendinglist_model.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/billgenerationdirect_controller.dart';
import '../../controller/company_nmr_controller.dart';
import '../../controller/dailywrk_done_dprlabour_controller.dart';
import '../../controller/dailywrk_done_dprnew_controller.dart';
import '../../controller/mrn_finalapproval_controller.dart';
import '../../controller/mrn_preapproval_controller.dart';
import '../../controller/mrn_request_indent_controller.dart';
import '../../controller/nmrweeklybill_controller.dart';
import '../../controller/preapproval_controller.dart';
import '../../controller/transfer_acknowledgment_pending_controller.dart';
import '../../controller/workOrderDirect_Controller.dart';
import '../menu/materials/inward/inward_poamendment.dart';
import 'mrnfinal_aproval/mrnfinal_entryscreen.dart';
import 'mrnpre_aproval/mrnpreapr_entryscreen.dart';

class OnclickPendingList extends StatefulWidget {
  OnclickPendingList(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<OnclickPendingList> createState() => _OnclickPendingListState();
}

class _OnclickPendingListState extends State<OnclickPendingList> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child:  SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        // filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles
                                  .filterSearchResults_PendingList(
                                  value,
                                  pendingListController
                                      .pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                          height: BaseUtitiles.getheightofPercentage(context, 88),
                          child: ListView.builder(
                              padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: widget.onclickPendingListData.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 3, right: 3),
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(3),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        widget
                                                            .onclickPendingListData[
                                                                index]
                                                            .no
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 8, left: 10),
                                                      child: Text(""),
                                                    ),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "Date",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        )),
                                                    Expanded(
                                                        flex: 8,
                                                        child: Text(
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .date
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 10),
                                                      child: Text(""),
                                                    ),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "Due Date",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        )),
                                                    Expanded(
                                                        flex: 8,
                                                        child: Text(
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .dueDate
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 10),
                                                      child: Text(""),
                                                    ),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "Project Name",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        )),
                                                    Expanded(
                                                        flex: 8,
                                                        child: Text(
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .projectName
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                Divider(thickness: 1),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 10),
                                                      child: Text(""),
                                                    ),
                                                    Text(
                                                      "Prepared By       ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                          widget
                                                              .onclickPendingListData[
                                                                  index]
                                                              .preparedBy
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        )),
                                                    SizedBox(width: 5),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
        ),
      ),
    );
  }
}

// class MrnFinalApproval extends StatefulWidget {
//   MrnFinalApproval({Key? key,required this.onclickPendingListData, required this.heading}) : super(key: key);
//   List<OnclickPendingListResponse> onclickPendingListData;
//   String heading;
//   @override
//   State<MrnFinalApproval> createState() => _MrnFinalApprovalState();
// }
//
// class _MrnFinalApprovalState extends State<MrnFinalApproval> {
//
//
//   PendingListController pendingListController = Get.put(PendingListController());
//   TextEditingController editingController = TextEditingController();
//   late List<bool> _isChecked;
//
//
//   @override
//   void initState() {
//     setState(() {
//       pendingListController.pendingmainlist.value.clear();
//       pendingListController.pendingmainlist.value=widget.onclickPendingListData;
//       pendingListController.mainlist.value=widget.onclickPendingListData;
//     });
//
//     pendingListController.add_MrnFinalaprovalListvalue.value.clear();
//     _isChecked = List<bool>.filled(pendingListController.mainlist.value.length, false);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async{
//         await pendingListController.getPendingList();
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: Text(widget.heading.toString()),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(left: 6,right: 6,top: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 child: TextField(
//                   onChanged: (value) {
//                     setState(() {
//                       pendingListController.mainlist.value=BaseUtitiles.filterSearchResultsStaffVouchers(value,pendingListController.pendingmainlist);
//                     });
//                   },
//                   controller: editingController,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       labelText: RequestConstant.SEARCH,
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//                 ),
//               ),
//
//               Container(
//                 margin: EdgeInsets.all(6),
//                 height: BaseUtitiles.getheightofPercentage(context, 70),
//                 child: Obx(() =>  ListView.builder(
//                     itemCount: pendingListController.mainlist.length,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {},
//                         child: Container(
//                           margin: EdgeInsets.all(5),
//                           child: Card(
//                             child: Container(
//                               margin: EdgeInsets.all(5),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children:<Widget> [
//                                       Text(pendingListController.mainlist.value[index].no.toString(),style: TextStyle(color: Colors.red),),
//                                       InkWell(
//                                           onTap: (){
//                                             pendingListController.GetMrnFinalDetDetails("MRN FINAL APPROVAL",pendingListController.mainlist.value[index].id!,pendingListController.mainlist.value[index].no.toString(),context);
//                                           },
//                                           child: Icon(Icons.remove_red_eye,color: Theme.of(context).primaryColor,)),
//                                     ],
//                                   ),
//                                   Row(
//
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 8,
//                                           child: Text("Req Date")),
//                                       Expanded(
//                                           flex: 11,
//                                           child: Text(pendingListController.mainlist.value[index].date.toString())),
//                                       // Expanded(
//                                       //   flex: 1,
//                                       //   child: Checkbox(
//                                       //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
//                                       //     value: _isChecked[index],
//                                       //     onChanged: (val) {
//                                       //       setState(() {
//                                       //         if(val==true){
//                                       //           _isChecked[index] = val!;
//                                       //           pendingListController.add_MrnFinalaprovalListvalue.value.add(pendingListController.mainlist.value[index]);
//                                       //         }
//                                       //         else{
//                                       //           _isChecked[index] = val!;
//                                       //           pendingListController.add_MrnFinalaprovalListvalue.value.remove(pendingListController.mainlist.value[index]);
//                                       //         }
//                                       //       },
//                                       //       );
//                                       //     },
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Due Date")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].dueDate.toString())),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Project Name")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].projectName.toString())),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 8,
//                                           child: Text("PreApp By")),
//                                       Expanded(
//                                           flex: 11,
//                                           child: Text(pendingListController.mainlist.value[index].preparedBy.toString())),
//
//                                       Expanded(
//                                         flex: 1,
//                                         child: Checkbox(
//                                           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
//                                           value: _isChecked[index],
//                                           onChanged: (val) {
//                                             setState(() {
//                                               if(val==true){
//                                                 _isChecked[index] = val!;
//                                                 pendingListController.add_MrnFinalaprovalListvalue.value.add(pendingListController.mainlist.value[index]);
//                                               }
//                                               else{
//                                                 _isChecked[index] = val!;
//                                                 pendingListController.add_MrnFinalaprovalListvalue.value.remove(pendingListController.mainlist.value[index]);
//                                               }
//                                             },
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     })),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top:15),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 25),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Theme.of(context).primaryColor,
//                     side: BorderSide(width: 3, color: Colors.brown),
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),),
//                   child: Text("Approve"),
//                   onPressed: () async{
//                     pendingListController.getMrnFinalAprovalDetList.value.clear();
//                     await pendingListController.MrnFinalAproval_buttonApi(context);
//                     await pendingListController.getPendingList();
//                   },
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// -----------Change new designs-------------

class WorkPreApproval extends StatefulWidget {
  WorkPreApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<WorkPreApproval> createState() => _WorkPreApprovalState();
}

class _WorkPreApprovalState extends State<WorkPreApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  PreApprovalController preApprovalController =
      Get.put(PreApprovalController());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    pendingListController.add_MrnFinalaprovalListvalue.value.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.heading.toString(),
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
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              await preApprovalController.getPendingList_Alldatas(
                                  pendingListController.mainlist.value[index].id!,
                                  context);
                            },
                            child: Container(
                              // height: BaseUtitiles.getheightofPercentage(context, 16),
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MrnVerfication extends StatefulWidget {
  MrnVerfication(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<MrnVerfication> createState() => _MrnVerficationState();
}

class _MrnVerficationState extends State<MrnVerfication> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value = widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              // await pendingListController.getPendingList();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value = BaseUtitiles.filterSearchResults_PendingList(value, pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrn_request_controller.delete_MaterialIntent_itemlist_Table();
                              mrn_request_controller.Material_itemview_GetDbList.value.clear();
                              await mrn_request_controller.getPendingList_Alldatas(pendingListController.mainlist.value[index].id!,pendingListController.mainlist.value[index].ProjectId!,pendingListController.mainlist.value[index].SiteId!, context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].projectName.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].siteName.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:
                                      //       EdgeInsets.only(top: 5, left: 10),
                                      //       child: Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "Request Type",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 8,
                                      //         child: Text(
                                      //           pendingListController.mainlist.value[index].purchaseType == "PO" ? "General item" :"-",
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),

                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                         Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.GetDetDetails(
                                                          "MRN VERIFICATION",
                                                          // "MRN VERIFICATION - CIVIL",
                                                          pendingListController.mainlist.value[index].id!,
                                                          pendingListController.mainlist.value[index].no.toString(),
                                                          pendingListController.mainlist.value[index].projectName.toString(), context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MrnVerification_HSE extends StatefulWidget {
   MrnVerification_HSE({Key? key, required this.onclickPendingListData, required this.heading}) : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<MrnVerification_HSE> createState() => _MrnVerification_HSEState();
}

class _MrnVerification_HSEState extends State<MrnVerification_HSE> {

  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value = widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              // await pendingListController.getPendingList();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrn_request_controller.delete_MaterialIntent_itemlist_Table();
                              mrn_request_controller.Material_itemview_GetDbList.value.clear();
                              await mrn_request_controller.getPendingList_Alldatas(
                                  pendingListController.mainlist.value[index].id!,
                                  pendingListController.mainlist.value[index].ProjectId!,
                                  pendingListController.mainlist.value[index].SiteId!,
                                  context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].projectName.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Request Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].purchaseType.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.GetDetDetails(
                                                      "MRN VERIFICATION - HSE",
                                                      pendingListController.mainlist.value[index].id!,
                                                      pendingListController.mainlist.value[index].no.toString(),
                                                      pendingListController.mainlist.value[index].projectName.toString(),
                                                      context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MrnVerification_Interior extends StatefulWidget {
   MrnVerification_Interior({Key? key, required this.onclickPendingListData, required this.heading}) : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<MrnVerification_Interior> createState() => _MrnVerification_InteriorState();
}

class _MrnVerification_InteriorState extends State<MrnVerification_Interior> {

  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value = widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              // await pendingListController.getPendingList();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrn_request_controller.delete_MaterialIntent_itemlist_Table();
                              mrn_request_controller.Material_itemview_GetDbList.value.clear();
                              await mrn_request_controller.getPendingList_Alldatas(pendingListController.mainlist.value[index].id!, pendingListController.mainlist.value[index].ProjectId!, pendingListController.mainlist.value[index].SiteId!,context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].projectName.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Request Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].purchaseType.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.GetDetDetails(
                                                      "MRN VERIFICATION - HSE",
                                                      pendingListController.mainlist.value[index].id!,
                                                      pendingListController.mainlist.value[index].no.toString(),
                                                      pendingListController.mainlist.value[index].projectName.toString(),
                                                      context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MrnVerification_MEB extends StatefulWidget {
   MrnVerification_MEB({Key? key, required this.onclickPendingListData, required this.heading}) : super(key: key);
   List<OnclickPendingListResponse> onclickPendingListData;
   String heading;

  @override
  State<MrnVerification_MEB> createState() => _MrnVerification_MEBState();
}

class _MrnVerification_MEBState extends State<MrnVerification_MEB> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value = widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              // await pendingListController.getPendingList();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        // padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrn_request_controller
                                  .delete_MaterialIntent_itemlist_Table();
                              mrn_request_controller
                                  .Material_itemview_GetDbList.value
                                  .clear();
                              await mrn_request_controller.getPendingList_Alldatas(
                                  pendingListController.mainlist.value[index].id!,
                                  pendingListController.mainlist.value[index].ProjectId!,
                                  pendingListController.mainlist.value[index].SiteId!,
                                  context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].projectName.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Request Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].purchaseType.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.GetDetDetails(
                                                      "MRN VERIFICATION - HSE",
                                                      pendingListController.mainlist.value[index].id!,
                                                      pendingListController.mainlist.value[index].no.toString(),
                                                      pendingListController.mainlist.value[index].projectName.toString(),
                                                      context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MrnVerification_PEB extends StatefulWidget {
  MrnVerification_PEB({Key? key,required this.onclickPendingListData, required this.heading}) : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;
  @override
  State<MrnVerification_PEB> createState() => _MrnVerification_PEBState();
}

class _MrnVerification_PEBState extends State<MrnVerification_PEB> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value = widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              // await pendingListController.getPendingList();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              mrn_request_controller
                                  .delete_MaterialIntent_itemlist_Table();
                              mrn_request_controller
                                  .Material_itemview_GetDbList.value
                                  .clear();
                              await mrn_request_controller.getPendingList_Alldatas(
                                  pendingListController.mainlist.value[index].id!,
                                  pendingListController.mainlist.value[index].ProjectId!,
                                  pendingListController.mainlist.value[index].SiteId!,
                                  context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].projectName.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Request Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].purchaseType.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.GetDetDetails(
                                                      "MRN VERIFICATION - HSE",
                                                      pendingListController.mainlist.value[index].id!,
                                                      pendingListController.mainlist.value[index].no.toString(),
                                                      pendingListController.mainlist.value[index].projectName.toString(),
                                                      context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// class MrnVerification_HSE extends StatefulWidget {
//   MrnVerification_HSE({Key? key, required this.onclickPendingListData, required this.heading}) : super(key: key);
//   List<OnclickPendingListResponse> onclickPendingListData;
//   String heading;
//
//   @override
//   State<MrnVerification_HSE> createState() => _MrnVerification_HSEState();
// }
//
// class _MrnVerification_HSEState extends State<MrnVerification_HSE> {
//
//   TextEditingController editingController = TextEditingController();
//   PendingListController pendingListController = Get.put(PendingListController());
//   MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         await pendingListController.getPendingList();
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(color: Colors.black),
//           backgroundColor: Theme.of(context).primaryColor,
//           title: Text(widget.heading.toString(),
//               style: TextStyle(color: Colors.black)),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(left: 6, right: 6, top: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 child: TextField(
//                   onChanged: (value) {
//                     setState(() {
//                       pendingListController.mainlist.value =
//                           BaseUtitiles.filterSearchResultsStaffVouchers(
//                               value, pendingListController.pendingmainlist);
//                     });
//                   },
//                   controller: editingController,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       labelText: RequestConstant.SEARCH,
//                       prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
//                       border: OutlineInputBorder(
//                           borderRadius:
//                           BorderRadius.all(Radius.circular(25.0)))),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.all(6),
//                 height: BaseUtitiles.getheightofPercentage(context, 80),
//                 child: Obx(() => ListView.builder(
//                     itemCount: pendingListController.mainlist.length,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () async {
//                           mrn_request_controller.delete_MaterialIntent_itemlist_Table();
//                           mrn_request_controller.Material_itemview_GetDbList.value.clear();
//                           await mrn_request_controller.getPendingList_Alldatas(
//                               pendingListController.mainlist.value[index].id!,
//                               // pendingListController.mainlist.value[index].ProjectId!,
//                               context);
//                         },
//                         child: Container(
//                           // height: BaseUtitiles.getheightofPercentage(context, 16),
//                           margin: EdgeInsets.all(5),
//                           child: Card(
//                             color: Colors.white,
//                             child: Container(
//                               margin: EdgeInsets.all(5),
//                               child:
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children:<Widget> [
//                                       Text(pendingListController.mainlist.value[index].no.toString(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
//                                       InkWell(
//                                           onTap: (){
//                                             pendingListController.GetDetDetails("MRN VERIFICATION - HSE",
//                                                 pendingListController.mainlist.value[index].id!,
//                                                 pendingListController.mainlist.value[index].no.toString(),
//                                                 pendingListController.mainlist.value[index].projectName.toString(),
//                                                 context);
//                                           },
//                                           child: Icon(Icons.remove_red_eye,color: Colors.indigo,))
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Req Date")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].date.toString())),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Due Date")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].dueDate.toString())),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Project Name")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].projectName.toString(),style: TextStyle(fontWeight: FontWeight.bold))),
//                                     ],
//                                   ),
//
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Request Type")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].potype.toString())),
//                                     ],
//                                   ),
//
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Prepared By")),
//                                       Expanded(
//                                           flex: 3,
//                                           child: Text(pendingListController.mainlist.value[index].preparedBy.toString(),style: TextStyle(color: Colors.brown))),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//
//                               // Column(
//                               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               //   crossAxisAlignment: CrossAxisAlignment.start,
//                               //   children: <Widget>[
//                               //
//                               //     Row(
//                               //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               //       children:<Widget> [
//                               //         Text(pendingListController.mainlist.value[index].no.toString(),style: TextStyle(color: Colors.red),),
//                               //         // Column(
//                               //         //   children: [
//                               //         //     // Row(
//                               //         //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               //         //     //     children: [
//                               //         //     //       Text(
//                               //         //     //           pendingListController
//                               //         //     //               .mainlist.value[index].no
//                               //         //     //               .toString(),
//                               //         //     //           style:
//                               //         //     //           TextStyle(color: Colors.red)),
//                               //         //     //     ]),
//                               //         //     Row(
//                               //         //       children: <Widget>[
//                               //         //         Expanded(
//                               //         //             flex: 2,
//                               //         //             child: Text("Project Name")),
//                               //         //         Expanded(
//                               //         //             flex: 3,
//                               //         //             child: Text(pendingListController
//                               //         //                 .mainlist
//                               //         //                 .value[index]
//                               //         //                 .projectName
//                               //         //                 .toString())),
//                               //         //       ],
//                               //         //     ),
//                               //         //     Row(
//                               //         //       children: <Widget>[
//                               //         //         Expanded(
//                               //         //             flex: 2,
//                               //         //             child: Text("Prepared By")),
//                               //         //         Expanded(
//                               //         //             flex: 3,
//                               //         //             child: Text(pendingListController
//                               //         //                 .mainlist
//                               //         //                 .value[index]
//                               //         //                 .preparedBy
//                               //         //                 .toString())),
//                               //         //       ],
//                               //         //     ),
//                               //         //
//                               //         //     Row(
//                               //         //       children: <Widget>[
//                               //         //         Expanded(
//                               //         //           flex: 2,
//                               //         //           child: Text("Date"),
//                               //         //         ),
//                               //         //         Expanded(
//                               //         //           flex: 3,
//                               //         //           child: Text(pendingListController
//                               //         //               .mainlist.value[index].date
//                               //         //               .toString(),
//                               //         //           ),
//                               //         //         ),
//                               //         //       ],
//                               //         //     ),
//                               //         //     Row(
//                               //         //       children: <Widget>[
//                               //         //         Expanded(
//                               //         //           flex: 2, child:
//                               //         //         Text("Due Date"),
//                               //         //         ),
//                               //         //         Expanded(
//                               //         //             flex: 3,
//                               //         //             child: Text(pendingListController
//                               //         //                 .mainlist.value[index].dueDate
//                               //         //                 .toString())
//                               //         //         ),
//                               //         //       ],
//                               //         //     ),
//                               //         //
//                               //         //   ],
//                               //         // ),
//                               //         InkWell(
//                               //             onTap: (){
//                               //               pendingListController.GetDetDetails("MRN VERIFICATION",pendingListController.mainlist.value[index].id!,pendingListController.mainlist.value[index].no.toString(),context);
//                               //             },
//                               //             child: Icon(Icons.remove_red_eye,  color: Colors.blue,))
//                               //       ],
//                               //     ),
//                               //
//                               //     // ExpansionTile(
//                               //     //   title: Text("data"),
//                               //     //   children: [
//                               //     //     ListTile(
//                               //     //       title: Row(
//                               //     //         children: [
//                               //     //           Expanded(
//                               //     //               flex: 10,
//                               //     //               child: Text("Material",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
//                               //     //           Expanded(
//                               //     //               flex: 6,
//                               //     //               child: Text("Qty",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
//                               //     //           Expanded(
//                               //     //               flex: 6,
//                               //     //               child: Text("Scale",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
//                               //     //           Expanded(
//                               //     //               flex: 6,
//                               //     //               child: Text("Type",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
//                               //     //         ],
//                               //     //       ),
//                               //     //
//                               //     //       subtitle:
//                               //     //       Container(
//                               //     //         height: BaseUtitiles.getheightofPercentage(context, 20),
//                               //     //             width: BaseUtitiles.getWidthtofPercentage(context, 20),
//                               //     //         child: FutureBuilder(
//                               //     //           future:   pendingListController.GetDetDetails("MRN VERIFICATION",pendingListController.mainlist.value[index].id!,pendingListController.mainlist.value[index].no.toString(),context),
//                               //     //           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                               //     //             if(snapshot.data!=null){
//                               //     //               return ListView.builder(
//                               //     //                   itemCount: snapshot.data.length,
//                               //     //                   itemBuilder: (BuildContext context, int index){
//                               //     //                     return Row(
//                               //     //                       children: [
//                               //     //                         Expanded(
//                               //     //                             flex:5,
//                               //     //                             child: Text(snapshot.data[index].materialName.toString())),
//                               //     //                         Expanded(
//                               //     //                             flex: 3,
//                               //     //                             child: Text(snapshot.data[index].qty.toString())),
//                               //     //                         Expanded(
//                               //     //                             flex: 3,
//                               //     //                             child: Text(snapshot.data[index].scale.toString())),
//                               //     //                         Expanded(
//                               //     //                             flex: 3,
//                               //     //                             child: Text(snapshot.data[index].preAppType.toString())),
//                               //     //                       ],
//                               //     //                     );
//                               //     //                   }
//                               //     //               );
//                               //     //             }
//                               //     //             else{
//                               //     //               return Container();
//                               //     //             }
//                               //     //           },
//                               //     //         ),
//                               //     //       ),
//                               //     //
//                               //     //     ),
//                               //     //   ],
//                               //     // ),
//                               //
//                               //   ],
//                               // ),
//
//                             ),
//                           ),
//                         ),
//                       );
//                     })),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class MrnApproval extends StatefulWidget {
  MrnApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<MrnApproval> createState() => _MrnApprovalState();
}

class _MrnApprovalState extends State<MrnApproval> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.heading.toString(),
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
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 90),
                  // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    controller: editingController,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: "search..",
                      hintStyle: TextStyle(color: Colors.black),
                      isDense: true,
                      fillColor: Setmybackground,
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      // if (onSearch != null) onSearch!(searchcontroller.text);
                    },
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      setState(() {
                        pendingListController.mainlist.value =
                            BaseUtitiles.filterSearchResults_PendingList(
                                value,
                                pendingListController.pendingmainlist);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6, right: 6),
                  height: BaseUtitiles.getheightofPercentage(context, 88),
                  child: Obx(() => ListView.builder(
                      padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.onclickPendingListData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            BaseUtitiles.showToast("Access only in web");
                          },
                          child: Container(
                            // height: BaseUtitiles.getheightofPercentage(context, 16),
                            margin: EdgeInsets.only(left: 3, right: 3),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(3),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            widget
                                                .onclickPendingListData[index].no
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 8, left: 10),
                                          child: Text(""),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Date",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .date
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 5, left: 10),
                                          child: Text(""),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Due Date",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .dueDate
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 5, left: 10),
                                          child: Text(""),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Project Name",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .projectName
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                      ],
                                    ),
                                    Divider(thickness: 1),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 5, left: 10),
                                          child: Text(""),
                                        ),
                                        Text(
                                          "Prepared By       ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 7,
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .preparedBy
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 5,
                                            child: InkWell(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        "More",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      )),
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    radius: 13,
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      color: Setmybackground,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  pendingListController
                                                      .PendingPoDetDetails(
                                                          "PENDING PO",
                                                          pendingListController.mainlist.value[index].id!,
                                                          pendingListController.mainlist.value[index].no.toString(),
                                                      pendingListController.mainlist.value[index].projectName.toString(),
                                                          context);
                                                });
                                              },
                                            )),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MrnPreApproval extends StatefulWidget {
  MrnPreApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  PendingListController pendingListController =
      Get.put(PendingListController());
  String heading;

  @override
  State<MrnPreApproval> createState() => _MrnPreApprovalState();
}

class _MrnPreApprovalState extends State<MrnPreApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  MrnPreApprovalController mrnPreApprovalController = Get.put(MrnPreApprovalController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
        pendingListController.pendingmainlist.value.clear();
        pendingListController.pendingmainlist.value =
            widget.onclickPendingListData;
        pendingListController.mainlist.value = widget.onclickPendingListData;
      pendingListController.add_MrnFinalaprovalListvalue.value.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              // mrnPreApprovalController.entrycheck = 0;
                              // pendingListController.mrnPreapprovallist.value.clear();
                              // mrnPreApprovalController.reqId = 0;
                              // mrnPreApprovalController.reqId = pendingListController.mainlist.value[index].id!;
                              // pendingListController.mrnPreapprovallist.value.add(pendingListController.mainlist.value[index]);
                              // await pendingListController.Mrn_PreApproval_AutoYearWise();
                              // await mrnPreApprovalController.deleteMaterialApprvalTable();
                              // mrnPreApprovalController.MaterialAppr_itemview_GetDbList.value.clear();
                              // mrnPreApprovalController.mrnPreAppDetList.value.clear();
                              // await mrnPreApprovalController.mrnPreapprovalDetListApi(pendingListController.mainlist.value[index].id!, context);
                              await mrn_request_controller.MaterialIntentList_EditApi(pendingListController.mainlist[index].id, pendingListController.mainlist[index].ProjectId,pendingListController.mainlist[index].SiteId, context,widget.heading=="MRN GM APPROVAL"?"GMApprove":"PreApprove");
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Verified By         ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.GetDetDetails_PreApproval(
                                                      widget.heading,
                                                          pendingListController.mainlist.value[index].id!,
                                                          pendingListController.mainlist.value[index].no.toString(),
                                                          pendingListController.mainlist.value[index].projectName.toString(), context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MrnFinalApproval extends StatefulWidget {
  MrnFinalApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<MrnFinalApproval> createState() => _MrnFinalApprovalState();
}

class _MrnFinalApprovalState extends State<MrnFinalApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  MrnFinalApprovalController mrnFinalApprovalController = Get.put(MrnFinalApprovalController());
  MrnPreApprovalController mrnPreApprovalController = Get.put(MrnPreApprovalController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    mrnFinalApprovalController.entrycheck = 0;
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });

    pendingListController.add_MrnFinalaprovalListvalue.value.clear();
    _isChecked =
        List<bool>.filled(pendingListController.mainlist.value.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              pendingListController.mrnfinalapprovallist.value.clear();
                              mrnFinalApprovalController.reqId = 0;
                              mrnFinalApprovalController.entrycheck = 0;
                              mrnFinalApprovalController.reqId = pendingListController.mainlist.value[index].id!;
                              pendingListController.mrnfinalapprovallist.value.add(pendingListController.mainlist.value[index]);
                              await mrnFinalApprovalController.deleteMaterial_FinalApprvalTable();
                              mrnFinalApprovalController.MaterialFinalAppr_itemview_GetDbList.value.clear();
                              mrnFinalApprovalController.mrnfinalAppDetList.value.clear();
                              await mrnFinalApprovalController.mrnFinalapprovalDetListApi(pendingListController.mainlist.value[index].id!, context);
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => MrnfinalEntryScreen()),);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "PreApprovedBy       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.GetMrnFinalDetDetails(
                                                          "MRN FINAL APPROVAL",
                                                          pendingListController.mainlist.value[index].id!,
                                                          pendingListController.mainlist.value[index].no.toString(),
                                                      pendingListController.mainlist.value[index].projectName.toString(),
                                                          context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PendingPO extends StatefulWidget {
  PendingPO(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  PendingListController pendingListController =
      Get.put(PendingListController());
  String heading;

  @override
  State<PendingPO> createState() => _PendingPOState();
}

class _PendingPOState extends State<PendingPO> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());

  @override
  void initState() {
    setState(() {
      widget.pendingListController.pendingmainlist.value.clear();
      widget.pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      widget.pendingListController.mainlist.value =
          widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await widget.pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.heading.toString(),
                          style: TextStyle(
                              fontSize: 15,
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
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value = BaseUtitiles.filterSearchResults_PendingList(value, pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6,top: 5),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              BaseUtitiles.showToast(
                                  "PO Generation Only in Website");
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              widget.pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Req Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "ApprovedBy",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .approvedby
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    pendingListController
                                                        .PendingPoDetDetails(
                                                            "PENDING PO",
                                                            pendingListController.mainlist.value[index].id!,
                                                            pendingListController.mainlist.value[index].no.toString(),
                                                        pendingListController.mainlist.value[index].projectName.toString(),
                                                            context);
                                                  });
                                                  // pendingListController.GetDetDetails("MRN VERIFICATION",pendingListController.mainlist.value[index].id!,pendingListController.mainlist.value[index].no.toString(),context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InwardPending extends StatefulWidget {
  InwardPending(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<InwardPending> createState() => _InwardPendingState();
}

class _InwardPendingState extends State<InwardPending> {
  PendingListController pendingListController = Get.put(PendingListController());
  InwardPending_Controller inwardPending_Controller = Get.put(InwardPending_Controller());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize:15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value = BaseUtitiles.filterSearchResults_InwardPending(value, pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6),
                    height: BaseUtitiles.getheightofPercentage(context, 100),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              inwardPending_Controller.itemlistTable_Delete();
                              inwardPending_Controller.ItemGetTableListdata.value.clear();
                              await inwardPending_Controller.getInward_Alldatas(
                                  pendingListController.mainlist.value[index].id!,
                                  context);
                              await inwardPending_Controller.inwardpending_itemlist_SaveTable();
                              await inwardPending_Controller.getItemlistTablesDatas();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController.mainlist.value[index].no.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].supplierName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "PreparedBy",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              "Delay Days",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].delaydays
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),


                                          Container(
                                            height: BaseUtitiles.getheightofPercentage(context,4),
                                            // margin: EdgeInsets.only(top: 15, bottom: 5),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: TextButton(
                                              onPressed: () async {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Inward_PoAmendment(
                                                  heading: "INWARD PENDING",
                                                  ReqNo:  pendingListController.mainlist.value[index].no.toString(),
                                                  PoDate: pendingListController.mainlist.value[index].date.toString(),
                                                  ProjectName: pendingListController.mainlist.value[index].projectName.toString(),
                                                  SiteName: pendingListController.mainlist.value[index].siteName.toString(),
                                                  SupplierName: pendingListController.mainlist.value[index].supplierName.toString(),
                                                )));
                                                await inwardPending_Controller.getPo_AmendmentList(context, pendingListController.mainlist.value[index].id);
                                              },
                                              child: Container(
                                                  width: BaseUtitiles.getWidthtofPercentage(context, 13),
                                                  child: Text("PO AMD", style: TextStyle(color: Colors.white, fontSize: RequestConstant.App_Font_SIZE),)),
                                            ),
                                          ),


                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.PendingInwardDetDetails(
                                                          "INWARD PENDING",
                                                          pendingListController.mainlist.value[index].id!,
                                                          pendingListController.mainlist.value[index].no.toString(), context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubContractorAttandance extends StatefulWidget {
  SubContractorAttandance(
      {Key? key, required this.onclickPendingListData, required this.heading}) : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<SubContractorAttandance> createState() =>
      _SubContractorAttandanceState();
}

class _SubContractorAttandanceState extends State<SubContractorAttandance> {
  PendingListController pendingListController = Get.put(PendingListController());
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    pendingListController.pendingmainlist.value.clear();
    pendingListController.pendingmainlist.value = widget.onclickPendingListData;
    pendingListController.mainlist.value = widget.onclickPendingListData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(margin: EdgeInsets.only(left: 15),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Text(
                              widget.heading.toString(),
                              style: TextStyle(
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: RequestConstant.Lable_Font_SIZE),
                        isDense: true,
                        fillColor: Setmybackground,
                        // fillColor: Colors.white,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles
                                  .filterSearchResults_PendingList(
                                  value,
                                  pendingListController
                                      .pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6),
                    height: BaseUtitiles.getheightofPercentage(context, 100),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              dailyEntriesController.editcheck = 0;
                              dailyEntriesController.entrycheck = 1;
                              dailyEntriesController.screenCheck = "Verify";
                              dailyEntriesController.getAttendanceDetailsDto().clear();
                              dailyEntriesController.deleteSubcontDetTableDatas();
                              dailyEntriesController.readListdata.value.clear();
                              dailyEntriesController.subContEntryList_EditApi(
                                  pendingListController.mainlist.value[index].id!,
                                  context,
                                  1);
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController
                                                      .mainlist.value[index].date
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Prepared By",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 6,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Container(
                                            child: Icon(
                                              Icons.arrow_circle_right_outlined,
                                              color:
                                                  Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubContDPRApproval extends StatefulWidget {
  SubContDPRApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<SubContDPRApproval> createState() => _SubContDPRApprovalState();
}

class _SubContDPRApprovalState extends State<SubContDPRApproval> {
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
      Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller =
      Get.put(DailyWrkDone_DPRLabour_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller =
      Get.put(DailyWrkDone_DPRNEW_Controller());
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
        pendingListController.pendingmainlist.value.clear();
     pendingListController.pendingmainlist.value = widget.onclickPendingListData;
     pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(
                              // "Subcontractor DPR Approval",
                              widget.heading.toString(),
                              style: TextStyle(
                                  // fontSize: RequestConstant.Heading_Font_SIZE,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(
                    //   top: 10,
                    // ),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle:
                        TextStyle(color: Colors.black, fontSize: 15),
                        isDense: true,
                        fillColor: Setmybackground,
                        // fillColor: Colors.white,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles
                                  .filterSearchResults_PendingList(
                                  value,
                                  pendingListController
                                      .pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (pendingListController.mainlist.value[index].DprType == 1) {
                                dailyWrkDone_DPR_Controller.dpr_EditListApiValue.value.clear();
                                dailyWrkDone_DPR_Controller.screenchek.value = 1;
                                FocusScope.of(context).unfocus();
                                dailyWrkDone_DPR_Controller.DprEntryList_EditApi(pendingListController.mainlist.value[index].id!, context, 1);
                              } else if (pendingListController.mainlist.value[index].DprType == 2) {
                                dailyWrkDone_DPRNEW_Controller.dprNew_EditApiList.value.clear();
                                FocusScope.of(context).unfocus();
                                dailyWrkDone_DPRNEW_Controller.Dpr_New_EntryList_EditApi(pendingListController.mainlist.value[index].id!, context, 1);
                              } else if (pendingListController.mainlist.value[index].DprType == 3) {
                                dailyWrkDone_DPRLabour_Controller.dpr_EditListApiValue.value.clear();
                                FocusScope.of(context).unfocus();
                                dailyWrkDone_DPRLabour_Controller.DprLabourEntryList_EditApi(pendingListController.mainlist.value[index].id!, context, 1);
                              } else {}
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController
                                                      .mainlist.value[index].date
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Site Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Subcontractor",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .subContractorName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Work Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController
                                                    .mainlist
                                                    .value[index]
                                                    .type
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Prepared By",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// class SubContNMRBillApproval extends StatefulWidget {
//   SubContNMRBillApproval({Key? key,required this.onclickPendingListData, required this.heading}) : super(key: key);
//   List<OnclickPendingListResponse> onclickPendingListData;
//   PendingListController pendingListController=Get.put(PendingListController());
//   String heading;
//   @override
//   State<SubContNMRBillApproval> createState() => _SubContNMRBillApprovalState();
// }
//
// class _SubContNMRBillApprovalState extends State<SubContNMRBillApproval> {
//   PendingListController pendingListController=Get.put(PendingListController());
//
//   late List<bool> _isChecked;
//   TextEditingController editingController = TextEditingController();
//   @override
//   void initState() {
//     pendingListController.addSubcontNmrListvalue.value.clear();
//     _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         pendingListController.getPendingList();
//         return true ;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: Text(widget.heading.toString()),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.all(6),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(top: 10),
//                   height: BaseUtitiles.getheightofPercentage(context, 5),
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {});
//                     },
//                     controller: editingController,
//                     decoration: InputDecoration(
//                         labelText: RequestConstant.SEARCH,
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//                   ),
//                 ),
//                 Container(
//                   height: BaseUtitiles.getheightofPercentage(context,70),
//                   child: ListView.builder(
//                       itemCount: widget.onclickPendingListData.length,
//                       itemBuilder: (context, index) {
//                         if(editingController.text.isEmpty){
//                           return InkWell(
//                             onTap: () {
//
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(5),
//                               child: Card(
//                                 child: Container(
//                                   margin: EdgeInsets.all(5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children:<Widget> [
//                                           Text(widget.onclickPendingListData[index].no.toString(),style: TextStyle(color: Colors.red),),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].date.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Project Name")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].projectName.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Subcontractor Name")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].subContractorName.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("From Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].fromDate.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("To Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].toDate.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Manual BillNo")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].billno.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Net Amount")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(RequestConstant.CURRENCY_SYMBOL+widget.onclickPendingListData[index].netAmt.toString(),style: TextStyle(color: Colors.red))),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 5,
//                                               child: Text("Verified By")),
//                                           Expanded(
//                                               flex: 6,
//                                               child: Text(widget.onclickPendingListData[index].preparedBy.toString(),style: TextStyle(color: Colors.blue),)),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Checkbox(
//                                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
//                                               value: _isChecked[index],
//                                               onChanged: (val) {
//                                                 setState(() {
//                                                   if(val==true){
//                                                     _isChecked[index] = val!;
//                                                     pendingListController.addSubcontNmrListvalue.value.add(widget.onclickPendingListData[index]);
//                                                   }
//                                                   else{
//                                                     _isChecked[index] = val!;
//                                                     pendingListController.addSubcontNmrListvalue.value.remove(widget.onclickPendingListData[index]);
//                                                   }
//                                                 },
//                                                 );
//                                               },
//                                             ),
//                                           )
//                                         ],
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                         else if(widget.onclickPendingListData[index].projectName.toString().toLowerCase().contains(editingController.text)||widget.onclickPendingListData[index].projectName.toString().toUpperCase().contains(editingController.text)){
//                           return InkWell(
//                             onTap: () {
//
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(5),
//                               child: Card(
//                                 child: Container(
//                                   margin: EdgeInsets.all(5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children:<Widget> [
//                                           Text(widget.onclickPendingListData[index].no.toString(),style: TextStyle(color: Colors.red),),
//                                           //Icon(Icons.remove_red_eye,color: Theme.of(context).primaryColor,),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].date.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Project Name")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].projectName.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Subcontractor Name")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].subContractorName.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("From Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].fromDate.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("To Date")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].toDate.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Manual BillNo")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(widget.onclickPendingListData[index].billno.toString())),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text("Net Amount")),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Text(RequestConstant.CURRENCY_SYMBOL+widget.onclickPendingListData[index].netAmt.toString(),style: TextStyle(color: Colors.red))),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                               flex: 5,
//                                               child: Text("Verified By")),
//                                           Expanded(
//                                               flex: 6,
//                                               child: Text(widget.onclickPendingListData[index].preparedBy.toString(),style: TextStyle(color: Colors.blue),)),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Checkbox(
//                                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))), // Rounded Checkbox
//                                               value: _isChecked[index],
//                                               onChanged: (val) {
//                                                 setState(() {
//                                                   if(val==true){
//                                                     _isChecked[index] = val!;
//                                                     pendingListController.addSubcontNmrListvalue.value.add(widget.onclickPendingListData[index]);
//                                                   }
//                                                   else{
//                                                     _isChecked[index] = val!;
//                                                     pendingListController.addSubcontNmrListvalue.value.remove(widget.onclickPendingListData[index]);
//                                                   }
//                                                 },
//                                                 );
//                                               },
//                                             ),
//                                           )
//                                         ],
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                         else{
//                           return Container();
//                         }
//
//                       }),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top:15),
//                   height: BaseUtitiles.getheightofPercentage(context, 5),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 25),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       side: BorderSide(width: 3, color: Colors.brown),
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),),
//                     child: Text("Approval"),
//                     onPressed: () async{
//                       pendingListController.getNMRAprovalDetList.value.clear();
//                       pendingListController.subcontNmrAproval_buttonApi(context);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class PoVerification extends StatefulWidget {
  PoVerification({Key? key,required this.onclickPendingListData, required this.heading }) : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<PoVerification> createState() => _PoVerificationState();
}

class _PoVerificationState extends State<PoVerification> {

  PendingListController pendingListController = Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.add_PoaprovalListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.onclickPendingListData[index].date.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .supplierName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant.CURRENCY_SYMBOL +
                                                    widget
                                                        .onclickPendingListData[
                                                    index]
                                                        .netAmt
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                    (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor:
                                              Theme.of(context).primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                      () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .add(widget
                                                          .onclickPendingListData[
                                                      index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController.add_PoaprovalListvalue.value.remove(widget.onclickPendingListData[index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.PendingPoVerificationDetDetails(
                                                      "PO VERIFICATION",
                                                      widget.onclickPendingListData[index].id!,
                                                      widget.onclickPendingListData[index].no.toString(), context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: BaseUtitiles.getWidthtofPercentage(context, 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: pendingListController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Text(RequestConstant.VERIFY,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: pendingListController.checkColor == 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        onTap: () async {
                          pendingListController.checkColor = 1;
                          pendingListController.getPoAprovalDetList.value.clear();
                          await pendingListController.poAproval_buttonApi(context, widget.heading.toString());
                          await pendingListController.getPendingList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//-------PO Preapproval------------------

class PoPreApproval extends StatefulWidget {
  PoPreApproval({Key? key, required this.onclickPendingListData, required this.heading}) : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;
  @override
  State<PoPreApproval> createState() => _PoPreApprovalState();
}

class _PoPreApprovalState extends State<PoPreApproval> {

  PendingListController pendingListController = Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.add_PoaprovalListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value = BaseUtitiles.filterSearchResults_PendingList(value, pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.onclickPendingListData[index].date.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .supplierName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant.CURRENCY_SYMBOL +
                                                    widget
                                                        .onclickPendingListData[
                                                    index]
                                                        .netAmt
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                    (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor:
                                              Theme.of(context).primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(() {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .add(widget
                                                          .onclickPendingListData[
                                                      index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController.add_PoaprovalListvalue.value.remove(widget.onclickPendingListData[index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.PendingPoPreApprovalDetDetails(
                                                   "PO PREAPPROVAL PENDING",
                                                      widget.onclickPendingListData[index].id!,
                                                      widget.onclickPendingListData[index].no.toString(), context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: BaseUtitiles.getWidthtofPercentage(context, 25),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: pendingListController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Text(RequestConstant.PREAPPROVAL,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: pendingListController.checkColor == 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        onTap: () async {
                          pendingListController.checkColor = 1;
                          pendingListController.getPoAprovalDetList.value.clear();
                          await pendingListController.poAproval_buttonApi(context, widget.heading.toString());
                          await pendingListController.getPendingList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class PoApprovalDesign extends StatefulWidget {
  PoApprovalDesign(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<PoApprovalDesign> createState() => _PoApprovalDesignState();
}

class _PoApprovalDesignState extends State<PoApprovalDesign> {
  PendingListController pendingListController = Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.add_PoaprovalListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only( left: 15, bottom: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 80),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.onclickPendingListData[index].date.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .supplierName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant.CURRENCY_SYMBOL +
                                                    widget
                                                        .onclickPendingListData[
                                                            index]
                                                        .netAmt
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0))),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              checkColor: Colors.white,
                                              activeColor:
                                                  Theme.of(context).primaryColor,
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_PoaprovalListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController.add_PoaprovalListvalue.value.remove(widget.onclickPendingListData[index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pendingListController.PendingPoApprovalDetDetails(
                                                          "PO APPROVAL",
                                                          widget.onclickPendingListData[index].id!,
                                                          widget.onclickPendingListData[index].no.toString(), context);
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: BaseUtitiles.getWidthtofPercentage(context, 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: pendingListController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              RequestConstant.APPROVAL,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: pendingListController.checkColor == 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        onTap: () async {
                          pendingListController.checkColor = 1;
                          pendingListController.getPoAprovalDetList.value.clear();
                          await pendingListController.poAproval_buttonApi(context, widget.heading.toString());
                          await pendingListController.getPendingList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransferPending extends StatefulWidget {
  TransferPending(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<TransferPending> createState() => _TransferPendingState();
}

class _TransferPendingState extends State<TransferPending> {
  TransferBW_project_Controller transferBW_project_Controller = Get.put(TransferBW_project_Controller());
  PendingListController pendingListController = Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value = widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
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
                  Container(
                    width:BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value = BaseUtitiles.filterSearchResults_PendingList(value, pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10) ),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              transferBW_project_Controller.type.value = "Against Approval";
                              transferBW_project_Controller.itemlistTable_Delete();
                              transferBW_project_Controller.ItemGetTableListdata.value.clear();
                              transferBW_project_Controller.getTransferProject_Alldatas(pendingListController.mainlist.value[index].id!, context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController.mainlist.value[index].no.toString(),
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist.value[index].date.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].dueDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].toProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Approved By",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].approvedby
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    pendingListController.PendingTransferPendingDetDetails(
                                                            "TRANSFER PENDING",
                                                            pendingListController.mainlist.value[index].id!,
                                                            pendingListController.mainlist.value[index].no.toString(), context);
                                                  });
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransferACKPending extends StatefulWidget {
  TransferACKPending(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<TransferACKPending> createState() => _TransferACKPendingState();
}

class _TransferACKPendingState extends State<TransferACKPending> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TransferAcknowledgmentPendingController
      transferAcknowledgmentPendingController =
      Get.put(TransferAcknowledgmentPendingController());

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      pendingListController.pendingmainlist.value.clear();
      pendingListController.pendingmainlist.value =
          widget.onclickPendingListData;
      pendingListController.mainlist.value = widget.onclickPendingListData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            // widget.heading.toString(),
                            widget.heading == "TRANSFER ACKNOWLEDGMENT PENDING"
                                ? "THANSFER ACK PENDING"
                                : "",
                            style: TextStyle(
                                fontSize: RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
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
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: pendingListController.mainlist.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: ()  {
                             transferAcknowledgmentPendingController.deleteDetTableDatas();
                              transferAcknowledgmentPendingController.readListdata.value.clear();
                              transferAcknowledgmentPendingController.editcheck = 0;
                              transferAcknowledgmentPendingController.entrycheck = 0;
                              transferAcknowledgmentPendingController.tranAckAlldatasApi(pendingListController.mainlist.value[index].id!, context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                ConstIcons.list_date,
                                                Text(
                                                  pendingListController
                                                      .mainlist.value[index].date
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              pendingListController
                                                  .mainlist.value[index].no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "From Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].frProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                pendingListController.mainlist
                                                    .value[index].toProjectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Type       ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                pendingListController
                                                    .mainlist.value[index].type
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),

                                          Expanded(
                                              flex: 3,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(left: 15),
                                                        child: Text("More", style: TextStyle(fontWeight: FontWeight.bold , color: Theme.of(context).primaryColor),)),

                                                    CircleAvatar(
                                                      backgroundColor: Theme.of(context).primaryColor,
                                                      radius: 13,
                                                      child: Icon(Icons.more_vert,color: Setmybackground,),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    pendingListController.PendingTransferACKDetails("TRANSFER ACKNOWLEDGMENT PENDING",pendingListController.mainlist.value[index].id!,pendingListController.mainlist.value[index].no.toString(),context);

                                                  });
                                                },
                                              )),

                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompanyLbrAtendance extends StatefulWidget {
  CompanyLbrAtendance(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<CompanyLbrAtendance> createState() => _CompanyLbrAtendanceState();
}

class _CompanyLbrAtendanceState extends State<CompanyLbrAtendance> {
  CompanyNmrAttendanceController companyNmrAttendanceController =
      Get.put(CompanyNmrAttendanceController());
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.heading.toString(),
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
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: Obx(() => ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.onclickPendingListData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              companyNmrAttendanceController.entrycheck = 3;
                              companyNmrAttendanceController
                                  .delete_cmpNmrdetTable();
                              companyNmrAttendanceController.cmpNmr_getDbDetList
                                  .clear();
                              companyNmrAttendanceController
                                  .getPendingList_Alldatas(
                                      widget.onclickPendingListData[index].id!,
                                      context);
                            },
                            child: Container(
                              // height: BaseUtitiles.getheightofPercentage(context, 16),
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          "More",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      radius: 13,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Setmybackground,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    pendingListController
                                                        .PendingPoDetDetails(
                                                            "PENDING PO",
                                                            pendingListController.mainlist.value[index].id!,
                                                            pendingListController.mainlist.value[index].no.toString(),
                                                        pendingListController.mainlist.value[index].projectName.toString(),
                                                            context);
                                                  });
                                                },
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SubContNMRBillApproval extends StatefulWidget {
  SubContNMRBillApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  PendingListController pendingListController =
      Get.put(PendingListController());
  String heading;

  @override
  State<SubContNMRBillApproval> createState() => _SubContNMRBillApprovalState();
}

class _SubContNMRBillApprovalState extends State<SubContNMRBillApproval> {
  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.addSubcontNmrListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      width: BaseUtitiles.getWidthtofPercentage(context, 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Text( RequestConstant.APPROVAL,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      pendingListController.getNMRAprovalDetList.value.clear();
                     await pendingListController.subcontNmrAproval_buttonApi(context);
                    },
                  ),


              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);},
                              child: Text(
                                "Back",
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value = BaseUtitiles.filterSearchResults_PendingList(value, pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.onclickPendingListData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              // height: BaseUtitiles.getheightofPercentage(context, 16),
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                              flex: 2,
                                              child: Container()),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              widget.onclickPendingListData[index].no.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Subcontractor",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget.onclickPendingListData[index].subContractorName.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant.CURRENCY_SYMBOL+widget.onclickPendingListData[index].netAmt.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),

                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "From Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                widget.onclickPendingListData[index].fromDate.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                "To Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                widget.onclickPendingListData[index].toDate.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),

                                        ],
                                      ),
                                      // SizedBox(height: 5),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:
                                      //       EdgeInsets.only(top: 5, left: 10),
                                      //       child: Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "To Date",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 8,
                                      //         child: Text(
                                      //           widget.onclickPendingListData[index].toDate.toString(),
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),
                                      // SizedBox(height: 5),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:
                                      //       EdgeInsets.only(top: 5, left: 10),
                                      //       child: Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "Manual BillNo",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 8,
                                      //         child: Text(
                                      //           widget.onclickPendingListData[index].billno.toString(),
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),


                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Verified By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0))),
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .addSubcontNmrListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .addSubcontNmrListvalue
                                                          .value
                                                          .remove(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          // Expanded(
                                          //     flex: 5,
                                          //     child: InkWell(
                                          //       child: Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Container(
                                          //               margin: EdgeInsets.only(
                                          //                   left: 15),
                                          //               child: Text(
                                          //                 "More",
                                          //                 style: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight.bold,
                                          //                     color: Theme.of(
                                          //                             context)
                                          //                         .primaryColor),
                                          //               )),
                                          //           CircleAvatar(
                                          //             backgroundColor:
                                          //                 Theme.of(context)
                                          //                     .primaryColor,
                                          //             radius: 13,
                                          //             child: Icon(
                                          //               Icons.more_vert,
                                          //               color: Setmybackground,
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //       onTap: () {
                                          //         setState(() {
                                          //           pendingListController
                                          //               .PendingPoDetDetails(
                                          //                   "PENDING PO",
                                          //                   pendingListController
                                          //                       .mainlist
                                          //                       .value[index]
                                          //                       .id!,
                                          //                   pendingListController
                                          //                       .mainlist
                                          //                       .value[index]
                                          //                       .no
                                          //                       .toString(),
                                          //                   context);
                                          //         });
                                          //       },
                                          //     )),
                                          // SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BillGenBOQAproval extends StatefulWidget {
  BillGenBOQAproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<BillGenBOQAproval> createState() => _BillGenBOQAprovalState();
}

class _BillGenBOQAprovalState extends State<BillGenBOQAproval> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.addBillGenBOQListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text( RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    bottomNavigationBar: Container(
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              height: BaseUtitiles.getheightofPercentage(context, 4),
                              width: BaseUtitiles.getWidthtofPercentage(context, 25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Theme.of(context).primaryColor),
                              alignment: Alignment.center,
                              child: Text( RequestConstant.APPROVAL,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: Colors.white),
                              ),
                            ),
                            onTap: () async {
                              pendingListController.getbillBOQAprovalDetList.value.clear();
                              await pendingListController.billGenBOQAproval_buttonApi(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.onclickPendingListData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                              flex: 2,
                                              child: Container()),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Subcontractor",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .subContractorName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant.CURRENCY_SYMBOL+widget.onclickPendingListData[index].netAmt.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "From Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .fromDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .toDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0))),
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController.addBillGenBOQListvalue.value.add(widget.onclickPendingListData[index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController.addBillGenBOQListvalue.value.remove(widget.onclickPendingListData[index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),

                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BillGenDirectAproval extends StatefulWidget {
  BillGenDirectAproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<BillGenDirectAproval> createState() => _BillGenDirectAprovalState();
}

class _BillGenDirectAprovalState extends State<BillGenDirectAproval> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.addBillGenDirectListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text( RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    pendingListController.getbillDirectAprovalDetList.value.clear();
                   await pendingListController.billGenDirectAproval_buttonApi(context);
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),


                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.onclickPendingListData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: ()  {
                              // BaseUtitiles.showToast("Only proccess in Website");
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Subcontractor",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .subContractorName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant.CURRENCY_SYMBOL+widget.onclickPendingListData[index].netAmt.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                            EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "From Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .fromDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "To Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .toDate
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      // SizedBox(height: 5),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:
                                      //       EdgeInsets.only(top: 5, left: 10),
                                      //       child: Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "To Date",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 4,
                                      //         child: Text(
                                      //           widget
                                      //               .onclickPendingListData[index]
                                      //               .toDate
                                      //               .toString(),
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),
                                      // SizedBox(height: 5),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Container(
                                      //       margin:
                                      //       EdgeInsets.only(top: 5, left: 10),
                                      //       child: Text(""),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 3,
                                      //         child: Text(
                                      //           "Manual BillNo",
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //     Expanded(
                                      //         flex: 8,
                                      //         child: Text(
                                      //           widget
                                      //               .onclickPendingListData[index]
                                      //               .billno
                                      //               .toString(),
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),

                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Verified By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0))),
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController.addBillGenDirectListvalue.value.add(widget.onclickPendingListData[index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController.addBillGenDirectListvalue.value.remove(widget.onclickPendingListData[index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AdvanceReqAproval extends StatefulWidget {
  AdvanceReqAproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<AdvanceReqAproval> createState() => _AdvanceReqAprovalState();
}

class _AdvanceReqAprovalState extends State<AdvanceReqAproval> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
      Get.put(PendingListController());
  late List<bool> _isChecked;

  @override
  void initState() {
    pendingListController.add_AdvanceReqListvalue.value.clear();
    _isChecked = List<bool>.filled(widget.onclickPendingListData.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    width: BaseUtitiles.getWidthtofPercentage(context, 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Text( RequestConstant.APPROVAL,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    pendingListController.getAdvanceReqAprovalDetList.value.clear();
                    await pendingListController.advanceAproval_buttonApi(context);
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.heading.toString(),
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          pendingListController.mainlist.value =
                              BaseUtitiles.filterSearchResults_PendingList(
                                  value,
                                  pendingListController.pendingmainlist);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.onclickPendingListData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                  flex: 2,
                                  child: Container()),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              widget.onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                       SizedBox(height: 5),

                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:
                                          EdgeInsets.only(top: 8, left: 10),
                                          child: Text(""),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Date",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Text(
                                              widget
                                                  .onclickPendingListData[index]
                                                  .date
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Acc Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .accName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Acc Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .accType
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Pay For",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .Payfor
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                RequestConstant.CURRENCY_SYMBOL +
                                                    widget
                                                        .onclickPendingListData[
                                                            index]
                                                        .netAmt
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                widget
                                                    .onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Checkbox(
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0))),
                                              // Rounded Checkbox
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    if (val == true) {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_AdvanceReqListvalue
                                                          .value
                                                          .add(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    } else {
                                                      _isChecked[index] = val!;
                                                      pendingListController
                                                          .add_AdvanceReqListvalue
                                                          .value
                                                          .remove(widget
                                                                  .onclickPendingListData[
                                                              index]);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NMRBillVerification extends StatefulWidget {
  NMRBillVerification(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<NMRBillVerification> createState() => _NMRBillVerificationState();
}

class _NMRBillVerificationState extends State<NMRBillVerification> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController =
  Get.put(PendingListController());
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  BillGenerationDirectController billGenerationDirectController=Get.put(BillGenerationDirectController());

  @override
  void initState() {
    pendingListController.pendingmainlist.value.clear();
    pendingListController.pendingmainlist.value = widget.onclickPendingListData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea( top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    //margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            // width: BaseUtitiles.getWidthtofPercentage(context, 40),
                            margin: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                // if (onSearch != null) onSearch!(searchcontroller.text);
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles.filterSearchResults_PendingList(
                                          value,
                                          pendingListController.pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 6, right: 6),
                      height: BaseUtitiles.getheightofPercentage(context, 80),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemCount: pendingListController.mainlist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                if(widget.heading =="SUBCONTRACTOR BILL VERIFICATION - DIRECT" || widget.heading =="SUBCONTRACTOR BILL APPROVAL - DIRECT") {
                                  await billGenerationDirectController.directBillEntryList_EditApi(billGenerationDirectController.bill_entryList.value[index].workId,context,widget.heading =="SUBCONTRACTOR BILL VERIFICATION - DIRECT"?"Verify":"Approve");
                                }else{
                                  await nmrWklyController.NmrEntryList_EditApi(
                                      pendingListController.mainlist
                                          .value[index].id, context,
                                      widget.heading ==
                                          "SUBCONTRACTOR BILL VERIFICATION - NMR"
                                          ? "Verify"
                                          : "Approve");
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(right: 15),
                                              child: Text(
                                                pendingListController.mainlist[index].no.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),

                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist[index].date.toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),

                                        if(widget.heading =="SUBCONTRACTOR BILL VERIFICATION - NMR" || widget.heading =="SUBCONTRACTOR BILL APPROVAL - NMR")Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                  EdgeInsets.only(top: 8, left: 10),
                                                  child: Text(""),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      "From Date",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                      pendingListController.mainlist[index].fromDate.toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(height: 5),

                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                  EdgeInsets.only(top: 8, left: 10),
                                                  child: Text(""),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      "To Date",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                      pendingListController.mainlist[index].toDate.toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                        // Row(
                                        //   children: <Widget>[
                                        //     Container(
                                        //       margin:
                                        //       EdgeInsets.only(top: 8, left: 10),
                                        //       child: Text(""),
                                        //     ),
                                        //     Expanded(
                                        //         flex: 3,
                                        //         child: Text(
                                        //           "Bill No",
                                        //           style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //     Expanded(
                                        //         flex: 8,
                                        //         child: Text(
                                        //           pendingListController.mainlist[index]
                                        //               .billno
                                        //               .toString(),
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         )),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Project",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist[index]
                                                      .projectName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),

                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Site",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist[index]
                                                      .siteName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Subcontractor",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist[index].subContractorName.toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Net Pay Amt",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  "₹${pendingListController.mainlist[index].netAmt.toString()}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Divider(thickness: 1),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Prepared By       ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist.value[index]
                                                      .preparedBy
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),


                                            SizedBox(width: 5),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OfficeVoucherApproval extends StatelessWidget {
  OfficeVoucherApproval(
      {Key? key, required this.onclickPendingListData, required this.heading})
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;

  String heading;

  PendingListController pendingListController =
      Get.put(PendingListController());
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            heading.toString(),
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    // margin: EdgeInsets.only(top: 10, left: 5, bottom: 5),
                    child: TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                        fillColor: Setmybackground,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        // if (onSearch != null) onSearch!(searchcontroller.text);
                      },
                      // textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        pendingListController.mainlist.value =
                            BaseUtitiles.filterSearchResults_PendingList(
                                value,
                                pendingListController.pendingmainlist);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: BaseUtitiles.getheightofPercentage(context, 88),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom:BaseUtitiles.getheightofPercentage(context, 10)),
                        physics: BouncingScrollPhysics(),
                        // itemCount: onclickPendingListData.length,
                        itemCount: pendingListController.mainlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              BaseUtitiles.showToast(
                                  "PO Verification Only in Website");
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              onclickPendingListData[index]
                                                  .no
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 8, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Supplier",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .supplierName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Project",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .projectName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Site",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .siteName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                "Net Amount",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                RequestConstant.CURRENCY_SYMBOL +
                                                    onclickPendingListData[index]
                                                        .netAmt
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Po Type",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .potype
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Divider(thickness: 1),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 5, left: 10),
                                            child: Text(""),
                                          ),
                                          Text(
                                            "Prepared By       ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                onclickPendingListData[index]
                                                    .preparedBy
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WorkOrder extends StatefulWidget {
  WorkOrder(
      {Key? key,
        required this.onclickPendingListData,
        required this.heading
        })
      : super(key: key);
  List<OnclickPendingListResponse> onclickPendingListData;
  String heading;

  @override
  State<WorkOrder> createState() => _WorkOrderState();
}

class _WorkOrderState extends State<WorkOrder> {
  TextEditingController editingController = TextEditingController();
  PendingListController pendingListController = Get.put(PendingListController());
  WorkOrderDirectController workOrderDirectController = Get.put(WorkOrderDirectController());

  @override
  void initState() {
    pendingListController.pendingmainlist.value.clear();
    pendingListController.pendingmainlist.value = widget.onclickPendingListData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await pendingListController.getPendingList();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.heading.toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    //margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin:
                            EdgeInsets.only(top: 10, left: 15, bottom: 5),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              controller: editingController,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.black),
                                isDense: true,
                                fillColor: Setmybackground,
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                              },
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  pendingListController.mainlist.value =
                                      BaseUtitiles
                                          .filterSearchResults_PendingList(
                                          value,
                                          pendingListController
                                              .pendingmainlist);
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style:
                                TextStyle(color: Colors.grey, fontSize: 15),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 6, right: 6),
                      height: BaseUtitiles.getheightofPercentage(context, 80),
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                              bottom: BaseUtitiles.getheightofPercentage(
                                  context, 10)),
                          physics: BouncingScrollPhysics(),
                          itemCount: pendingListController.mainlist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                if(widget.heading ==
                                    "WORK ORDER APPROVAL PENDING"){
                                  workOrderDirectController
                                      .workOrder_itemlistTable_Delete();
                                  await workOrderDirectController
                                      .workOrderEntryList_EditApi(
                                      pendingListController
                                          .mainlist.value[index].id,
                                      context,
                                      type: widget.heading ==
                                          "WORK ORDER APPROVAL PENDING"
                                          ? "Approve"
                                          : "Verify");
                                }
                                },
                              child: Container(
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              margin:
                                              EdgeInsets.only(right: 1),
                                              child: Text(
                                                pendingListController
                                                    .mainlist[index].no
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController
                                                      .mainlist[index].date
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 8, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Project",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController
                                                      .mainlist[index]
                                                      .projectName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Site",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController
                                                      .mainlist[index].siteName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Subcontractor",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController
                                                      .mainlist[index]
                                                      .subContractorName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Net Pay Amt",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController
                                                      .mainlist[index].netAmt
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Divider(thickness: 1),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Prepared By       ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  pendingListController.mainlist
                                                      .value[index].PreparedByName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
