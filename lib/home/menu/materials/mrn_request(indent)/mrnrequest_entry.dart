import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../../controller/consumption_controller.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../../constants/ui_constant/icons_const.dart';
import '../../../../../controller/bottomsheet_Controllers.dart';
import '../../../../../commonpopup/projectalert.dart';
import '../../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../../controller/dailyentries_controller.dart';
import '../../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../../controller/logincontroller.dart';
import '../../../../../controller/mrn_request_indent_controller.dart';
import '../../../../../controller/pendinglistcontroller.dart';
import '../../../../../controller/projectcontroller.dart';
import '../../../../../controller/sitecontroller.dart';
import '../../../../../controller/subcontcontroller.dart';
import '../../../../../utilities/baseutitiles.dart';
import '../../../../../utilities/requestconstant.dart';
import '../../../../commonpopup/requesttype_alert.dart';

class MRNRequest_Indent_Entry extends StatefulWidget {
  const MRNRequest_Indent_Entry({Key? key}) : super(key: key);

  @override
  State<MRNRequest_Indent_Entry> createState() =>
      _MRNRequest_Indent_EntryState();
}

class _MRNRequest_Indent_EntryState extends State<MRNRequest_Indent_Entry> {
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller = Get.put(DailyWrkDone_DPRNEW_Controller());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  PendingListController pendingListController = Get.put(PendingListController());
  Consumption_Controller consumption_controller = Get.put(Consumption_Controller());
  ProjectShowPopup projectShowPopup = Get.put(const ProjectShowPopup(list: []));
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  // final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> listFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      mrn_request_controller.reqId = 0;
      await autoYearWiseNoController.MRNRequest_AutoYearWise();
      mrn_request_controller.autoYearWiseNoController.text = autoYearWiseNoController.MRNIndent_autoYrsWise.value;
      if (mrn_request_controller.screenCheck == "Verify" ) {
        mrn_request_controller.pendingAllDatasList.forEach((element) {
          mrn_request_controller.reqId = element.reqId;
          mrn_request_controller.autoYearWiseNoController.text = element.reqNo;
          mrn_request_controller.RequestDateController.text = element.reqDate;
          mrn_request_controller.DuedateController.text = element.reqDueDate;
          projectController.selectedProjectId.value = element.projectId;
          siteController.selectedsiteId.value = element.siteId;
          projectController.projectname.text = element.projectName;
          siteController.Sitename.text = element.siteName;
          mrn_request_controller.preparedbyController.text = element.preparedbyName;
          mrn_request_controller.RemarksController.text = element.reqRemarks;
          mrn_request_controller.ReqTypeController.text =
              element.PurchaseTypeName.toString();
          mrn_request_controller.ReqType.value = element.purchaseType.toString();
        });
      }
      else if (mrn_request_controller.editCheck == 1 || mrn_request_controller.screenCheck == "PreApprove" || mrn_request_controller.screenCheck == "GMApprove") {
        mrn_request_controller.Material_EditListApiValue.forEach((element) {
          mrn_request_controller.reqId = element.reqId;
          mrn_request_controller.autoYearWiseNoController.text = element.reqNo;
          mrn_request_controller.RequestDateController.text = element.reqDate;
          mrn_request_controller.DuedateController.text = element.reqDueDate;
          projectController.selectedProjectId.value = element.projectId;
          siteController.selectedsiteId.value = element.siteId;
          projectController.projectname.text = element.projectName;
          siteController.Sitename.text = element.siteName;
          mrn_request_controller.preparedbyController.text = element.preparedbyName;
          mrn_request_controller.RemarksController.text = element.reqRemarks;
          mrn_request_controller.ReqTypeController.text =
              element.PurchaseTypeName.toString();
          mrn_request_controller.ReqType.value = element.purchaseType.toString();
        });
      }
     else if (mrn_request_controller.entrycheck == 0) {
        mrn_request_controller.screenCheck == "Submit";
        mrn_request_controller.reqId = 0;
        mrn_request_controller.saveButton.value = RequestConstant.SUBMIT;
        mrn_request_controller.delete_MaterialIntent_itemlist_Table();
        mrn_request_controller.Material_itemview_GetDbList.clear();
        if (mounted) {
          await projectController.getProjectList(context, 0);
        }
        projectController.projectname.text = "--Select--";
        projectController.selectedProjectId.value = 0;
        subcontractorController.Subcontractorname.text = "--Select--";
        subcontractorController.selectedSubcontId.value = 0;
        mrn_request_controller.RemarksController.clear();
        mrn_request_controller.RequestDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        mrn_request_controller.DuedateController.text = BaseUtitiles.initiateCurrentDateFormat();
        mrn_request_controller.preparedbyController.text = loginController.EmpName();
        mrn_request_controller.autoYearWiseNoController.text = autoYearWiseNoController.MRNIndent_autoYrsWise.value;
        siteController.selectedsiteId = 0.obs;
        siteController.selectedsitedropdownName = "--Select--".obs;
        siteController.getSiteDropdownvalue.value.clear();
        siteController.Sitename.text = RequestConstant.SELECT;
        siteController.siteDropdownName.clear();
        bottomsheetControllers.searchcontroller.text = "";
        mrn_request_controller.ReqTypeController.text = "--Select--";
        mrn_request_controller.ReqType.value = "0";
      }
      projectController.mainlist.value.clear();
      projectController.mainlist.value = projectController.getdropDownvalue.value;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: SafeArea(top: false,
          child: Scaffold(
            backgroundColor: Setmybackground,
            body: Stack(children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 5)),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Obx(()=>
                                Text(
                                mrn_request_controller.saveButton.value=="Submit"? "MRN Request (Indent)":mrn_request_controller.saveButton.value=="Verify"?"MRN Verification": "${mrn_request_controller.saveButton.value}",
                                style: TextStyle(
                                    fontSize: RequestConstant.Heading_Font_SIZE,
                                    fontWeight: FontWeight.bold),
                                                           ),
                             ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Back",
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: mrn_request_controller.autoYearWiseNoController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Request No",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.requestNo),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: mrn_request_controller.RequestDateController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Request Date",
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE,
                                      ),
                                      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.date),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 10, bottom: 5),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller:
                                    mrn_request_controller.DuedateController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Due Date",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: ConstIcons.date),
                                    ),
                                    onTap: () async {
                                      if (mrn_request_controller.screenCheck == "Verify" || mrn_request_controller.screenCheck == "PreApprove" || mrn_request_controller.screenCheck == "GMApprove") {
                                      } else {
                                        var Entrydate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                            builder: (context, child) {
                                              return Theme(
                                                data: Theme.of(context).copyWith(
                                                  colorScheme: ColorScheme.light(
                                                    primary: Theme.of(context)
                                                        .primaryColor,
                                                    // header background color
                                                    onPrimary: Colors.white,
                                                    // header text color
                                                    onSurface: Colors
                                                        .black, // body text color
                                                  ),
                                                  textButtonTheme:
                                                  TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.black, // button text color
                                                    )),
                                                ),
                                                child: child!,
                                              );
                                            });
                                        mrn_request_controller.DuedateController.text = BaseUtitiles.selectDateFormat(Entrydate!);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: mrn_request_controller.ReqTypeController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Request Type",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                ),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.types,
                                ),
                              ),
                              onTap: () async {
                                if (mrn_request_controller.screenCheck ==
                                    "PendingScreen") {
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const RequestType_Alert();
                                      });
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side:
                            const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: projectController.projectname,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Project Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.projectName),
                              ),
                              onTap: () {
                                setState(() {
                                  if (mrn_request_controller.screenCheck == "Verify" ||
                                      mrn_request_controller.Material_itemview_GetDbList.value.isNotEmpty || mrn_request_controller.screenCheck == "PreApprove" || mrn_request_controller.screenCheck == "GMApprove") {
                                  } else {
                                    bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value);
                                  }
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              controller: siteController.Sitename,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Site Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.siteName),
                              ),
                              onTap: () {
                                setState(() {
                                  if (mrn_request_controller.screenCheck == "Verify" ||
                                      mrn_request_controller.Material_itemview_GetDbList.value.isNotEmpty|| mrn_request_controller.screenCheck == "PreApprove"|| mrn_request_controller.screenCheck == "GMApprove") {
                                  } else {
                                    bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value);
                                  }
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                              mrn_request_controller.preparedbyController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Prepared By",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.preparedBy),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: false,
                              controller:
                              mrn_request_controller.RemarksController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Remarks",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.remarks),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: BaseUtitiles.getheightofPercentage(context, 1)),
                      Visibility(
                        visible: mrn_request_controller.screenCheck == "Verify" || mrn_request_controller.screenCheck == "PreApprove" || mrn_request_controller.screenCheck == "GMApprove" ? false : true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Setmybackground,
                                ),
                                onPressed: () {
                                  if (mrn_request_controller.screenCheck == "Verify"|| mrn_request_controller.screenCheck == "PreApprove"|| mrn_request_controller.screenCheck == "GMApprove") {
                                  } else if(projectController.selectedProjectId.value == 0){
                                    Fluttertoast.showToast(msg: "Please select project name");
                                  }else if(siteController.selectedsiteId.value == 0){
                                    Fluttertoast.showToast(msg: "Please select site name");
                                  }else {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      setState(() {
                                        mrn_request_controller.getMaterialList(context, mrn_request_controller.ReqType.value.toString());
                                      });
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text("Add Materials",
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor)),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: height),
                    ],
                  ),
                ),
                Obx(() => Visibility(
                  visible: mrn_request_controller.Material_itemview_GetDbList.value.isEmpty
                      ? false
                      : true,
                  child: SizedBox(
                    height: BaseUtitiles.getheightofPercentage(context, 100),
                    child: DraggableScrollableSheet(
                      minChildSize: 0.1,
                      maxChildSize: 0.9,
                      initialChildSize: 0.3,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Setmybackground,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top: 40.0,left: 8.0,right: 8.0),
                                          child: SizedBox(
                                              child: Obx(
                                                    () => ListView.builder(
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  physics: const ScrollPhysics(),
                                                  itemCount: mrn_request_controller.Material_itemview_GetDbList.value.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    mrn_request_controller.Material_itemlist_textControllersInitiate();
                                                    return Card(
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: <Widget>[
                                                          Container(
                                                            margin: const EdgeInsets.only(left: 10, top: 10),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Text(
                                                                  "${mrn_request_controller.Material_itemview_GetDbList.value[index].material} (${mrn_request_controller.Material_itemview_GetDbList.value[index].scale})",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: RequestConstant.ALERT_Font_SIZE,
                                                                      color: Theme.of(context).primaryColor),
                                                                ),
                                                                mrn_request_controller.saveButton.value=="Submit" || mrn_request_controller.saveButton.value=="Re-Submit" ? SizedBox(
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (context) => AlertDialog(
                                                                          title: const Text(
                                                                            RequestConstant.DO_YOU_WANT_DELETE,
                                                                            style: TextStyle(color: Colors.black),
                                                                          ),
                                                                          actions: <Widget>[
                                                                            Container(
                                                                              margin: const EdgeInsets.only(left: 20, right: 20),
                                                                              child: IntrinsicHeight(
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: const Text(
                                                                                          "Cancel",
                                                                                          style: TextStyle(
                                                                                            color: Colors.grey,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontSize: RequestConstant.Lable_Font_SIZE,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    VerticalDivider(
                                                                                      color: Colors.grey.shade400,
                                                                                      width: 5,
                                                                                      thickness: 2,
                                                                                      indent: 15,
                                                                                      endIndent: 15,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: TextButton(
                                                                                          onPressed: () {
                                                                                            mrn_request_controller.deleteParticularList(mrn_request_controller.Material_itemview_GetDbList[index]);
                                                                                            mrn_request_controller.Material_itemview_GetDbList.remove(mrn_request_controller.Material_itemview_GetDbList[index]);
                                                                                            mrn_request_controller.getMaterialTablesDatas();
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: const Icon(Icons.remove_circle, color: Colors.red),
                                                                  ),
                                                                ):SizedBox(),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: const EdgeInsets.only(top: 10),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 3,
                                                                      child: Container(
                                                                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                                                                        child: RichText(
                                                                          text: TextSpan(
                                                                              style: const TextStyle(
                                                                                fontSize: 12.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Colors.black,
                                                                              ),
                                                                              children: <TextSpan>[
                                                                                const TextSpan(
                                                                                  text: "Quantity",
                                                                                ),
                                                                                TextSpan(
                                                                                  text: mrn_request_controller.Addwork_qtyControllers[index].text != "" && mrn_request_controller.Addwork_qtyControllers[index].text != "0" && mrn_request_controller.Addwork_qtyControllers[index].text != "0.0" ? "" : " *",
                                                                                  style: TextStyle(
                                                                                    color: mrn_request_controller.Addwork_qtyControllers[index].text != "" && mrn_request_controller.Addwork_qtyControllers[index].text != "0" && mrn_request_controller.Addwork_qtyControllers[index].text != "0.0" ? Colors.white : Colors.red,
                                                                                    fontSize: 12.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ]),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 5,
                                                                      child: Container(
                                                                        margin: const EdgeInsets.only(top: 5, right: 10, bottom: 10),
                                                                        height: BaseUtitiles.getheightofPercentage(context, 3),
                                                                        width: BaseUtitiles.getWidthtofPercentage(context, 20),
                                                                        child: TextFormField(
                                                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                          onTap: () {
                                                                            setState(() {
                                                                              if (mrn_request_controller.Addwork_qtyControllers[index].text != "" && mrn_request_controller.Addwork_qtyControllers[index].text != "0" && mrn_request_controller.Addwork_qtyControllers[index].text != "0.0") {
                                                                                return;
                                                                              } else {
                                                                                mrn_request_controller.Addwork_qtyControllers[index].text = "";
                                                                                mrn_request_controller.MaterialItemlist_clickEdit();
                                                                              }
                                                                            });
                                                                          },
                                                                          cursorColor: Theme.of(context).primaryColor,
                                                                          textAlign: TextAlign.center,
                                                                          controller: mrn_request_controller.Addwork_qtyControllers[index],
                                                                          keyboardType: TextInputType.number,
                                                                          decoration: InputDecoration(
                                                                            contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor), borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                            errorStyle: const TextStyle(
                                                                              color: Colors.red,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 10.0,
                                                                            ),
                                                                            errorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(2.0),
                                                                              borderSide: const BorderSide(
                                                                                color: Colors.red,
                                                                              ),
                                                                            ),
                                                                            focusedErrorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(2.0),
                                                                              borderSide: const BorderSide(
                                                                                color: Colors.red,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          style: const TextStyle(color: Colors.black),
                                                                          onChanged: (value) {
                                                                            setState(() {
                                                                              mrn_request_controller.MaterialItemlist_clickEdit();
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 5,
                                                                      child: Container(),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets.only(top: 5, right: 10, left: 10),
                                                                  height: BaseUtitiles.getheightofPercentage(context, 3),
                                                                  child: TextFormField(
                                                                    cursorColor: Theme.of(context).primaryColor,
                                                                    textAlign: TextAlign.center,
                                                                    controller: mrn_request_controller.Addwork_descControllers[index],
                                                                    keyboardType: TextInputType.multiline,
                                                                    decoration: InputDecoration(
                                                                      labelText: 'Description',
                                                                      labelStyle: const TextStyle(color: Colors.black,fontSize: 12.0),
                                                                      contentPadding: const EdgeInsets.fromLTRB(5.0,0.0, 5.0, 0.0),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                                      enabledBorder: const OutlineInputBorder(
                                                                          borderSide: BorderSide(color: Colors.grey),
                                                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                    ),
                                                                    style: const TextStyle(color: Colors.black),
                                                                    onChanged: (value) {
                                                                      mrn_request_controller.MaterialItemlist_clickEdit();
                                                                    },
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
                                                                  height: BaseUtitiles.getheightofPercentage(context, 3),
                                                                  child: TextField(
                                                                    cursorColor: Theme.of(context).primaryColor,
                                                                    textAlign: TextAlign.center,
                                                                    controller: mrn_request_controller.Addwork_remarksControllers[index],
                                                                    keyboardType: TextInputType.multiline,
                                                                    decoration: InputDecoration(
                                                                      labelText: 'Remarks',
                                                                      labelStyle: const TextStyle(color: Colors.black,fontSize: 12.0),
                                                                      contentPadding: const EdgeInsets.fromLTRB(5.0,0.0,5.0,0.0),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                                      enabledBorder: const OutlineInputBorder(
                                                                          borderSide: BorderSide(color: Colors.grey),
                                                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                    ),
                                                                    style: const TextStyle(color: Colors.black),
                                                                    onChanged: (value) {
                                                                      mrn_request_controller.MaterialItemlist_clickEdit();
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IgnorePointer(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                                        height: 5,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
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
                  ),
                )),
              ],
            ),
            bottomNavigationBar: Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: mrn_request_controller.screenCheck != "Verify"|| mrn_request_controller.screenCheck != "PreApprove"|| mrn_request_controller.screenCheck != "GMApprove"
                        ? true
                        : false,
                    child: Expanded(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: mrn_request_controller.checkColor == 0
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Reset",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color: mrn_request_controller.checkColor == 0
                                    ? Theme.of(context).primaryColor
                                    : Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            mrn_request_controller.checkColor = 1;
                            ResetAlert(context);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: mrn_request_controller.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Obx(() => Text(
                            mrn_request_controller.saveButton.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color: mrn_request_controller.checkColor == 0
                                    ? Colors.white
                                    : Theme.of(context).primaryColor),
                          ))),
                      onTap: () async {
                        mrn_request_controller.checkColor = 0;
                         if(projectController.selectedProjectId.value == 0){
                          Fluttertoast.showToast(msg: "Please select project name");
                      }else if(siteController.selectedsiteId.value == 0){
                          Fluttertoast.showToast(msg: "Please select site name");
                        }else if (mrn_request_controller.Material_itemview_GetDbList.value.isEmpty) {
                          BaseUtitiles.showToast("Please select item list");
                        } else{
                          await SubmitAlert(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Are you sure to Reset?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          mrn_request_controller.reqId = 0;
                          mrn_request_controller.saveButton.value = RequestConstant.SUBMIT;
                          await mrn_request_controller.delete_MaterialIntent_itemlist_Table();
                          mrn_request_controller.Material_itemview_GetDbList
                              .clear();
                          projectController.projectname.text = "--Select--";
                          projectController.selectedProjectId.value = 0;
                          subcontractorController.Subcontractorname.text =
                          "--Select--";
                          subcontractorController.selectedSubcontId.value = 0;
                          mrn_request_controller.RemarksController.clear();
                          mrn_request_controller.RequestDateController.text =
                              BaseUtitiles.initiateCurrentDateFormat();
                          mrn_request_controller.DuedateController.text =
                              BaseUtitiles.initiateCurrentDateFormat();
                          mrn_request_controller.preparedbyController.text =
                              loginController.EmpName();
                          mrn_request_controller.autoYearWiseNoController.text =
                              autoYearWiseNoController
                                  .MRNIndent_autoYrsWise.value;
                          siteController.selectedsiteId.value = 0;
                          siteController.selectedsitedropdownName = "--Select--".obs;
                          siteController.getSiteDropdownvalue.value.clear();
                          siteController.Sitename.text = RequestConstant.SELECT;
                          siteController.siteDropdownName.clear();
                          bottomsheetControllers.searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                        child: Text("Reset",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    mrn_request_controller.buttonControl = 0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: Text( 'Are you sure to ${mrn_request_controller.saveButton.value}?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),

                  Expanded(
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return TextButton(
                          onPressed:  () async {
                            await mrn_request_controller.getMaterialTablesDatas();
                            if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                              await mrn_request_controller
                                  .SaveButton_MaterialIntentScreen(context,
                                mrn_request_controller.reqId != 0
                                    ? mrn_request_controller.reqId
                                    : 0,);
                            }
                            },
                          child: Obx(()=>
                            Text(
                              mrn_request_controller.saveButton.value,
                              style: TextStyle(
                                color: mrn_request_controller.buttonControl == 0
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey, // Change color when disabled
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
