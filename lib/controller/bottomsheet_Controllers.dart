import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcr/controller/reports_controller.dart';
import '../controller/companycontroller.dart';
import '../controller/staffvoucher_controller.dart';
import '../controller/stocksite_controller.dart';
import '../controller/transferbw_project_controller.dart';
import '../home/menu/accounts/staff_voucher/staff_voucher_sitewise.dart';
import '../controller/dailywrk_done_dpr_controller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/staffcontroller.dart';
import '../controller/subcontcontroller.dart';
import '../controller/suppliercontroller.dart';
import '../controller/transferbw_site_controller.dart';
import '../app_theme/app_colors.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'billgenerationdirect_controller.dart';
import 'boqrevised_controller.dart';
import 'cashbookstaff_controller.dart';
import 'commonvoucher_controller.dart';
import 'consumption_controller.dart';
import 'dailyentries_controller.dart';
import 'dailywrk_done_dprnew_controller.dart';
import 'expensencecontroller.dart';
import 'fromproject_ccontroller.dart';
import 'fromsite_controller.dart';
import 'nmrweeklybill_controller.dart';

class BottomsheetControllers {
  ProjectController projectcontroller = Get.put(ProjectController());
  ReportsController reportsController = Get.put(ReportsController());
  SiteController siteController = Get.put(SiteController());
  FromProjectController fromProjectController =
      Get.put(FromProjectController());
  FromSiteController fromsiteController = Get.put(FromSiteController());
  TransferBt_Site_Controller transferBt_Site_Controller =
      Get.put(TransferBt_Site_Controller());
  SiteController sitecontroller = Get.put(SiteController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  SupplierController supplierController = Get.put(SupplierController());
  CommonVoucherController commonVoucherController =
      Get.put(CommonVoucherController());
  StaffController staffController = Get.put(StaffController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
      Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller =
      Get.put(DailyWrkDone_DPRNEW_Controller());
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  BillGenerationDirectController billGenerationDirectController =
      Get.put(BillGenerationDirectController());
  DailyEntriesController dailyEntriesController =
      Get.put(DailyEntriesController());

  Consumption_Controller consumption_controller =
      Get.put(Consumption_Controller());
  Boq_Revised_Controller boq_revised_controller =
      Get.put(Boq_Revised_Controller());
  StockSiteController stockSiteController = Get.put(StockSiteController());
  final CompanyController companyController = Get.put(CompanyController());

  CashBookStaffController cashBookStaffController =
      Get.put(CashBookStaffController());
  TransferBW_project_Controller transferBW_project_Controller =
      Get.put(TransferBW_project_Controller());
  StaffVoucher_Controller staffVoucher_Controller =
      Get.put(StaffVoucher_Controller());
  ExpensesController expensesController = Get.put(ExpensesController());
  CompanyController companycontroller = Get.put(CompanyController());

  // SubcontractorController subcontractorcontroller =Get.put(SubcontractorController());

  final searchcontroller = TextEditingController();
  var list;

  ProjectName(
    context,
    list,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.projectPopupAlert(
                          value, projectcontroller.getdropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Projects",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].project.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          projectcontroller.projectname.text =
                              list[index].project.toString();
                          projectcontroller.selectedProjectId.value =
                              list[index].projectId;
                          await siteController.subcontEntry_siteDropdowntList(
                              context, 0);
                          await fromsiteController.getsiteDropdowntList(
                              context, 0);
                          await transferBt_Site_Controller
                              .from_siteDropdowntList(context);
                          searchcontroller.text = "";
                          siteController.Sitename.text = "--SELECT--";
                          // siteController.selectedsiteId.value=0;
                          dailyWrkDone_DPR_Controller
                              .TypeSubcontractorname.text = "--SELECT--";
                          await subcontractorController.getSubcontList(context, projectcontroller.selectedProjectId.value, siteController.selectedsiteId.value, subcontractorController.checkScreen);
                          dailyWrkDone_DPRNEW_Controller
                              .dprNew_DetTable_Delete();
                          dailyWrkDone_DPRNEW_Controller
                              .dprNew_EntryDetReadList.value
                              .clear();
                          await dailyWrkDone_DPRNEW_Controller
                              .getDetTablesDatas();
                          transferBt_Site_Controller.from_selectedsiteId.value =
                              0;
                          transferBt_Site_Controller.FromSitename.text =
                              "--SELECT--";

                          //----------DRR Det list------------
                          dailyWrkDone_DPR_Controller
                              .delete_dpr_itemlist_Table();
                          dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value
                              .clear();
                          dailyWrkDone_DPR_Controller.getDprTablesDatas();
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  projectnameAll(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    controller: searchcontroller,
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
                      list = BaseUtitiles.projectPopupAlert(
                          value, projectcontroller.getdropDownvalueAll.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "To Projects",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].project.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          projectcontroller.projectnameAll.text =
                              list[index].project.toString();
                          projectcontroller.selectedProjectIdAll.value =
                              list[index].projectId;
                          await fromsiteController.getsiteDropdowntList(
                              context, 0);
                          await subcontractorController.getSubcontList(context, projectcontroller.selectedProjectId.value,siteController.selectedsiteId.value, subcontractorController.checkScreen);
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  WorkOrderName(context, list){
    showModalBottomSheet(context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),),
        builder: (BuildContext context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 50),
                    margin: EdgeInsets.only(top: 10, left: 15),
                    child: TextField(
                      controller: searchcontroller,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search,
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
                        list=BaseUtitiles.subcontPopupAlert(value, subcontractorController.getdpDnWrkOrderValue.value);
                      },

                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: BaseUtitiles.getWidthtofPercentage(context, 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Text("Work Order No", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        searchcontroller.text = "";
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(Icons.expand_circle_down, color: Theme.of(context).primaryColor))),
                ],
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.center,
                            child: Text(list[index].workOrderNo.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),),
                          ),
                          onTap: ()  async {
                            subcontractorController.WorkOrderNo.text = list[index].workOrderNo.toString();
                            subcontractorController.selectedWorkOrderId.value = list[index].workOrderId;
                            searchcontroller.text = "";
                            await billGenerationDirectController.getWorkOrderList();
                            await billGenerationDirectController.DirectBill_CalculationList(type: "WorkOrd");
                            Navigator.pop(context);
                          },
                        ),
                        Divider(),
                      ],
                    );
                  }, ),
              )
            ],
          );
        });
  }

  //------Project Name Company Wise list----------

  projectname_CompanyWise(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    controller: searchcontroller,
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
                      list = BaseUtitiles.projectPopupAlert(value,
                          companycontroller.getdropDownvalue_Companywise.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Projects",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].project.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          companycontroller.projectname_CompanyWise.text =
                              list[index].project.toString();
                          companycontroller.selectedProjectId_CompanyWise
                              .value = list[index].projectId;
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  SiteName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.sitePopupAlert(
                          value, siteController.getSiteDropdownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Sites",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].siteName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          siteController.Sitename.text =
                              list[index].siteName.toString();
                          siteController.selectedsiteId.value =
                              list[index].siteId;
                          await supplierController.getSupplierList(context);
                          dailyWrkDone_DPR_Controller
                              .TypeSubcontractorname.text = "--Select--";
                          dailyWrkDone_DPRNEW_Controller
                              .dprNew_DetTable_Delete();
                          dailyWrkDone_DPRNEW_Controller
                              .dprNew_EntryDetReadList.value
                              .clear();
                          dailyWrkDone_DPRNEW_Controller.getDetTablesDatas();
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  // var id;

  FromProjectName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.projectPopupAlert(
                          value, fromProjectController.getdropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "From Projects",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].project.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          // if(fromProjectController.selectedProjectId!=0){
                          //   await showDialog(
                          //     context: context,
                          //     builder: (BuildContext context)  {
                          //       return AlertDialog(
                          //         title: Text('Alert'),
                          //         content: Text('Do you want change the Project?'),
                          //         actions: [
                          //           FlatButton(
                          //             textColor: Colors.black,
                          //             onPressed: () {
                          //               Navigator.pop(context);
                          //             },
                          //             child: Text('No'),
                          //           ),
                          //           FlatButton(
                          //             textColor: Colors.black,
                          //             onPressed: () {
                          //               id=1;
                          //               if(transferBW_project_Controller.type.value=="Direct"){
                          //                 transferBW_project_Controller.ItemGetTableListdata.value.clear();
                          //               }
                          //               fromsiteController.setSelectedMRNListName(0);
                          //               fromProjectController.setSelectedProjectID(fromProjectController.mainlist.value[index].project!);
                          //               Navigator.pop(context);
                          //             },
                          //             child: Text('Yes'),
                          //           ),
                          //         ],
                          //       );
                          //     },
                          //   );
                          //
                          //   if(id==1){
                          //     // fromsiteController.setSelectedMRNListName(0);
                          //     // fromprojectController.setSelectedProjectID(widget.list[index].project!);
                          //     Navigator.pop(context);
                          //   }
                          //   else{
                          //     Navigator.pop(context);
                          //   }
                          //
                          // }
                          // else{
                          //   fromsiteController.setSelectedMRNListName(0);
                          //   fromProjectController.setSelectedProjectID(fromProjectController.mainlist.value[index].project!);
                          //   Navigator.pop(context);
                          // }

                          fromProjectController.fromprojectname.text =
                              list[index].project.toString();
                          fromProjectController.selectedProjectId.value =
                              list[index].projectId;
                          await fromsiteController.getsiteDropdowntList(
                              context, 0);
                          Navigator.pop(context);
                          searchcontroller.text = "";
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  FromSiteName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.sitePopupAlert(
                          value, fromsiteController.getSiteDropdownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "From Sites",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].siteName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          if (transferBW_project_Controller.type.value ==
                              "Direct") {
                            transferBW_project_Controller
                                .ItemGetTableListdata.value
                                .clear();
                            fromsiteController.FromSitename.text =
                                list[index].siteName.toString();
                            fromsiteController.selectedsiteId.value =
                                list[index].siteId;
                          } else {
                            fromsiteController.setSelectedMRNListName(0);
                            // fromsiteController.setSelectedSiteID(fromsiteController.mainlist.value[index].siteName!);
                            fromsiteController.FromSitename.text =
                                list[index].siteName.toString();
                            fromsiteController.selectedsiteId.value =
                                list[index].siteId;
                            await siteController.subcontEntry_siteDropdowntList(
                                context, 0);
                            await transferBW_project_Controller
                                .itemlistTable_Delete();
                            transferBW_project_Controller
                                .ItemGetTableListdata.value = [];
                            await transferBW_project_Controller
                                .getTransproject_ItemList(
                                    fromProjectController
                                        .selectedProjectId.value,
                                    fromsiteController.selectedsiteId.value,
                                    transferBW_project_Controller
                                        .transferAllDatasList[0].reqMasId,
                                    transferBW_project_Controller.type.value ==
                                            "Direct"
                                        ? "D"
                                        : "A",
                                    context);
                            await transferBW_project_Controller
                                .itemlist_SaveTable();
                            await transferBW_project_Controller
                                .getItemlistTablesDatas();
                          }
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  ToSiteName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      siteController.mainlist.value =
                          BaseUtitiles.sitePopupAlert(
                              value, siteController.getSiteDropdownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "To Sites",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].siteName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          sitecontroller.Sitename.text =
                              list[index].siteName.toString();
                          sitecontroller.selectedsiteId.value =
                              list[index].siteId;

                          if (transferBt_Site_Controller
                                  .from_selectedsiteId.value ==
                              sitecontroller.selectedsiteId.value) {
                            BaseUtitiles.showToast("Same site can't allowed");
                            sitecontroller.Sitename.text = "";
                          } else {
                            sitecontroller.Sitename.text =
                                list[index].siteName.toString();
                            sitecontroller.selectedsiteId.value =
                                list[index].siteId;
                          }
                          searchcontroller.text = "";
                          Navigator.pop(context);

                          //
                          // if(siteController.selectedsiteId!=0){
                          //   id=1;
                          //   boq_revised_controller.Boqitem_itemview_GetDbList.value.clear();
                          //   boq_revised_controller.delete_BoqRevised_itemlist_Table();
                          //   stockSiteController.projectShowList.clear();
                          //   consumption_controller.Consum_itemview_GetDbList.value.clear();
                          //   consumption_controller.delete_Consum_itemlist_Table();
                          //   siteController.setSelectedSiteID(siteController.mainlist.value[index].siteName!);
                          //   sitecontroller.Sitename.text = list[index].siteName.toString();
                          //   sitecontroller.selectedsiteId.value = list[index].siteId;
                          //   searchcontroller.text = "";
                          //   Navigator.of(context).pop();
                          //
                          //   if(id==1){
                          //     dailyEntriesController.deleteSubcontDetTableDatas();
                          //     dailyEntriesController.readListdata.clear();
                          //     Navigator.pop(context);
                          //   }
                          //   else{
                          //     Navigator.pop(context);
                          //   }
                          // }
                          // else{
                          //   // siteController.setSelectedSiteID(siteController.mainlist.value[index].siteName!);
                          //   sitecontroller.Sitename.text = list[index].siteName.toString();
                          //   sitecontroller.selectedsiteId.value = list[index].siteId;
                          //   searchcontroller.text = "";
                          //   Navigator.pop(context);
                          // }
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  SubcontractorName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.subcontPopupAlert(value,
                          subcontractorController.getdropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Subcontractors",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].subContName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          subcontractorController.Subcontractorname.text =
                              list[index].subContName.toString();
                          subcontractorController.selectedSubcontId.value =
                              list[index].subContId;
                          searchcontroller.text = "";
                          await nmrWklyController.getNmrAdvance();
                          await billGenerationDirectController.getNmrAdvance();

                          await dailyEntriesController.deleteSubcontDetTableDatas();
                          dailyEntriesController.readListdata.clear();
                          await nmrWklyController.DirectBill_CalculationList(type: "Subcont");

                          // await subcontractorController.getSubcontList(context, projectcontroller.selectedProjectId.value);

                          //--Subcontractor attendence-----------
                          // await dailyEntriesController.deleteSubcontDetTableDatas();
                          // dailyEntriesController.readListdata.value.clear();
                          // await dailyEntriesController.getDetTablesDatas();
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  SupplierName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.supplierNamePopupAlert(
                          value, supplierController.supplierListDropdown.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Supplier",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].supplierName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          supplierController.Suppliername.text =
                              list[index].supplierName.toString();
                          supplierController.selectedsuppliertId.value =
                              list[index].supplierId;
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  LabourName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.sitePopupAlert(
                          value, supplierController.supplierListDropdown.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Labour",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].siteName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          subcontractorController.labourId.value =
                              list[index].labourId;
                          subcontractorController.LabournameText.text =
                              list[index].labourName.toString();
                          // supplierController.Suppliername.text = list[index].supplierName.toString();
                          // supplierController.selectedsuppliertId.value = list[index].supplierId;
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  // -------AccountType---------

  AccountType(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.accTypePopupAlert(value,
                          commonVoucherController.getdropDownvalue.value);
                      // list = BaseUtitiles.sitePopupAlert(value, supplierController.supplierListDropdown.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Account Type",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].accType.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          commonVoucherController.selectedAccId.value =
                              list[index].accTypeid;
                          commonVoucherController.AccountTypename.text =
                              list[index].accType.toString();
                          await commonVoucherController.getAccountName(context);
                          searchcontroller.text = "";
                          commonVoucherController.selectedAccnameId.value = 0;
                          commonVoucherController.Accountname.text =
                              "--Select--";
                          commonVoucherController.namethrough.text =
                              "--Select--";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  AccountName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.accNamePopupAlert(value,
                          commonVoucherController.getaccdropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 28),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Account Name",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].accName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          commonVoucherController.selectedAccnameId.value =
                              list[index].accNameid;
                          commonVoucherController.Accountname.text =
                              list[index].accName.toString();
                          commonVoucherController.namethrough.text =
                              list[index].accName.toString();
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  Payfor(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      // commonVoucherController.payforNamelist.value=BaseUtitiles.acPayForNamePopupAlert(value,widget.list);
                      list = BaseUtitiles.acPayForNamePopupAlert(value,
                          commonVoucherController.getPayfordropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Payfor",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].acPayForName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          commonVoucherController.selectedAccPayId.value =
                              list[index].acPayForId;
                          commonVoucherController.AccPayforname.text =
                              list[index].acPayForName.toString();
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  ModeofPay(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.paymodePopupAlert(
                          value,
                          commonVoucherController
                              .getpaymodedropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Mode Of Pay",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].paymode.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          commonVoucherController.selectedPaymodeId.value =
                              list[index].paymodeid;
                          commonVoucherController.Paymodename.text =
                              list[index].paymode.toString();
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  //-------voucher------------

  StaffName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.empNameamePopupAlert(
                          value, staffController.getStaffDropdownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Staff Name",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].empName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          staffController.selectedstaffId.value =
                              list[index].empid;
                          staffController.Staffname.text =
                              list[index].empName.toString();
                          searchcontroller.text = "";
                          // cashBookStaffController.calculations();
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  BankName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.bankNamePopupAlert(
                          value, staffVoucher_Controller.getbankNameList.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Bank Name",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].bank.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          staffVoucher_Controller.selectedbankId.value =
                              list[index].bankId;
                          staffVoucher_Controller.BankName.text =
                              list[index].bank.toString();
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  //-------DPR-------------

  MaterialName(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      dailyWrkDone_DPRNEW_Controller.mainlist.value =
                          BaseUtitiles.materialName_DPRNew(
                              value,
                              dailyWrkDone_DPRNEW_Controller
                                  .MaterialApiLIst.value);

                      // dailyWrkDone_DPRNEW_Controller.MaterialApiLIst.value = BaseUtitiles.materialNamePopupAlert(value,dailyWrkDone_DPRNEW_Controller.mainlist.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Material Name",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),

            Container(
              margin: const EdgeInsets.only(top: 5),
              width: BaseUtitiles.getWidthtofPercentage(context, 100),
              height: BaseUtitiles.getheightofPercentage(context, 45),
              child: Obx(
                () => ListView.builder(
                    itemCount:
                        dailyWrkDone_DPRNEW_Controller.mainlist.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          dailyWrkDone_DPRNEW_Controller.setSelectedMaterialID(
                              dailyWrkDone_DPRNEW_Controller
                                  .mainlist.value[index].materialName!);
                          dailyWrkDone_DPRNEW_Controller
                                  .dpr_new_Mat_ScaleController.text =
                              dailyWrkDone_DPRNEW_Controller.selectedMatUnit
                                  .toString();
                          dailyWrkDone_DPRNEW_Controller
                              .getMaterialName(context);
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: BaseUtitiles.getWidthtofPercentage(
                                        context, 60),
                                    child: Text(
                                      dailyWrkDone_DPRNEW_Controller
                                          .mainlist.value[index].materialName
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                              RequestConstant.ALERT_Font_SIZE,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Divider(
                                    color: Theme.of(context).primaryColorLight)
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )

            // Expanded(
            //   child: ListView.builder(
            //     padding: EdgeInsets.zero,
            //     physics: BouncingScrollPhysics(),
            //     itemCount: list.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Column(
            //         children: [
            //           InkWell(
            //             child: Container(
            //               margin: EdgeInsets.only(left: 10),
            //               alignment: Alignment.center,
            //               child: Text(list[index].empName.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.Lable_Font_SIZE,fontWeight: FontWeight.bold),),
            //             ),
            //             onTap: (){
            //               staffController.selectedstaffId.value = list[index].empid;
            //               staffController. Staffname.text = list[index].empName.toString();
            //               searchcontroller.text = "";
            //               Navigator.pop(context);
            //             },
            //           ),
            //           Divider(),
            //         ],
            //       );
            //
            //     }, ),
            // )
          ],
        );
      },
    );
  }

  //---------Stack at Site--------------

  MaterialSubItem(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.materialSubItemPopupAlert(
                          value,
                          stockSiteController
                              .getmaterialSubdropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Materials",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].materialSubname.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          stockSiteController.Materialsubname.text =
                              list[index].materialSubname.toString();
                          stockSiteController.matDropdowntId.value =
                              list[index].materialSubId;
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  MaterialName_stockatSite(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.materialName_StockAtSitePopupAlert(
                          value,
                          stockSiteController.getMaterialdropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Material Name",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: BaseUtitiles.getWidthtofPercentage(context, 100),
              height: BaseUtitiles.getheightofPercentage(context, 45),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        stockSiteController.Subheadername.text =
                            list[index].materialName.toString();
                        stockSiteController.materialDropdowntId.value =
                            list[index].materialId;
                        stockSiteController.getmaterialDropdowntList(context);
                        searchcontroller.text = "";
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: BaseUtitiles.getWidthtofPercentage(
                                      context, 60),
                                  child: Text(
                                    list[index].materialName.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize:
                                            RequestConstant.ALERT_Font_SIZE,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Divider(
                                  color: Theme.of(context).primaryColorLight)
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        );
      },
    );
  }

  //-----Company Name ---------------

  CompanyName(context, list, {type}) {
    searchcontroller.text = "";

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      if(type=="mrnReqTracker") {
                        list = BaseUtitiles.companyPopupAlert(value,
                            companyController.getdropDownvalue.value);
                      }else{
                        list = BaseUtitiles.companyPopupAlert(value,
                            companycontroller.getdropDownvalue_Companywise.value);
                      }

                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Company",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].company.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          if (type == "mrnReqTracker") {
                            reportsController.companyName.text =
                                list[index].company.toString();
                            reportsController.selectedCompanyId.value =
                                list[index].companyid;
                            reportsController.projectname.text = "--ALL--";
                            reportsController.selectedProjectId.value = 0;
                            reportsController.sitename.text = "--ALL--";
                            reportsController.selectedsiteId.value = 0;
                            reportsController.Subheadername.text = "--ALL--";
                            reportsController.materialDropdowntId.value = 0;
                            siteController.mrnReqTrackerListValue.value = [];
                          } else {
                            companycontroller.CompanyName.text =
                                list[index].company.toString();
                            companycontroller.selectedCompanyId.value =
                                list[index].companyid;
                            await companycontroller.getProjectList_CompanyWise(
                                context, 0);
                            expensesController.update();
                          }
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  //----------------REPORTS DROPDOWNS---------------------

  projectNameReport(
    context,
    list,{type}
  ) {
    searchcontroller.text = "";
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: const EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      hintStyle: const TextStyle(color: Colors.black),
                      isDense: true,
                      fillColor: Setmybackground,
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      // if (onSearch != null) onSearch!(searchcontroller.text);
                    },
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      if(type=="mrnReqTracker") {
                        list = BaseUtitiles.projectPopupAlert(value,
                            companyController.getdropDownvalue_Companywise.value);
                      }else{
                        list = BaseUtitiles.projectPopupAlert(value,
                            reportsController.getProjectdropDownvalue.value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Projects",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].project.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          reportsController.projectname.text =
                              list[index].project.toString();
                          reportsController.selectedProjectId.value =
                              list[index].projectId;
                          reportsController.getSiteReportList(context,
                              reportsController.selectedProjectId.value);
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  siteNameReport(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.sitePopupAlert(
                          value, reportsController.getSiteDropdownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Sites",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].siteName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          reportsController.sitename.text =
                              list[index].siteName.toString();
                          reportsController.selectedsiteId.value =
                              list[index].siteId;
                          // await supplierController.getSupplierList(context);
                          // dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--Select--";
                          // dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
                          // dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value.clear();
                          // dailyWrkDone_DPRNEW_Controller.getDetTablesDatas();
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  MRNMaterialName(context, list) {
    searchcontroller.text = "";
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: const EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      hintStyle: const TextStyle(color: Colors.black),
                      isDense: true,
                      fillColor: Setmybackground,
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      list = BaseUtitiles.materialName_StockAtSitePopupAlert(
                          value,
                          reportsController.getMaterialdropDownvalue.value);
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      "Materials",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: BaseUtitiles.getWidthtofPercentage(context, 100),
              height: BaseUtitiles.getheightofPercentage(context, 45),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        //MRN Material Name
                        reportsController.Subheadername.text =
                            list[index]["MaterialName"].toString();
                        reportsController.materialDropdowntId.value =
                            list[index]["MaterialId"];
                        searchcontroller.text = "";
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: BaseUtitiles.getWidthtofPercentage(
                                      context, 60),
                                  child: Text(
                                    list[index]["MaterialName"].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize:
                                        RequestConstant.ALERT_Font_SIZE,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Divider()
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        );
      },
    );
  }

  supplierNameReport(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.supplierNamePopupAlert(
                          value, reportsController.supplierListDropdown.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Supplier",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].supplierName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          reportsController.suppliername.text =
                              list[index].supplierName.toString();
                          reportsController.selectedsuppliertId.value =
                              list[index].supplierId;
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  subcontractorNameReport(context, list) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
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
                      list = BaseUtitiles.subcontPopupAlert(
                          value, reportsController.getdropDownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "Subcontractors",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down,
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            list[index].subContName.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          reportsController.subcontractorname.text =
                              list[index].subContName.toString();
                          reportsController.selectedSubcontId.value =
                              list[index].subContId;
                          searchcontroller.text = "";
                          // await nmrWklyController.getNmrAdvance();
                          // await billGenerationDirectController.getNmrAdvance();
                          //
                          // await dailyEntriesController.deleteSubcontDetTableDatas();
                          // dailyEntriesController.readListdata.clear();

                          // await subcontractorController.getSubcontList(context, projectcontroller.selectedProjectId.value);

                          //--Subcontractor attendence-----------
                          // await dailyEntriesController.deleteSubcontDetTableDatas();
                          // dailyEntriesController.readListdata.value.clear();
                          // await dailyEntriesController.getDetTablesDatas();
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
