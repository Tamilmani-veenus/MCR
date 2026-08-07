import '../../../../controller/transfer_acknowledgment_pending_controller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../utilities/baseutitiles.dart';

class TransferAcknow_EntryScreen extends StatefulWidget {
  const TransferAcknow_EntryScreen({Key? key}) : super(key: key);

  @override
  State<TransferAcknow_EntryScreen> createState() => _TransferAcknow_EntryScreenState();
}

class _TransferAcknow_EntryScreenState extends State<TransferAcknow_EntryScreen> {
  TransferAcknowledgmentPendingController transferAcknowController=Get.put(TransferAcknowledgmentPendingController());

  @override
  void initState() {
    if(transferAcknowController.editcheck==1){
      transferAcknowController.editlistDatas.value.forEach((element) {
        transferAcknowController.autoYearWiseNoController.text=element.transferNo.toString();
        transferAcknowController.fromProjectController.text=element.frProject.toString();
        transferAcknowController.toprojectController.text=element.toProject.toString();
        transferAcknowController.frProjectID=element.frProjectId;
        transferAcknowController.toProjectId=element.toProjectId;
        transferAcknowController.toSiteid.value=element.toSiteId;
        transferAcknowController.ackno=element.ackId;
        transferAcknowController.ButtonChanges(transferAcknowController.ackno);
        transferAcknowController.toSitename.text=element.toSiteName.toString();
      });
    }
    if(transferAcknowController.entrycheck==0){
      transferAcknowController.saveButton.value=RequestConstant.SUBMIT;
      transferAcknowController.entryDateController.text=BaseUtitiles.initiateCurrentDateFormat();
      transferAcknowController.transferAlldatas.value.forEach((element) {
        transferAcknowController.autoYearWiseNoController.text=element.transferNo.toString();
        transferAcknowController.fromProjectController.text=element.frProject.toString();
        transferAcknowController.toprojectController.text=element.toProject.toString();
        transferAcknowController.frProjectID=element.frProjectId;
        transferAcknowController.toProjectId=element.toProjectId;
        transferAcknowController.ackno=0;
        transferAcknowController.toSitename.text="--Select--";
        transferAcknowController.toSiteid.value=0;
      });
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Text( transferAcknowController.editcheck == 1 ? RequestConstant.RESUBMIT : RequestConstant.SUBMIT,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      SubmitAlert(context);
                    }
                    else {

                    }
                  }
                 ),
              ],
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child:
              Stack(
                children: [
                  Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transfer Acknowlegment",
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, left: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: transferAcknowController.autoYearWiseNoController,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Request No",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.requestNo),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '\u26A0 Enter user name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: BaseUtitiles.getWidthtofPercentage(context, 35),
                              margin: EdgeInsets.only(top: 5, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: transferAcknowController.entryDateController,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Date",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.date),
                                    ),
                                    onTap: () async {
                                      var Entrydate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context).primaryColor, // header background color
                                                onPrimary: Colors.white, // header text color
                                                onSurface: Colors.black, // body text color
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.black, // button text color
                                                ),
                                              ),
                                            ),
                                              child: child!,
                                            );
                                          });
                                      transferAcknowController.entryDateController.text =BaseUtitiles.selectDateFormat(Entrydate!);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '\u26A0 Enter user name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: transferAcknowController.fromProjectController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "From Project Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.projectName
                                ),
                              ),
                              onTap: () {
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--") {
                                  return '\u26A0 Please select project name.';
                                }
                                return null;
                              },

                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: transferAcknowController.toprojectController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "To Project Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.projectName
                                ),
                              ),
                              onTap: () {
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--") {
                                  return '\u26A0 Please select site name.';
                                }
                                return null;
                              },

                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: transferAcknowController.toSitename,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Site Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.projectName
                                ),
                              ),
                              onTap: () {
                                transferAcknowController.to_siteDropdowntList(context);
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "--Select--") {
                                  return '\u26A0 Please select site name';
                                }
                                return null;
                              },

                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 10),
                      // Container(
                      //   padding: EdgeInsets.only(left: 20, bottom: 8),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 1,
                      //         child: Container(
                      //           height: BaseUtitiles.getheightofPercentage(context, 4),
                      //           child: TextField(
                      //             controller: transferAcknowController.autoYearWiseNoController,
                      //             readOnly: true,
                      //             textAlign: TextAlign.center,
                      //             decoration: InputDecoration(
                      //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      //               focusedBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
                      //               ),
                      //               enabledBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //               ),
                      //               border: OutlineInputBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 1,
                      //         child: Container(
                      //           height: BaseUtitiles.getheightofPercentage(context, 4),
                      //           margin: EdgeInsets.only(left: 10, right: 20),
                      //           decoration: BoxDecoration(),
                      //           child: TextField(
                      //             readOnly: true,
                      //             controller: transferAcknowController.entryDateController,
                      //             decoration: InputDecoration(
                      //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      //               focusedBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //               ),
                      //               enabledBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //               ),
                      //               border: OutlineInputBorder(),
                      //               prefixIcon: Icon(Icons.date_range_sharp,
                      //                   color: Theme.of(context).primaryColor),
                      //             ),
                      //             onTap: () async {
                      //               var Frdate = await showDatePicker(
                      //                   context: context,
                      //                   initialDate: DateTime.now(),
                      //                   firstDate: DateTime(1900),
                      //                   lastDate: DateTime(2100),
                      //                   builder: (context, child) {
                      //                     return Theme(data: Theme.of(context).copyWith(
                      //                       colorScheme: ColorScheme.light(
                      //                         primary: Theme.of(context).primaryColor, // header background color
                      //                         onPrimary: Colors.white, // header text color
                      //                         onSurface: Colors.black, // body text color
                      //                       ),
                      //                       textButtonTheme: TextButtonThemeData(
                      //                         style: TextButton.styleFrom(
                      //                           primary: Colors.black, // button text color
                      //                         ),
                      //                       ),
                      //                     ),
                      //                       child: child!,
                      //                     );
                      //                   });
                      //               transferAcknowController.entryDateController.text =BaseUtitiles.selectDateFormat(Frdate!);
                      //             },
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   child: Column(
                      //     children: <Widget>[
                      //       Container(
                      //         child: Column(
                      //           children: <Widget>[
                      //             Container(
                      //               margin: EdgeInsets.only(top: 10,bottom: 10),
                      //               height: BaseUtitiles.getheightofPercentage(context, 5),
                      //               width: BaseUtitiles.getWidthtofPercentage(context, 90),
                      //               child: TextField(
                      //                 style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                      //                 readOnly: true,
                      //                 controller: transferAcknowController.fromProjectController,
                      //                 decoration: new InputDecoration(
                      //                   contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      //                   labelText: RequestConstant.FROM_PROJECT_NAME,
                      //                   focusedBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //                   ),
                      //                   enabledBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //                   ),
                      //                 ),
                      //                 onTap: () {
                      //                 },
                      //               ),
                      //             ),
                      //             Container(
                      //               margin: EdgeInsets.only(bottom: 10),
                      //               height: BaseUtitiles.getheightofPercentage(context, 5),
                      //               width: BaseUtitiles.getWidthtofPercentage(context, 90),
                      //               child: TextField(
                      //                 style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                      //                 readOnly: true,
                      //                 controller: transferAcknowController.toprojectController,
                      //                 decoration: new InputDecoration(
                      //                   contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      //                   labelText: RequestConstant.TO_PROJECT_NAME,
                      //                   focusedBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //                   ),
                      //                   enabledBorder: OutlineInputBorder(
                      //                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //                   ),
                      //
                      //                 ),
                      //
                      //                 onTap: () {
                      //
                      //                 },
                      //               ),
                      //
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 10,bottom: 10),
                      //   height: BaseUtitiles.getheightofPercentage(context, 5),
                      //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
                      //   child: TextField(
                      //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                      //     readOnly: true,
                      //      controller: transferAcknowController.toSitename,
                      //     decoration: new InputDecoration(
                      //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      //       labelText:RequestConstant.SITE_NAME,
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      //       ),
                      //     ),
                      //     onTap: () {
                      //       transferAcknowController.to_siteDropdowntList(context);
                      //     },
                      //   ),
                      //
                      // ),
                      //  Container(
                      //   child: Container(
                      //     margin: EdgeInsets.only(top: 10),
                      //     height: BaseUtitiles.getheightofPercentage(context, 4),
                      //     child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         primary: Theme.of(context).primaryColor,
                      //         side: BorderSide(width: 3, color: Colors.black),
                      //         elevation: 3,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(30)),
                      //       ),
                      //       onPressed: () async {
                      //         // Save & Update & Approval
                      //         if(transferAcknowController.toSiteid.value==0){
                      //           BaseUtitiles.showToast("Please select SiteName");
                      //         }
                      //         else{
                      //           await transferAcknowController.getDetTablesDatas();
                      //           BaseUtitiles.showLoadingDialog(context,Colors.cyan);
                      //           transferAcknowController.Save_EntryScreen(context,transferAcknowController.ackno);
                      //         }
                      //       },
                      //       child: Text( transferAcknowController.saveButton.value),
                      //     ),
                      //   ),
                      // ),

                    ],
                  ),
                  Obx(() => Container(
                    child: Visibility(
                        visible: transferAcknowController.readListdata.value.isEmpty ? false
                            : true,
                        child: Container(
                          height: BaseUtitiles.getheightofPercentage(context, 100),
                          child: DraggableScrollableSheet(
                            minChildSize: 0.1,
                            maxChildSize: 0.9,
                            initialChildSize: 0.3,
                            builder: (BuildContext context,
                                ScrollController scrollController) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Setmybackground,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                        child: SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5),
                                              Container(
                                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                                  child: ListDetails(context, scrollController)),
                                            ],
                                          ),
                                        )),
                                    IgnorePointer(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(40.0),
                                            topRight: const Radius.circular(40.0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              height: 5,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          // DraggableScrollableSheet(
                          //   minChildSize: 0.1,
                          //   maxChildSize: 0.9,
                          //   initialChildSize: 0.3,
                          //   expand: true,
                          //   builder: (BuildContext context, ScrollController scrollController) {
                          //     return
                          //
                          //     Stack(
                          //       children: [
                          //         Container(
                          //           height: MediaQuery.of(context).size.height * 0.9,
                          //           width: MediaQuery.of(context).size.width,
                          //           color: Colors.green,
                          //           child: Column(
                          //             children: [
                          //               Container(
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.white70,
                          //                   borderRadius: new BorderRadius.only(
                          //                     topLeft: const Radius.circular(40.0),
                          //                     topRight: const Radius.circular(40.0),
                          //                   ),
                          //                 ),
                          //                 child: ListView.builder(
                          //                   controller: scrollController,
                          //                   itemCount: 50,
                          //                   // mrn_request_controller.Material_itemview_GetDbList.value.length,
                          //                   itemBuilder: (BuildContext context, int index) {
                          //                     // mrn_request_controller.Material_itemlist_textControllersInitiate();
                          //                     return ListTile(title: Text('Item $index'));
                          //                   },
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         IgnorePointer(
                          //           child: Container(
                          //             color: Colors.green,
                          //             child: Row(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   margin: EdgeInsets.only(top: 20, bottom: 20),
                          //                   height: 10,
                          //                   width: 100,
                          //                   decoration: BoxDecoration(
                          //                       borderRadius: BorderRadius.circular(10),
                          //                       color: Colors.deepPurpleAccent),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),),
                          //
                          //       ],
                          //     );
                          //
                          //
                          //   },
                          // ),

                        )),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDetails(context, scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 4,
              right: 4,
            ),
            height: BaseUtitiles.getheightofPercentage(context, 80),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: transferAcknowController.readListdata.length,
              itemBuilder: (BuildContext context, int index) {
                transferAcknowController.textControllersInitiate();
                return Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          children: [
                            Text(
                              transferAcknowController.readListdata.value[index].materialName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Dropdown_Font_SIZE,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10,left: 3,right: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Transfer Qty",
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 11),
                                  height: BaseUtitiles
                                      .getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                      readOnly: true,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      controller: transferAcknowController.transferQtyListController[index],
                                      textAlign: TextAlign.center,
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
                                      onChanged:(value){

                                      }
                                  ),
                                )),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Ack Qty",
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  height: BaseUtitiles
                                      .getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                      onTap: (){
                                        if(transferAcknowController.ackQtyListController[index].text != "" && transferAcknowController.ackQtyListController[index].text != "0" && transferAcknowController.ackQtyListController[index].text != "0.0"){
                                          // return;
                                        } else {
                                          setState(() {
                                            transferAcknowController.ackQtyListController[index].text = "";
                                            transferAcknowController.clickEdit();
                                          });
                                        }
                                      },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      controller: transferAcknowController.ackQtyListController[index],
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType
                                          .number,
                                      textAlign: TextAlign.center,
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
                                      onChanged:(value){
                                        setState(() {
                                          transferAcknowController.clickEdit();
                                        });
                                      }
                                  )),
                            )],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10,left: 3,right: 3,bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                RequestConstant.REMARKSES,
                              ),
                            ),
                            Expanded(
                                flex: 11,
                                child: Container(
                                  margin: EdgeInsets.only(left: 0),
                                  height: BaseUtitiles
                                      .getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller:transferAcknowController.detremarksListController[index],
                                    cursorColor: Theme.of(context).primaryColor,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.name,
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
                                    onChanged: (value){
                                      transferAcknowController.updateDetTable();
                                    }
                                  ),
                                )),
                          ],
                        ),
                      ),

                    ],
                  ),
                );

              },
            ),

          ),
        ],
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async    {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(transferAcknowController.editcheck == 1 ? "Are you sure to Re-Submit" : 'Are you sure to Submit?' ),
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
                          // Save & Update & Approval
                          if(_formKey.currentState!.validate()){
                            if(transferAcknowController.toSiteid.value==0){
                              BaseUtitiles.showToast("Please select SiteName");
                            }
                            else{
                              await transferAcknowController.getDetTablesDatas();
                              if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                                transferAcknowController.Save_EntryScreen(
                                    context, transferAcknowController.ackno);
                              }
                            }
                          }
                        },
                        child: Text(transferAcknowController.editcheck == 1 ? RequestConstant.RESUBMIT : RequestConstant.SUBMIT,
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
