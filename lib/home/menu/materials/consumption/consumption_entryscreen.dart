import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/expense_type_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/consumption_controller.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'consumption_additems.dart';

class Consumption_Entry extends StatefulWidget {
  const Consumption_Entry({Key? key}) : super(key: key);

  @override
  State<Consumption_Entry> createState() => _Consumption_EntryState();
}

class _Consumption_EntryState extends State<Consumption_Entry> {
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
      Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller =
      Get.put(DailyWrkDone_DPRNEW_Controller());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  Consumption_Controller consumption_controller =
      Get.put(Consumption_Controller());
  CommanController commanController = Get.put(CommanController());

  DailyEntriesController dailyEntriesController =
      Get.put(DailyEntriesController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      consumption_controller.buttonControl = 0;
      await autoYearWiseNoController.Consumprion_AutoYearWise();
      await projectController.getProjectList(context, 0);
      await subcontractorController.getSubcontList(context,projectController.selectedProjectId.value,siteController.selectedsiteId.value, subcontractorController.checkScreen = 1);
      consumption_controller.autoYearWiseNoController.text =
          autoYearWiseNoController.Conum_autoYrsWise.value;
      if (consumption_controller.editCheck == 1) {
        consumption_controller.Consum_EditListApiValue.forEach((element) {
          consumption_controller.UsageId = element.usageId;
          consumption_controller.ButtonChanges(
              consumption_controller.Consum_EditListApiValue.value[0].usageId,
              0);
          consumption_controller.autoYearWiseNoController.text =
              element.usageNo;
          consumption_controller.ConsumDate.text = element.usageDate;
          projectController.projectname.text = element.projectName;
          projectController.selectedProjectId.value = element.projectId;
          siteController.Sitename.text = element.siteName;
          siteController.selectedsiteId.value = element.siteId;
          subcontractorController.Subcontractorname.text = element.subContName;
          subcontractorController.selectedSubcontId.value = element.subContId;
          if (element.usageType == "EXP") {
            consumption_controller.expenseTypeController.text = "Usage";
          } else if (element.usageType == "SCR") {
            consumption_controller.expenseTypeController.text = "Scrap";
          } else {
            consumption_controller.expenseTypeController.text = "Repair";
          }
          consumption_controller.Consum_preparedbyController.text =
              element.preparedbyName;
          consumption_controller.Consum_RemarksController.text =
              element.remarks;
        });
      }
      if (consumption_controller.itemCheck == 0) {
        consumption_controller.UsageId = 0;
        consumption_controller.saveButton.value = RequestConstant.SUBMIT;
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        subcontractorController.selectedSubcontId.value = 0;
        subcontractorController.Subcontractorname.text = "--SELECT--";
        consumption_controller.ConsumDate.text =
            BaseUtitiles.initiateCurrentDateFormat();
        consumption_controller.Consum_preparedbyController.text =
            loginController.EmpName();
        consumption_controller.autoYearWiseNoController.text =
            autoYearWiseNoController.Conum_autoYrsWise.value;
        siteController.selectedsiteId = 0.obs;
        siteController.selectedsitedropdownName = "--SELECT--".obs;
        consumption_controller.expenseTypeController.text = "Usage";
        siteController.getSiteDropdownvalue.value.clear();
        siteController.Sitename.text = RequestConstant.SELECT;
        siteController.siteDropdownName.clear();
        consumption_controller.expenseType = "EXP";
        consumption_controller.Consum_RemarksController.text = "";
        consumption_controller.delete_Consum_itemlist_Table();
        consumption_controller.Consum_itemview_GetDbList.clear();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Consumption",
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
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: consumption_controller
                                      .autoYearWiseNoController,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Usage Number",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
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
                            width:
                                BaseUtitiles.getWidthtofPercentage(context, 35),
                            margin: EdgeInsets.only(top: 5, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: consumption_controller.ConsumDate,
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
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
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
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context)
                                                    .primaryColor, // header background color
                                                onPrimary: Colors
                                                    .white, // header text color
                                                onSurface: Colors
                                                    .black, // body text color
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  primary: Colors
                                                      .black, // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        });
                                    consumption_controller.ConsumDate.text =
                                        BaseUtitiles.selectDateFormat(
                                            Entrydate!);
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: projectController.projectname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
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
                                  child: ConstIcons.projectName),
                            ),
                            onTap: () {
                              if (consumption_controller.editCheck == 1) {
                              } else {
                                setState(() {
                                  bottomsheetControllers.ProjectName(context,
                                      projectController.getdropDownvalue.value);
                                });
                              }
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: siteController.Sitename,
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
                                  child: ConstIcons.siteName),
                            ),
                            onTap: () {
                              if (consumption_controller.editCheck == 1) {
                              } else {
                                // siteController.subcont_SiteEntry_SiteDropdowntList(context,0);

                                setState(() {
                                  bottomsheetControllers.SiteName(
                                      context,
                                      siteController
                                          .getSiteDropdownvalue.value);
                                });
                              }
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                subcontractorController.Subcontractorname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: RequestConstant.SUBCONTRACTOR_NAME,
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.subcontractorName),
                            ),
                            onTap: () {
                              // subcontractorController.getSubcontList(context,projectController.selectedProjectId.value);
                              bottomsheetControllers.SubcontractorName(
                                  context,
                                  subcontractorController
                                      .getdropDownvalue.value);
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                consumption_controller.expenseTypeController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Type",
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
                                    return ExpenseTypeAlert();
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
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: consumption_controller
                                .Consum_preparedbyController,
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            controller:
                                consumption_controller.Consum_RemarksController,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Setmybackground),
                            onPressed: () async {
                              if (projectController.selectedProjectId.value !=
                                      0 &&
                                  siteController.selectedsiteId.value != 0) {
                                await consumption_controller
                                    .getStock_Material();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Consumption_AddItems(
                                                list: consumption_controller
                                                    .Stock_List.value)));
                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return  StockAddwrkClickPopup(list: consumption_controller.Stock_List.value,);
                                //     });
                              } else {
                                BaseUtitiles.showToast("Some field is missing");
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.add,
                                    color: Theme.of(context).primaryColor),
                                SizedBox(width: 5),
                                Text(
                                  "Add items",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: consumption_controller
                          .Consum_itemview_GetDbList.value.isEmpty
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: ListDetails(
                                                context, scrollController)),

                                        // ...List.generate(50,
                                        //         (index) => Container(
                                        //         height: 50, child: Text('Container $index')))
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
                        color: consumption_controller.checkColor == 0
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: consumption_controller.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        consumption_controller.checkColor = 1;
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
                        color: consumption_controller.checkColor == 0
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        consumption_controller.editCheck == 1
                            ? RequestConstant.RESUBMIT
                            : RequestConstant.SUBMIT,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: consumption_controller.checkColor == 0
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                    onTap: () {
                      consumption_controller.checkColor = 0;
                      if (consumption_controller.expenseTypeController.text ==
                              "--SELECT--" &&
                          consumption_controller.expenseType == "0") {
                        Fluttertoast.showToast(msg: "Please select type");
                      } else if (consumption_controller
                                  .expenseTypeController.text ==
                              "NO-USAGE" &&
                          consumption_controller
                                  .Consum_RemarksController.text ==
                              "") {
                        Fluttertoast.showToast(msg: "Please enter remarks");
                      } else if (consumption_controller
                                  .expenseTypeController.text !=
                              "NO-USAGE" &&
                          consumption_controller
                              .Consum_itemview_GetDbList.value.isEmpty) {
                        Fluttertoast.showToast(msg: "Please add items");
                      } else {
                        bool hasInvalid = false;
                        for (int i = 0;
                            i <
                                consumption_controller
                                    .Consum_itemview_GetDbList.length;
                            i++) {
                          final controller = consumption_controller
                              .Itemlist_UsageqtyControllers[i];
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
                          BaseUtitiles.showToast(
                              "Usage Qty Should Not be Zero or Empty");
                        } else {
                          SubmitAlert(context);
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

  Widget ListDetails(context, scrollController) {
    return Column(
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
            itemCount:
                consumption_controller.Consum_itemview_GetDbList.value.length,
            itemBuilder: (BuildContext context, int index) {
              consumption_controller
                  .Consumption_itemlist_textControllersInitiate();

              return Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            consumption_controller.Consum_itemview_GetDbList
                                    .value[index].material
                                    .toString() +
                                " (" +
                                consumption_controller.Consum_itemview_GetDbList
                                    .value[index].scale
                                    .toString() +
                                ")",
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Dropdown_Font_SIZE,
                                color: Theme.of(context).primaryColor),
                          ),
                          Container(
                            height:
                                BaseUtitiles.getheightofPercentage(context, 2),
                            width:
                                BaseUtitiles.getWidthtofPercentage(context, 10),
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
                                                        Navigator.pop(context);
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
                                                      onPressed: () {
                                                        consumption_controller
                                                            .deleteParticularList(
                                                                consumption_controller
                                                                        .Consum_itemview_GetDbList[
                                                                    index]);
                                                        consumption_controller
                                                                .Consum_itemview_GetDbList
                                                            .remove(consumption_controller
                                                                    .Consum_itemview_GetDbList[
                                                                index]);
                                                        consumption_controller
                                                            .getConumTablesDatas();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Delete",
                                                          style: TextStyle(
                                                              color: Colors.red,
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
                                child:
                                    Icon(Icons.remove_circle, color: Colors.red
                                        // color: Theme.of(context).primaryColor

                                        )
                                // Image.asset('assets/cancle.png'),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              height: BaseUtitiles.getheightofPercentage(
                                  context, 4),
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 25),
                              child: TextField(
                                readOnly: true,
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: consumption_controller
                                    .Itemlist_stockqtyControllers[index],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Stock Quantity',
                                  labelStyle: TextStyle(color: Colors.black),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                                style: TextStyle(color: Colors.black),
                                onTap: () {
                                  BaseUtitiles.showToast("Can't be edit");
                                },
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.shade400,
                              width: 5,
                              thickness: 2,
                              indent: 15,
                              endIndent: 15, //Spacing at the bottom of divider.
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              height: BaseUtitiles.getheightofPercentage(
                                  context, 4),
                              width: BaseUtitiles.getWidthtofPercentage(
                                  context, 25),
                              child: TextField(
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                controller: consumption_controller
                                    .Itemlist_UsageqtyControllers[index],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Usage Quantity',
                                  labelStyle: TextStyle(color: Colors.black),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                                style: TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  consumption_controller
                                      .ConsumItemlist_clickEdit();
                                },
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
      ],
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
                        onPressed: () {
                          setState(() {
                            consumption_controller.UsageId = 0;
                            consumption_controller.saveButton.value =
                                RequestConstant.SUBMIT;
                            projectController.projectname.text = "--SELECT--";
                            projectController.selectedProjectId.value = 0;
                            subcontractorController.selectedSubcontId.value = 0;
                            subcontractorController.Subcontractorname.text =
                                "--SELECT--";
                            consumption_controller.ConsumDate.text =
                                BaseUtitiles.initiateCurrentDateFormat();
                            consumption_controller.Consum_preparedbyController
                                .text = loginController.UserName();
                            consumption_controller
                                    .autoYearWiseNoController.text =
                                autoYearWiseNoController
                                    .Conum_autoYrsWise.value;
                            siteController.selectedsiteId = 0.obs;
                            siteController.selectedsitedropdownName =
                                "--SELECT--".obs;
                            consumption_controller.expenseTypeController.text =
                                "Usage";
                            siteController.getSiteDropdownvalue.value.clear();
                            siteController.Sitename.text =
                                RequestConstant.SELECT;
                            siteController.siteDropdownName.clear();
                            consumption_controller.expenseType = "EXP";
                            consumption_controller
                                .Consum_RemarksController.text = "";
                            consumption_controller
                                .delete_Consum_itemlist_Table();
                            consumption_controller.Consum_itemview_GetDbList
                                .clear();
                            Navigator.pop(context);
                          });
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
    consumption_controller.buttonControl = 0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(consumption_controller.editCheck == 1
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
                          onPressed: () async {
                            if (projectController.selectedProjectId.value ==
                                    0 ||
                                siteController.selectedsiteId.value == 0) {
                              BaseUtitiles.showToast("Some field missing *");
                            } else {
                              consumption_controller.Consum_itemview_GetDbList
                                  .clear();
                              if (await BaseUtitiles.checkNetworkAndShowLoader(
                                  context)) {
                                await consumption_controller
                                    .SaveButton_ItemlistScreen(
                                  context,
                                  consumption_controller.UsageId != 0
                                      ? consumption_controller.UsageId
                                      : 0,
                                );
                              }
                            }
                          },
                          child: Text(
                            consumption_controller.editCheck == 1
                                ? RequestConstant.RESUBMIT
                                : RequestConstant.SUBMIT,
                            style: TextStyle(
                              color: consumption_controller.buttonControl == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors
                                      .grey, // Change color when button is disabled
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                            ),
                          ),
                        );
                      },
                    ),
                  )

                  ///-----old code-----
                  // Expanded(
                  //   child: TextButton(
                  //       onPressed: () async {
                  //         if(consumption_controller.buttonControl==0){
                  //           if(projectController.selectedProjectId.value==0 || siteController.selectedsiteId.value==0){
                  //             BaseUtitiles.showToast("Some field missing *");
                  //           }
                  //           else{
                  //             //consumption_controller.getConumTablesDatas();
                  //             // BaseUtitiles.showLoadingDialog(context, Theme.of(context).primaryColor);
                  //             consumption_controller.Consum_itemview_GetDbList.clear();
                  //             await consumption_controller.SaveButton_ItemlistScreen(context,consumption_controller.UsageId!=0?consumption_controller.UsageId:0);
                  //           }
                  //           consumption_controller.buttonControl = 0;
                  //         }
                  //         else if (consumption_controller.buttonControl == 1) {
                  //           consumption_controller.buttonControl = 0;
                  //           BaseUtitiles.showToast("Please wait... processing.");
                  //         }
                  //       },
                  //       child: Text(
                  //           consumption_controller.editCheck == 1 ? RequestConstant.RESUBMIT : RequestConstant.SUBMIT,
                  //           style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
