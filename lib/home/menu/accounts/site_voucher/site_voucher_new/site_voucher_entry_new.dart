import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcr/home/menu/accounts/site_voucher/site_voucher_new/site_voucher_sitewise.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../../commonpopup/accountnameadd_alert.dart';
import '../../../../../commonpopup/vouchertype_alert.dart';
import '../../../../../constants/ui_constant/icons_const.dart';
import '../../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../../controller/bottomsheet_Controllers.dart';
import '../../../../../controller/commonvoucher_controller.dart';
import '../../../../../controller/dailyentries_controller.dart';
import '../../../../../controller/logincontroller.dart';
import '../../../../../controller/nmrweeklybill_controller.dart';
import '../../../../../controller/projectcontroller.dart';
import '../../../../../controller/sitecontroller.dart';
import '../../../../../controller/sitevoucher_controller.dart';
import '../../../../../controller/subcontcontroller.dart';
import '../../../../../utilities/baseutitiles.dart';
import '../../../../../utilities/image_view.dart';
import '../../../../../utilities/requestconstant.dart';
import '../../../../punch_in_out/camera_screen.dart';

class SiteVoucher_EntryScreen extends StatefulWidget {
  const SiteVoucher_EntryScreen({Key? key}) : super(key: key);

  @override
  State<SiteVoucher_EntryScreen> createState() =>
      _SiteVoucher_EntryScreenState();
}

class _SiteVoucher_EntryScreenState extends State<SiteVoucher_EntryScreen> {
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  SiteVoucher_Controller siteVoucher_Controller = Get.put(SiteVoucher_Controller());
  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  LoginController loginController = Get.put(LoginController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  DateTime? selectedDate;

  // Future<void> getImage(ImageSource source) async {
  //   try {
  //     final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (pickedFile != null) {
  //       setState(() {
  //         siteVoucher_Controller.imageFiles.add(File(pickedFile.path));
  //         siteVoucher_Controller.count = siteVoucher_Controller.count! + 1;
  //         siteVoucher_Controller.pickedImageCount = siteVoucher_Controller.pickedImageCount + 1;
  //       });
  //     }
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print("Error picking image: $error");
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    siteVoucher_Controller.count?.value = 0;
    siteVoucher_Controller.buttonControl = 0;
    siteVoucher_Controller.pickedImageCount?.value = 0;
    siteVoucher_Controller.imageFiles.clear();
    siteVoucher_Controller.SaveButton.value = "";
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      await commonVoucherController.getAccountTypeList(context, 0,type:"SIT");
      await commonVoucherController.getPayforList(context);
      await autoYearWiseNoController.SiteVoucherAutoYear();
      await projectController.getProjectList(context, 0);
      siteVoucher_Controller.netamountCalculation();
      siteVoucher_Controller.type.value = "";
      siteVoucher_Controller.AutoYearwiseSiteVoc.text =
          autoYearWiseNoController.SiteVoucher_autoYrsWise.value;
      siteVoucher_Controller.VocID = 0;
      if (siteVoucher_Controller.editcheck == 1) {
        siteVoucher_Controller.SaveButton.value = RequestConstant.RESUBMIT;
        siteVoucher_Controller.Sitevoucher_EditListApiValue.forEach((element) {
          siteVoucher_Controller.VocID = element.vocId;
          siteVoucher_Controller.AutoYearwiseSiteVoc.text = element.vocNo;
          siteVoucher_Controller.sitevocDate.text = element.vocDate;
          commonVoucherController.VocType.value = element.vocType;
          commonVoucherController.VoucherTypeController.text =
          element.vocType == "P" ? "Payment" : "Receipt";
          projectController.projectname.text = element.projectName;
          projectController.selectedProjectId.value = element.projectId;
          commonVoucherController.voucherPaidForm.text = element.paidFromName;
          commonVoucherController.vocPaidformId = element.paidFrom;
          commonVoucherController.AccountTypename.text = element.accTypeName;
          commonVoucherController.selectedAccId.value = element.accTypeId;
          commonVoucherController.Accountname.text = element.accNameName;
          commonVoucherController.selectedAccnameId.value = element.accNameId;
          commonVoucherController.selectedAccPayId.value = element.payFor;
          commonVoucherController.namethrough.text = element.nameThrough;
          commonVoucherController.selectedPaymodeId.value = element.payMode;
          siteVoucher_Controller.Amount.text = element.vocAmt.toString();
          siteVoucher_Controller.Remarks.text = element.remarks;
          siteVoucher_Controller.type.value = element.payType == "SP"
              ? "SiteWise Payment"
              : "Direct Payment/Office";
          siteVoucher_Controller.Button.value =
          element.payType == "SP" ? "List" : RequestConstant.RESUBMIT;
          commonVoucherController.AccPayforname.text = element.payForName;
          commonVoucherController.Paymodename.text = element.payModeName;
        });
      }
      if (siteVoucher_Controller.itemcheck == 0 &&
          siteVoucher_Controller.Active == 0) {
        siteVoucher_Controller.SaveButton.value = RequestConstant.SUBMIT;
        siteVoucher_Controller.Button.value = RequestConstant.SUBMIT;
        siteController.selectedsiteId = 0.obs;
        siteVoucher_Controller.type.value = 'Direct Payment/Office';
        siteVoucher_Controller.delete_Sitevoucher_itemlist_Table();
        siteVoucher_Controller.Sitevoucher_itemview_GetDbList.clear();
        // siteVoucher_Controller.Amount.text = "0.00";
        siteController.selectedsitedropdownName = "--Select--".obs;
        siteController.getSiteDropdownvalue.value.clear();
        siteController.Sitename.text = RequestConstant.SELECT;
        siteController.siteDropdownName.clear();
        commonVoucherController.VoucherTypeController.text = "Payment";
        commonVoucherController.voucherPaidForm.text = "PETTY CASH";
        commonVoucherController.vocPaidformId = 1;
        projectController.projectname.text = "--Select--";
        projectController.selectedProjectId.value = 0;
        commonVoucherController.VocType.value = "P";
        commonVoucherController.AccountTypename.text = "--Select--";
        commonVoucherController.Accountname.text = "--Select--";
        commonVoucherController.selectedAccnameId = 0.obs;
        commonVoucherController.setSelectedAccPayForListName("A");
        siteVoucher_Controller.AutoYearwiseSiteVoc.text =
            autoYearWiseNoController.SiteVoucher_autoYrsWise.value;
        siteVoucher_Controller.sitevocDate.text =
            BaseUtitiles.initiateCurrentDateFormat();
        commonVoucherController.Paymodename.text = "BY CASH";
        commonVoucherController.selectedPaymodeId.value = 1;
        commonVoucherController.AccPayforname.text = "--Select--";
        siteVoucher_Controller.Remarks.text = "";
        commonVoucherController.Accountname.text = "--SELECT--";
        commonVoucherController.namethrough.text = "";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return SafeArea(  top: false,
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
                          "Site Voucher",
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
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                          controller: siteVoucher_Controller.AutoYearwiseSiteVoc,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Voucher No",
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
                          controller: siteVoucher_Controller.sitevocDate,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Entry Date",
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                          onTap: () async {
                            var Date = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? DateTime.now(),
                                firstDate: DateTime.now().subtract(Duration(days: 2)),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).primaryColor,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Colors.black,
                                      ),
                                    ),
                                  ),
                                    child: child!,
                                  );
                                }
                            );
                            siteVoucher_Controller.sitevocDate.text = Date.toString().substring(0, 10) ??'';
                            if (Date != null) {
                              setState(() {
                                selectedDate = Date;  // Update the selected date
                              });
                            }
                            // siteVoucher_Controller.getSiteVoc_EntryList();
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
                          controller:
                          commonVoucherController.VoucherTypeController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "VOC Type",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.types),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SiteAndStaffVoucherType();
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
                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                          controller: projectController.projectname,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Project Name *",
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
                          onTap: () {
                            setState(() {
                              bottomsheetControllers.ProjectName(context,
                                  projectController.getdropDownvalue.value);
                              FocusScope.of(context).unfocus();
                            });
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
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: commonVoucherController.AccountTypename,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Account Type",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.types),
                          ),
                          onTap: () {
                            // await commonVoucherController.getAccountTypeList(context);
                            setState(() {
                              bottomsheetControllers.AccountType(context,
                                  commonVoucherController.getdropDownvalue.value);
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
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                          controller: commonVoucherController.Accountname,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Account Name",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.accounttype),
                          ),
                          onTap: () async {
                            await commonVoucherController
                                .getAccountName(context);
                              bottomsheetControllers.AccountName(
                                  context,
                                  commonVoucherController
                                      .getaccdropDownvalue.value);
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
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 5, left: 5),
                              alignment: Alignment.center,
                              height:
                              BaseUtitiles.getheightofPercentage(context, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)),
                                ],
                              ),
                              child: Icon(Icons.add_circle_outline_rounded,
                                  color: Colors.white),
                            ),
                            onTap: () {
                              if (commonVoucherController.AccountTypename.text ==
                                  "OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "SITE-OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "MATERIAL") {
                                if (commonVoucherController.Accountname.text ==
                                    "--Select--" ||
                                    commonVoucherController.Accountname.text ==
                                        "--SELECT--") {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AccountnameAddAlert();
                                      });
                                } else {
                                  BaseUtitiles.showToast(
                                      "You are Not Authorised");
                                }
                              } else {}
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              height:
                              BaseUtitiles.getheightofPercentage(context, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)),
                                ],
                              ),
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                            onTap: () {
                              if (commonVoucherController.AccountTypename.text ==
                                  "OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "SITE-OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "MATERIAL") {
                                if (commonVoucherController.Accountname.text ==
                                    "--Select--" ||
                                    commonVoucherController.Accountname.text ==
                                        "--SELECT--") {
                                  BaseUtitiles.showToast(
                                      "You are Not Authorised");
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AccountnameAddAlert();
                                      });
                                }
                              } else {}
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              height:
                              BaseUtitiles.getheightofPercentage(context, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)),
                                ],
                              ),
                              child:
                              Icon(Icons.delete_forever, color: Colors.white),
                            ),
                            onTap: () async {
                              if (commonVoucherController.AccountTypename.text ==
                                  "OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "SITE-OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "MATERIAL") {
                                if (commonVoucherController.Accountname.text ==
                                    "--Select--" ||
                                    commonVoucherController.Accountname.text ==
                                        "--SELECT--") {
                                } else {
                                  await commonVoucherController
                                      .Accountname_DeleteApi(
                                      commonVoucherController
                                          .selectedAccId.value,
                                      commonVoucherController
                                          .selectedAccnameId.value);
                                  await commonVoucherController
                                      .getAccountName(context);
                                }
                              } else {}
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        alignment: Alignment.center,
                        height: BaseUtitiles.getheightofPercentage(context, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Payment Options",
                            style: TextStyle(
                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                          controller: commonVoucherController.namethrough,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Name Through",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.namethrough),
                          ),
                          onTap: () {},
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
                          readOnly: true,
                          controller: commonVoucherController.AccPayforname,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Pay For",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.payfor),
                          ),
                          onTap: () {
                            bottomsheetControllers.Payfor(
                                context,
                                commonVoucherController
                                    .getPayfordropDownvalue.value);
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
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: commonVoucherController.voucherPaidForm,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Paid Form",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.payfor),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const VoucherPaidForm();
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                                controller: commonVoucherController.Paymodename,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Mode of Pay",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.modeofpay),
                                ),
                                onTap: () async {
                                  await commonVoucherController
                                      .getPaymodeList(context);
                                  setState(() {
                                    bottomsheetControllers.ModeofPay(
                                        context,
                                        commonVoucherController
                                            .getpaymodedropDownvalue.value);
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

                        // Container(
                        //   height: BaseUtitiles.getheightofPercentage(context, 4),
                        //   margin: EdgeInsets.only(left: 10, right: 10),
                        //   decoration: BoxDecoration(),
                        //   child: TextField(
                        //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                        //     readOnly: true,
                        //     controller: commonVoucherController.AccPayforname,
                        //     textAlign: TextAlign.center,
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        //       labelText: "Pay For",
                        //       border: OutlineInputBorder(),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                        //       ),
                        //     ),
                        //     onTap: (){
                        //       commonVoucherController.getPayforList(context);
                        //     },
                        //   ),
                        // ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                                readOnly: siteVoucher_Controller.type.value ==
                                    "SiteWise Payment"
                                    ? true
                                    : false,
                                keyboardType: TextInputType.number,
                                controller: siteVoucher_Controller.Amount,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Amount",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.amount),
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

                        // Container(
                        //   height: BaseUtitiles.getheightofPercentage(context, 4),
                        //   margin: EdgeInsets.only(left: 10, right: 10),
                        //   decoration: BoxDecoration(),
                        //   child: TextField(
                        //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                        //     readOnly: true,
                        //     controller: commonVoucherController.AccPayforname,
                        //     textAlign: TextAlign.center,
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        //       labelText: "Pay For",
                        //       border: OutlineInputBorder(),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                        //       ),
                        //     ),
                        //     onTap: (){
                        //       commonVoucherController.getPayforList(context);
                        //     },
                        //   ),
                        // ),
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
                          controller: siteVoucher_Controller.Remarks,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
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
                  const SizedBox(height: 5),
                  Obx(()=>
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Radio<String>(
                          value: 'Direct Payment/Office',
                          groupValue: siteVoucher_Controller.type.value,
                          fillColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context).primaryColor),
                          onChanged: (value) {
                            setState(() {
                              siteVoucher_Controller.type.value = value!;
                              siteVoucher_Controller.Button =
                                  RequestConstant.SUBMIT.obs;
                            });
                          },
                        ),
                        Container(child: const Text('Direct Payment/Office')),
                        Radio<String>(
                          value: 'SiteWise Payment',
                          groupValue: siteVoucher_Controller.type.value,
                          fillColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context).primaryColor),
                          onChanged: (value) {
                            setState(() {
                              siteVoucher_Controller.type.value = value!;
                              siteVoucher_Controller.Button =
                                  RequestConstant.LIST.obs;
                            });
                          },
                        ),
                        Container(child: const Text('SiteWise Payment')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                            () => Visibility(
                          visible: siteVoucher_Controller.type.value ==
                              "Direct Payment/Office"
                              ? false
                              : true,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Setmybackground,
                            ),
                            onPressed: () {
                              if (projectController.selectedProjectId.value ==
                                  0) {
                                BaseUtitiles.showToast("Please select Site Name");
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const Site_Voucher_Sitewise()));
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
                                Text(
                                  "Add List",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: siteVoucher_Controller.type.value == "Direct Payment/Office" ? 0 : 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Setmybackground,
                          ),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CameraCapturePage(
                                    fromScreen:
                                    "Site Voucher",
                                  )),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.add,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Add image",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(()=>
                      Container(
                        margin: EdgeInsets.all(16.r),
                        height: 150.h,
                        child: siteVoucher_Controller.editcheck == 1
                            ? SizedBox(
                          height: 200.h,
                          width: ScreenUtil().screenWidth,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: siteVoucher_Controller
                                .netWorkImageCount!.value +
                                siteVoucher_Controller.pickedImageCount!.value,
                            itemBuilder: (context, index) {
                              if (index <
                                  siteVoucher_Controller.netWorkImageCount!.value) {
                                return buildNetworkImageItem(index);
                              } else if (index <
                                  siteVoucher_Controller.netWorkImageCount!.value +
                                      siteVoucher_Controller.pickedImageCount!.value) {
                                int pickedIndex = index -
                                    siteVoucher_Controller
                                        .netWorkImageCount!.value;
                                return buildPickedImageItem(pickedIndex);
                              } else {
                                return Container();
                              }
                            },
                          ),
                        )
                            : siteVoucher_Controller.count != 0
                            ? SizedBox(
                          height: 200.h,
                          width: ScreenUtil().screenWidth,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                              siteVoucher_Controller.count!.value,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImageViewPage(
                                                  imagePath:
                                                  siteVoucher_Controller
                                                      .imageFiles[
                                                  index],
                                                  netUrl: false,
                                                )));
                                  },
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.r,
                                            right: 8.r,
                                            bottom: 16.r),
                                        child: Material(
                                          color: Colors.white,
                                          elevation: 1.0,
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(
                                                  20.0)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(25.r),
                                            ),
                                            padding:
                                            EdgeInsets.all(8.r),
                                            child: SizedBox(
                                              height: 150.h,
                                              width: 120.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(15),
                                                child: Image.file(
                                                  siteVoucher_Controller
                                                      .imageFiles[
                                                  index],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 50.h,
                                        width: 50.h,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              siteVoucher_Controller
                                                  .imageFiles
                                                  .remove(siteVoucher_Controller
                                                  .imageFiles[
                                              index]);
                                              siteVoucher_Controller
                                                  .count =
                                                  siteVoucher_Controller
                                                      .count! -
                                                      1;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                            : Container(),
                      )),
                  SizedBox(height: height),
                ],
              ),
            ),
            Obx(() => Visibility(
              visible: siteVoucher_Controller
                  .Sitevoucher_itemview_GetDbList.value.isEmpty
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
                                    SizedBox(height: 10),
                                    ListDetails(context, scrollController),
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
            )),
          ],
        ),
        bottomNavigationBar: Container(
          height: BaseUtitiles.getheightofPercentage(context, 4),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                      color: siteVoucher_Controller.checkColor == 0
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Reset",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: siteVoucher_Controller.checkColor == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      siteVoucher_Controller.checkColor = 1;
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
                      color: siteVoucher_Controller.checkColor == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      siteVoucher_Controller.editcheck == 1
                          ? RequestConstant.RESUBMIT
                          : RequestConstant.SUBMIT,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                          color: siteVoucher_Controller.checkColor == 0
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      siteVoucher_Controller.checkColor = 0;
                      if(siteVoucher_Controller.imageFiles.isEmpty && siteVoucher_Controller.gettingNetworkImageList?.length==0){
                        BaseUtitiles.showToast("Please Add Image");
                      }
                      else{
                        SubmitAlert(context);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
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
              itemCount: siteVoucher_Controller
                  .Sitevoucher_itemview_GetDbList.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  elevation: 3,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 80),
                              child: Text(
                                siteVoucher_Controller
                                    .Sitevoucher_itemview_GetDbList
                                    .value[index]
                                    .sitename
                                    .toString(),
                                style: TextStyle(
                                    fontSize: RequestConstant.App_Font_SIZE,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            Container(
                              height: BaseUtitiles.getheightofPercentage(
                                  context, 2),
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 10),
                              child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          RequestConstant.DO_YOU_WANT_DELETE,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        actions: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.grey,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE))),
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.grey.shade400,
                                                    width: 5,
                                                    thickness: 2,
                                                    indent: 15,
                                                    endIndent:
                                                    15, //Spacing at the bottom of divider.
                                                  ),
                                                  Expanded(
                                                    child: TextButton(
                                                        onPressed: () async {
                                                          siteVoucher_Controller
                                                              .deleteParticularList(
                                                              siteVoucher_Controller
                                                                  .Sitevoucher_itemview_GetDbList[
                                                              index]);
                                                          siteVoucher_Controller
                                                              .Sitevoucher_itemview_GetDbList
                                                              .remove(siteVoucher_Controller
                                                              .Sitevoucher_itemview_GetDbList[
                                                          index]);
                                                          await siteVoucher_Controller
                                                              .getsitevoucherTablesDatas();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Delete",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.red,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE))),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.remove_circle,
                                      color: Colors.red
                                    // color: Theme.of(context).primaryColor

                                  )
                                // Image.asset('assets/cancle.png'),
                              ),
                            ),

                            // Container(
                            //   height: BaseUtitiles.getheightofPercentage(context,2 ),
                            //   width: BaseUtitiles.getWidthtofPercentage(context, 10),
                            //   child: InkWell(
                            //     onTap: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) =>
                            //             AlertDialog(
                            //               title: Text(RequestConstant.DO_YOU_WANT_DELETE,style: TextStyle(color: Colors.black),),
                            //               actions: <Widget>[
                            //                 ElevatedButton(
                            //                     child: Text(RequestConstant.NO,style: TextStyle(color: Colors.white)),
                            //                     onPressed: () {
                            //                       Navigator.pop(context);
                            //                     }
                            //                 ),
                            //                 ElevatedButton(
                            //                     child: Text(RequestConstant.YES,style: TextStyle(color: Colors.white)),
                            //                     onPressed : () async{
                            //                       staffVoucher_Controller.deleteParticularList(staffVoucher_Controller.Sitevoucher_itemview_GetDbList[index]);
                            //                       staffVoucher_Controller.Sitevoucher_itemview_GetDbList.remove(staffVoucher_Controller.Sitevoucher_itemview_GetDbList[index]);
                            //                       await staffVoucher_Controller.getstaffvouchersiteTablesDatas();
                            //                       Navigator.pop(context);
                            //                     }
                            //                 ),
                            //               ],
                            //             ),
                            //       );
                            //     },
                            //     child: Image.asset('assets/cancle.png'),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(top: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Container(
                      //           width: BaseUtitiles.getWidthtofPercentage(context, 25),
                      //           margin: EdgeInsets.only(left: 5),
                      //           child: Text(
                      //             "Site Name",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: RequestConstant.App_Font_SIZE,
                      //                 color: Colors.black),
                      //           )),
                      //       Container(
                      //           width: BaseUtitiles.getWidthtofPercentage(context, 65),
                      //           margin: EdgeInsets.only(right: 5),
                      //           child: Text(
                      //             siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value[index].sitename.toString(),
                      //             style: TextStyle(
                      //               fontSize: RequestConstant.App_Font_SIZE,
                      //               color: Colors.black,
                      //             ),
                      //           )),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 25),
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Payment Type",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                            Container(
                                margin: EdgeInsets.only(right: 5),
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 65),
                                child: Text(
                                  siteVoucher_Controller
                                      .Sitevoucher_itemview_GetDbList
                                      .value[index]
                                      .paytype ==
                                      "A"
                                      ? "Advance"
                                      : "Payment",
                                  style: TextStyle(
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 25),
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 65),
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  siteVoucher_Controller
                                      .Sitevoucher_itemview_GetDbList
                                      .value[index]
                                      .amt
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 25),
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Net Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
                                )),
                            Container(
                                width: BaseUtitiles.getWidthtofPercentage(
                                    context, 65),
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  siteVoucher_Controller
                                      .Sitevoucher_itemview_GetDbList
                                      .value[index]
                                      .NetAmt
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: RequestConstant.App_Font_SIZE,
                                      color: Colors.black),
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

  Future SubmitAlert(BuildContext context) async {
    siteVoucher_Controller.buttonControl=0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(siteVoucher_Controller.editcheck == 1
            ? 'Are you sure to Re-Submit?'
            : 'Are you sure to submit?'),
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
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return TextButton(
                          onPressed:  () async {
                            if (projectController.selectedProjectId.value == 0 ||
                                commonVoucherController.AccountTypename.text == "--Select--" ||
                                commonVoucherController.Accountname.text == "--Select--" ||
                                commonVoucherController.Paymodename.text == "--Select--" ||
                                commonVoucherController.AccPayforname.text == "--Select--" ||
                                double.parse(siteVoucher_Controller.Amount.text) == 0.0) {
                              BaseUtitiles.showToast("Some field is missing");
                            } else {
                              if (await BaseUtitiles.checkNetworkAndShowLoader(
                                  context)) {
                                await siteVoucher_Controller
                                    .SaveButtonSitevoucher_ItemlistScreen(
                                    context,
                                    siteVoucher_Controller.VocID != 0
                                        ? siteVoucher_Controller.VocID
                                        : 0
                                );
                              }
                            }
                          },
                          child: Text(
                            siteVoucher_Controller.editcheck == 1
                                ? RequestConstant.RESUBMIT
                                : RequestConstant.SUBMIT,
                            style: TextStyle(
                              color: siteVoucher_Controller.buttonControl == 0
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

///-----old code
                  // Expanded(
                  //   child: TextButton(
                  //       onPressed: () async {
                  //         // BaseUtitiles.showLoadingDialog(context, Theme.of(context).primaryColor);
                  //         if (siteVoucher_Controller.buttonControl == 0) {
                  //           if (projectController.selectedProjectId.value ==
                  //               0 ||
                  //               commonVoucherController.AccountTypename.text ==
                  //                   "--Select--" ||
                  //               commonVoucherController.Accountname.text ==
                  //                   "--Select--" ||
                  //               commonVoucherController.Paymodename.text ==
                  //                   "--Select--" ||
                  //               commonVoucherController.AccPayforname.text ==
                  //                   "--Select--" ||
                  //               double.parse(
                  //                   siteVoucher_Controller.Amount.text) ==
                  //                   0.0) {
                  //             BaseUtitiles.showToast("Some field is missing");
                  //           } else {
                  //             await siteVoucher_Controller.SaveButtonSitevoucher_ItemlistScreen(context, siteVoucher_Controller.VocID != 0 ? siteVoucher_Controller.VocID : 0);
                  //           }
                  //           siteVoucher_Controller.buttonControl=0;
                  //         }  else if (siteVoucher_Controller.buttonControl == 1) {
                  //           siteVoucher_Controller.buttonControl=0;
                  //           BaseUtitiles.showToast("Please wait... processing.");
                  //         }
                  //       },
                  //       child: Text(
                  //           siteVoucher_Controller.editcheck == 1
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
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          siteVoucher_Controller.SaveButton.value = RequestConstant.SUBMIT;
                          siteVoucher_Controller.Button.value = RequestConstant.SUBMIT;
                          siteController.selectedsiteId = 0.obs;
                          siteVoucher_Controller.type.value =
                          "Direct Payment/Office";
                          siteVoucher_Controller
                              .delete_Sitevoucher_itemlist_Table();
                          siteVoucher_Controller.Sitevoucher_itemview_GetDbList
                              .clear();
                          // siteVoucher_Controller.Amount.text = "0.00";
                          siteController.selectedsitedropdownName =
                              "--Select--".obs;
                          siteController.getSiteDropdownvalue.value.clear();
                          siteController.Sitename.text = RequestConstant.SELECT;
                          siteController.siteDropdownName.clear();
                          commonVoucherController.VoucherTypeController.text =
                          "Payment";
                          projectController.projectname.text = "--Select--";
                          projectController.selectedProjectId.value = 0;
                          commonVoucherController.VocType.value = "P";
                          commonVoucherController.AccountTypename.text =
                          "--Select--";
                          commonVoucherController.Accountname.text =
                          "--Select--";
                          commonVoucherController.selectedAccnameId = 0.obs;
                          commonVoucherController
                              .setSelectedAccPayForListName("A");
                          siteVoucher_Controller.AutoYearwiseSiteVoc.text =
                              autoYearWiseNoController
                                  .SiteVoucher_autoYrsWise.value;
                          siteVoucher_Controller.sitevocDate.text =
                              BaseUtitiles.initiateCurrentDateFormat();
                          commonVoucherController.Paymodename.text =
                          "--Select--";
                          commonVoucherController.AccPayforname.text =
                          "--Select--";
                          siteVoucher_Controller.Remarks.text = "";
                          commonVoucherController.Accountname.text =
                          "--SELECT--";
                          commonVoucherController.namethrough.text = "";
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

  Widget buildNetworkImageItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageViewPage(imageUrl: "${siteVoucher_Controller.gettingNetworkImageList![index].toString()}?time=${DateTime.now().millisecondsSinceEpoch}",netUrl: true,)));
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 16.r),
            child: Material(
              color: Colors.white,
              elevation: 1.0,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                padding: EdgeInsets.all(8.r),
                child: SizedBox(
                  height: 150.h,
                  width: 120.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "${siteVoucher_Controller.gettingNetworkImageList![index].toString()}?time=${DateTime.now().millisecondsSinceEpoch}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            height: 50.h,
            width: 50.h,
            child: GestureDetector(
              onTap: () async {
                await siteVoucher_Controller.deletingImage(siteVoucher_Controller.imageId![index]);
                setState(() {
                  siteVoucher_Controller.gettingNetworkImageList!.removeAt(index);
                  siteVoucher_Controller.imageId!.removeAt(index);
                  siteVoucher_Controller.netWorkImageCount?.value--;
                });
              },
              child: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPickedImageItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageViewPage(
                  imagePath: siteVoucher_Controller.imageFiles[index],
                  netUrl: false,
                )));
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 16.r),
            child: Material(
              color: Colors.white,
              elevation: 1.0,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                padding: EdgeInsets.all(8.r),
                child: SizedBox(
                  height: 150.h,
                  width: 120.w,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: siteVoucher_Controller.imageFiles.isNotEmpty
                          ? Image.file(
                        siteVoucher_Controller.imageFiles[index],
                        fit: BoxFit.cover,
                      )
                          : Container()),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            height: 50.h,
            width: 50.h,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  siteVoucher_Controller.imageFiles.removeAt(index);
                  siteVoucher_Controller.pickedImageCount?.value--;
                });
              },
              child: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
