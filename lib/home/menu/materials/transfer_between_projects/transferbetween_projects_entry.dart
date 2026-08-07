import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/fromproject_ccontroller.dart';
import '../../../../controller/fromsite_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/transferbw_project_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class TrasferBetweenProjects_Entry extends StatefulWidget {
  const TrasferBetweenProjects_Entry({Key? key}) : super(key: key);

  @override
  State<TrasferBetweenProjects_Entry> createState() =>
      _TrasferBetweenProjects_EntryState();
}

class _TrasferBetweenProjects_EntryState
    extends State<TrasferBetweenProjects_Entry> {
  LoginController loginController = Get.put(LoginController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  TransferBW_project_Controller transferBW_project_Controller =
      Get.put(TransferBW_project_Controller());
  FromSiteController fromsiteController = Get.put(FromSiteController());
  ProjectController projectController = Get.put(ProjectController());
  FromProjectController fromprojectController =
      Get.put(FromProjectController());
  FromProjectController fromProjectController =
      Get.put(FromProjectController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      transferBW_project_Controller.buttonControl = 0;
      await autoYearWiseNoController.TransferBetProject_AutoYearWise();
      await projectController.getProjectListAll(context, 0);
      transferBW_project_Controller.saveButton.value = RequestConstant.SUBMIT;
      transferBW_project_Controller.autoyrwiseText.text =
          autoYearWiseNoController.TransferBetProjectautoYrsWise.toString();
      if (transferBW_project_Controller.editcheck == 1) {
        transferBW_project_Controller.transferId = 1;
        transferBW_project_Controller.editListApiDatas.value.forEach((element) {
          transferBW_project_Controller.ButtonChanges(
              transferBW_project_Controller.editListApiDatas[0].transferId);
          transferBW_project_Controller.transferId =
              transferBW_project_Controller.editListApiDatas[0].transferId;
          transferBW_project_Controller.autoyrwiseText.text =
              element.transferNo.toString();
          transferBW_project_Controller.entryDateText.text =
              element.transferDate.toString();
          fromprojectController.fromprojectname.text =
              element.frProjectName.toString();
          fromprojectController.selectedProjectId.value = element.frProjectId;
          fromsiteController.FromSitename.text = element.frSiteName.toString();
          fromsiteController.selectedsiteId.value = element.frSiteId;
          projectController.projectnameAll.text =
              element.toProjectName.toString();
          projectController.selectedProjectIdAll.value = element.toProjectId;
          transferBW_project_Controller.ReqordNoText.text = element.reqordNo;
          transferBW_project_Controller.transferTypeText.text =
              element.transType == "A    " ? "Against Approval" : "Direct";
          transferBW_project_Controller.type.value=element.transTypeName;
          transferBW_project_Controller.vechicleNoText.text =
              element.vechileNo.toString();
          transferBW_project_Controller.driverNameText.text =
              element.driverName.toString();
          transferBW_project_Controller.dcNoText.text = element.dcNo.toString();
          transferBW_project_Controller.transportCostText.text =
              element.transAmt.toString();
          transferBW_project_Controller.remarksText.text =
              element.remarks.toString();
        });
      }
      if (transferBW_project_Controller.entrycheck == 0) {
        transferBW_project_Controller.transferTypeText.text="Direct";
        transferBW_project_Controller.transferId = 0;
        transferBW_project_Controller.autoyrwiseText.text =
            autoYearWiseNoController.TransferBetProjectautoYrsWise.toString();
        transferBW_project_Controller.entryDateText.text =
            BaseUtitiles.initiateCurrentDateFormat();
        transferBW_project_Controller.prearedbyText.text =
            loginController.EmpName();
        projectController.projectnameAll.text = "--SELECT--";
        projectController.selectedProjectIdAll.value = 0;
        fromprojectController.fromprojectname.text = "--SELECT--";
        fromprojectController.selectedProjectId = 0.obs;
        fromsiteController.selectedsiteId = 0.obs;
        fromsiteController.FromSitename.text = "--SELECT--";
        transferBW_project_Controller.vechicleNoText.text = "";
        transferBW_project_Controller.driverNameText.text = "";
        transferBW_project_Controller.dcNoText.text = "";
        transferBW_project_Controller.transportCostText.text = "0.0";
        transferBW_project_Controller.remarksText.text = "";
        transferBW_project_Controller.entrycheck = 1;
        setState(() {
          transferBW_project_Controller.itemlistTable_Delete();
          transferBW_project_Controller.ItemGetTableListdata.value=[];
        });
      }
      if (transferBW_project_Controller.type.value == "Against Approval" && transferBW_project_Controller.transferAllDatasList.value.length !=0) {
        transferBW_project_Controller.ReqordNoText.text=transferBW_project_Controller.transferAllDatasList[0].appOrdNo.toString();
        transferBW_project_Controller.transferTypeText.text =transferBW_project_Controller.type.value;
        // transferBW_project_Controller.appNoText.text =
        //     transferBW_project_Controller.transferAllDatasList[0].appOrdNo
        //         .toString();
        projectController.projectnameAll.text = transferBW_project_Controller
            .transferAllDatasList[0].toProjectName
            .toString();
        projectController.selectedProjectIdAll.value =
            transferBW_project_Controller.transferAllDatasList[0].toProjectid;
      }

      if (transferBW_project_Controller.type == "Against Approval" &&
          fromProjectController.selectedProjectId.value != 0 &&
          fromsiteController.selectedsiteId.value != 0) {
      } else {

      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transfer Between Projects",
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
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
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: transferBW_project_Controller
                                      .autoyrwiseText,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Transfer No",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                        BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.requestNo),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.only(top: 5, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: false,
                                  controller:
                                      transferBW_project_Controller.entryDateText,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                        BoxConstraints(minWidth: 0, minHeight: 0),
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
                          padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: fromprojectController.fromprojectname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: RequestConstant.FROM_PROJECT_NAME,
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
                            onTap: () async {
                              if (transferBW_project_Controller.type.value ==
                                  "Direct") {
                                await fromprojectController.getProjectList(
                                    context, 0, 0);
                                await bottomsheetControllers.FromProjectName(
                                    context,
                                    fromprojectController.getdropDownvalue.value);
                              }
                              else {
                                if (fromprojectController
                                        .selectedProjectId.value ==
                                    0) {
                                  await fromprojectController.getProjectList(
                                      context,
                                      0,
                                      transferBW_project_Controller
                                          .transferAllDatasList[0].reqMasId);
                                  bottomsheetControllers.FromProjectName(
                                      context,
                                      fromprojectController
                                          .getdropDownvalue.value);
                                }
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--Select--") {
                                return '\u26A0 Please select from projects name';
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
                          padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: fromsiteController.FromSitename,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: RequestConstant.FROM_SITE_NAME,
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.siteName),
                            ),
                            onTap: () async {
                              await bottomsheetControllers.FromSiteName(context,
                                  fromsiteController.getSiteDropdownvalue.value);
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
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
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
                            controller: projectController.projectnameAll,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: RequestConstant.TO_PROJECT_NAME,
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
                                if (transferBW_project_Controller.type.value ==
                                    "Direct") {
                                  setState(() {
                                    // projectController.getProjectListAll(context, 0);
                                    transferBW_project_Controller
                                        .itemlistTable_Delete();
                                    transferBW_project_Controller
                                        .ItemGetTableListdata.value
                                        .clear();
                                    bottomsheetControllers.projectnameAll(
                                        context,
                                        projectController
                                            .getdropDownvalueAll.value);
                                  });
                                }
                              });
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
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                transferBW_project_Controller.transferTypeText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Transfer Type",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.types,
                              ),
                            ),
                            onChanged: (value) {},
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

                    Obx(()=>
                      Visibility(
                        visible: transferBW_project_Controller.type.value ==
                                "Against Approval"
                            ? true
                            : false,
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                readOnly: true,
                                controller:
                                transferBW_project_Controller.ReqordNoText,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "ReqOrdNo",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.dcNo,
                                  ),
                                ),
                                onChanged: (value) {},
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
                          padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                transferBW_project_Controller.prearedbyText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: RequestConstant.PREPARED_BY,
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.preparedBy),
                            ),
                            onChanged: (value) {},
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
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
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
                            controller:
                                transferBW_project_Controller.vechicleNoText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Vehicle No",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.vehicleNo),
                            ),
                            onChanged: (value) {},
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
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
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
                            controller:
                                transferBW_project_Controller.driverNameText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Driver Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.driverName),
                            ),
                            onChanged: (value) {},
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  // keyboardType: TextInputType.number,
                                  controller:
                                      transferBW_project_Controller.dcNoText,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "DC No",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                        BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.dcNo),
                                  ),
                                  onChanged: (value) {},
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
                          child: Container(
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: transferBW_project_Controller
                                      .transportCostText,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Transport Cost",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                        BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.transportCost),
                                  ),
                                  onChanged: (value) {},
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
                          padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            controller: transferBW_project_Controller.remarksText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: RequestConstant.REMARKS,
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
                            onChanged: (value) {},
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
                    SizedBox(height: 5),
                    Obx(()=>
                      Visibility(
                        visible:
                            transferBW_project_Controller.type.value == "Direct"
                                ? true
                                : false,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Setmybackground,
                                  ),
                                  onPressed: () async {
                                    if (fromprojectController
                                                .selectedProjectId.value !=
                                            0 &&
                                        fromsiteController.selectedsiteId.value !=
                                            0) {
                                      await transferBW_project_Controller
                                          .getTransproject_ItemList(
                                              fromprojectController
                                                  .selectedProjectId.value,
                                              fromsiteController
                                                  .selectedsiteId.value,
                                              0,
                                              transferBW_project_Controller
                                                          .type.value ==
                                                      "Direct"
                                                  ? "D"
                                                  : "A",
                                              context);
                                    } else {}
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Add Items",
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: transferBW_project_Controller
                          .ItemGetTableListdata.value.isEmpty
                      ? false
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
                                        margin: EdgeInsets.only(top: 10),
                                        child: ListDetails(
                                            context, scrollController)),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 20, bottom: 20),
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
                  ),
                ),
              ),

            ],
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: transferBW_project_Controller.checkColor == 0
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: transferBW_project_Controller.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        transferBW_project_Controller.checkColor = 1;
                        ResetAlert(context);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: transferBW_project_Controller.checkColor == 0
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        transferBW_project_Controller.editcheck == 1
                            ? RequestConstant.RESUBMIT
                            : RequestConstant.SUBMIT,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: transferBW_project_Controller.checkColor == 0
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                    onTap: () {
                        if(transferBW_project_Controller.ItemGetTableListdata.isEmpty){
                          Fluttertoast.showToast(msg: "Please add items");
                        }
                        else{

                          bool hasInvalid = false;
                          for (int i = 0; i < transferBW_project_Controller.ItemGetTableListdata.length; i++) {
                            final controller = transferBW_project_Controller.Itemlist_TransQty_ListController[i];
                            final text = controller.text.trim();
                            if (text.isEmpty) {
                              hasInvalid = true;
                              break;
                            }
                            final value = double.tryParse(text);
                            if (value == null || value <= 0) {
                              hasInvalid = true;
                              break;
                            }
                          }
                          if (hasInvalid) {
                            BaseUtitiles.showToast("Transfer Qty Should Not be Zero or Empty");
                          }
                          else {
                            SubmitAlert(context);
                            transferBW_project_Controller.transqtyvalue = 0;
                          }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: transferBW_project_Controller.type.value == "Against Transfer Request" ||  transferBW_project_Controller.transferTypeText.text == "Against Transfer Request"
          ? Column(
        children: <Widget>[
          // SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
          SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
          Container(
            margin:const EdgeInsets.only(
              top: 10,
              left: 4,
              right: 4,
            ),
            height: MediaQuery.of(context).size.height * 80 / 100,
            child:
            Obx(() => ListView.builder(
              physics:const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: transferBW_project_Controller.ItemGetTableListdata.length,
              itemBuilder: (BuildContext context, int index) {
                transferBW_project_Controller.itemlist_textControllersInitiate();
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:const EdgeInsets.only(left: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(top: 5, left: 5),
                              width: BaseUtitiles.getWidthtofPercentage(context, 88),
                              child: Text(
                                "${transferBW_project_Controller.ItemGetTableListdata[index].materialName} ( ${transferBW_project_Controller.ItemGetTableListdata[index].scale} ) ",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Align(alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,top: 10),
                          child: Text(
                            "Stock Qty (${ transferBW_project_Controller.Itemlist_stockQty_ListController[index].text})",
                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.only(left: 24, right: 4, bottom: 5, top: 10),
                        child:const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Balance Qty",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Transfer Qty",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                          ],
                        ),
                      ),

                      Container(
                        margin:const EdgeInsets.only(left: 7, right: 4, bottom: 8,top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            // Container(
                            //   margin: const EdgeInsets.only(right: 11),
                            //   height: BaseUtitiles.getheightofPercentage(context, 4),
                            //   width: BaseUtitiles.getWidthtofPercentage(context, 38),
                            //   child: TextField(
                            //     readOnly: true,
                            //     cursorColor: Theme.of(context).primaryColor,
                            //     textAlign: TextAlign.center,
                            //     controller: transferBW_project_Controller.Itemlist_stockQty_ListController[index],
                            //     keyboardType: TextInputType.number,
                            //     decoration: InputDecoration(
                            //       contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            //       focusedBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Theme.of(context).primaryColor),
                            //           borderRadius:const BorderRadius.all(
                            //               Radius.circular(10))),
                            //       enabledBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //               Theme.of(context).primaryColor),
                            //           borderRadius:const BorderRadius.all(
                            //               Radius.circular(10))),
                            //     ),
                            //     style: const TextStyle(
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.bold),
                            //     onChanged: (value) {},
                            //   ),
                            // ),
                            Container(
                              margin:const EdgeInsets.only(right: 11, left: 8, bottom: 8),
                              height: BaseUtitiles.getheightofPercentage(context, 4),
                              width: BaseUtitiles.getWidthtofPercentage(context, 38),
                              child: TextFormField(
                                readOnly: true,
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: transferBW_project_Controller.Itemlist_balQty_ListControllers[index],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin:const EdgeInsets.only(right: 11, left: 8, bottom: 8),
                              height: BaseUtitiles.getheightofPercentage(
                                  context, 4),
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 38),
                              child: TextFormField(
                                onTap: (){
                                  if(transferBW_project_Controller.Itemlist_TransQty_ListController[index].text != "" && transferBW_project_Controller.Itemlist_TransQty_ListController[index].text != "0" && transferBW_project_Controller.Itemlist_TransQty_ListController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      transferBW_project_Controller.Itemlist_TransQty_ListController[index].text = "";
                                      transferBW_project_Controller.ItemListEdit();
                                    });
                                  }
                                },
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: transferBW_project_Controller.Itemlist_TransQty_ListController[index],
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  contentPadding:const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                onChanged: (value) {
                                  setState(() {
                                    transferBW_project_Controller.ItemListEdit();
                                  });
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
            ),),
          ),
        ],
      )
          : Column(
        children: <Widget>[
          // SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
          SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
          Container(
            margin:const EdgeInsets.only(
              top: 10,
              left: 4,
              right: 4,
            ),
            height: MediaQuery.of(context).size.height * 80 / 100,
            child: ListView.builder(
              physics:const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: transferBW_project_Controller.ItemGetTableListdata.length,
              itemBuilder: (BuildContext context, int index) {
                transferBW_project_Controller.itemlist_textControllersInitiate();
                return Container(
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:const EdgeInsets.only(left: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 5, left: 5),
                              width: BaseUtitiles.getWidthtofPercentage(context, 88),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${transferBW_project_Controller.ItemGetTableListdata[index].materialName} ( ${transferBW_project_Controller.ItemGetTableListdata[index].scale} ) ",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Bal Qty ( ${transferBW_project_Controller.ItemGetTableListdata[index].balQty} ) ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.only(left: 5, right: 4, bottom: 5, top: 5),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Stock Quantity",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "Transfer Qty",
                              style: TextStyle(color: Colors.black),
                            ),
                            //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                          ],
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.only(left: 7, right: 4, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 11),
                              height: BaseUtitiles.getheightofPercentage(context, 4),
                              width: BaseUtitiles.getWidthtofPercentage(context, 38),
                              child: TextField(
                                readOnly: true,
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: transferBW_project_Controller.Itemlist_stockQty_ListController[index],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius:const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius:const BorderRadius.all(Radius.circular(10))),
                                ),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                onChanged: (value) {},
                              ),
                            ),
                            Container(
                              margin:const EdgeInsets.only(right: 11, left: 8, bottom: 8),
                              height: BaseUtitiles.getheightofPercentage(context, 4),
                              width: BaseUtitiles.getWidthtofPercentage(context, 38),
                              child: TextFormField(
                                onTap: (){
                                  if(transferBW_project_Controller.Itemlist_TransQty_ListController[index].text != "" && transferBW_project_Controller.Itemlist_TransQty_ListController[index].text != "0" && transferBW_project_Controller.Itemlist_TransQty_ListController[index].text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      transferBW_project_Controller.Itemlist_TransQty_ListController[index].text = "";
                                      transferBW_project_Controller.ItemListclickEdit();
                                    });
                                  }
                                },
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: transferBW_project_Controller.Itemlist_TransQty_ListController[index],
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                ),
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                onChanged: (value) {
                                  setState(() {
                                    transferBW_project_Controller.ItemListclickEdit();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin:const EdgeInsets.only(
                      //       left: 5, right: 4, bottom: 5, top: 5),
                      //   child:const Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: <Widget>[
                      //       Text(
                      //         "Rate",
                      //         style: TextStyle(color: Colors.black),
                      //       ),
                      //       Text(
                      //         "Amount",
                      //         style: TextStyle(color: Colors.black),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin:const EdgeInsets.only(left: 7, right: 4, bottom: 6),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: <Widget>[
                      //       Container(
                      //         margin:const EdgeInsets.only(right: 11),
                      //         height: BaseUtitiles.getheightofPercentage(
                      //             context, 4),
                      //         width: BaseUtitiles.getWidthtofPercentage(
                      //             context, 38),
                      //         child: TextField(
                      //           cursorColor: Theme.of(context).primaryColor,
                      //           textAlign: TextAlign.center,
                      //           controller: transferBW_project_Controller
                      //               .Itemlist_Rate_ListController[index],
                      //           keyboardType: TextInputType.number,
                      //           decoration: InputDecoration(
                      //             contentPadding:
                      //             const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      //             focusedBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color:
                      //                         Theme.of(context).primaryColor),
                      //                 borderRadius:const BorderRadius.all(
                      //                     Radius.circular(10))),
                      //             enabledBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color:
                      //                         Theme.of(context).primaryColor),
                      //                 borderRadius:const BorderRadius.all(
                      //                     Radius.circular(10))),
                      //           ),
                      //           style:const TextStyle(
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold),
                      //           onChanged: (value) {
                      //             transferBW_project_Controller
                      //                 .ItemListclickEdit(value);
                      //           },
                      //         ),
                      //       ),
                      //       Container(
                      //         margin:const EdgeInsets.only(right: 11, left: 8),
                      //         height: BaseUtitiles.getheightofPercentage(
                      //             context, 4),
                      //         width: BaseUtitiles.getWidthtofPercentage(
                      //             context, 38),
                      //         child: TextField(
                      //           readOnly: true,
                      //           cursorColor: Theme.of(context).primaryColor,
                      //           textAlign: TextAlign.center,
                      //           controller: transferBW_project_Controller
                      //               .Itemlist_Amt_ListController[index],
                      //           keyboardType: TextInputType.number,
                      //           decoration: InputDecoration(
                      //             contentPadding: const
                      //                 EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      //             focusedBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color:
                      //                         Theme.of(context).primaryColor),
                      //                 borderRadius:const BorderRadius.all(
                      //                     Radius.circular(10))),
                      //             enabledBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color:
                      //                         Theme.of(context).primaryColor),
                      //                 borderRadius:const BorderRadius.all(
                      //                     Radius.circular(10))),
                      //           ),
                      //           style:const TextStyle(
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold),
                      //           onChanged: (value) {},
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
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
                          transferBW_project_Controller.transferId = 0;
                          transferBW_project_Controller.autoyrwiseText.text =
                              autoYearWiseNoController
                                  .TransferBetProjectautoYrsWise.toString();
                          transferBW_project_Controller.entryDateText.text =
                              BaseUtitiles.initiateCurrentDateFormat();
                          transferBW_project_Controller.prearedbyText.text =
                              loginController.EmpName();
                          projectController.projectnameAll.text = "--SELECT--";
                          projectController.selectedProjectIdAll.value = 0;
                          fromprojectController.fromprojectname.text = "--SELECT--";
                          fromprojectController.selectedProjectId = 0.obs;
                          fromsiteController.selectedsiteId = 0.obs;
                          fromsiteController.FromSitename.text = "--SELECT--";
                          transferBW_project_Controller.vechicleNoText.text =
                              "";
                          transferBW_project_Controller.driverNameText.text =
                              "";
                          transferBW_project_Controller.dcNoText.text = "";
                          transferBW_project_Controller.transportCostText.text = "0.0";
                          transferBW_project_Controller.remarksText.text = "";
                          transferBW_project_Controller
                              .ItemGetTableListdata.value
                              .clear();
                          transferBW_project_Controller.entrycheck = 1;
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
    transferBW_project_Controller.buttonControl = 0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(transferBW_project_Controller.editcheck == 1
            ? 'Are you sure to Re-Submit?'
            : 'Are you sure to Submit?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
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
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return TextButton(
                          onPressed:  () async {
                            if (fromsiteController.selectedsiteId.value != 0 &&
                                fromprojectController.selectedProjectId.value != 0 &&
                                projectController.selectedProjectIdAll.value != 0 &&
                                transferBW_project_Controller.vechicleNoText.text != "") {

                              if (fromprojectController.selectedProjectId.value ==
                                  projectController.selectedProjectIdAll.value) {
                                BaseUtitiles.showToast("Same project save can't accept");
                              } else if (transferBW_project_Controller
                                  .ItemGetTableListdata.isEmpty) {
                                BaseUtitiles.showToast("Need Det Items to Save");
                              } else {
                                await transferBW_project_Controller.getItemlistTablesDatas();
                                if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                                  await transferBW_project_Controller
                                      .Save_EntryScreen(
                                      context,
                                      transferBW_project_Controller.transferId);
                                }
                              }
                            } else {
                              BaseUtitiles.showToast("Please enter a valid amount");
                            }
                          },
                          child: Text(
                            transferBW_project_Controller.editcheck == 1
                                ? RequestConstant.RESUBMIT
                                : RequestConstant.SUBMIT,
                            style: TextStyle(
                              color: transferBW_project_Controller.buttonControl == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey, // Change color when disabled
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                            ),
                          ),
                        );
                      },
                    ),
                  )


///---------Old code
                  // Expanded(
                  //   child: TextButton(
                  //       onPressed: () async {
                  //         if (transferBW_project_Controller.buttonControl == 0) {
                  //           if (fromsiteController.selectedsiteId.value != 0 &&
                  //               fromprojectController.selectedProjectId.value != 0 &&
                  //               projectController.selectedProjectIdAll.value != 0 &&
                  //               transferBW_project_Controller.vechicleNoText.text != "") {
                  //             if (fromprojectController.selectedProjectId.value == projectController.selectedProjectIdAll.value) {
                  //               BaseUtitiles.showToast("Same project save can't accept");
                  //             } else if (transferBW_project_Controller.ItemGetTableListdata.isEmpty) {
                  //               BaseUtitiles.showToast("Need Det Items to Save");
                  //             }
                  //             else {
                  //               await transferBW_project_Controller.getItemlistTablesDatas();
                  //               await transferBW_project_Controller.Save_EntryScreen(context, transferBW_project_Controller.transferId);
                  //             }
                  //           } else {
                  //             BaseUtitiles.showToast("Some field is missing");
                  //           }
                  //           transferBW_project_Controller.buttonControl = 0;
                  //         } else if (transferBW_project_Controller.buttonControl == 1) {
                  //           transferBW_project_Controller.buttonControl = 0;
                  //           BaseUtitiles.showToast("Please wait... processing.");
                  //         }
                  //       },
                  //       child: Text(
                  //           transferBW_project_Controller.editcheck == 1
                  //               ? RequestConstant.RESUBMIT
                  //               : RequestConstant.SUBMIT,
                  //           style: TextStyle(
                  //               color: Theme.of(context).primaryColor,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: RequestConstant.Lable_Font_SIZE))),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
