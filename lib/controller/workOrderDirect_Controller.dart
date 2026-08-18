import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcr/controller/pendinglistcontroller.dart';
import 'package:mcr/controller/projectcontroller.dart';
import 'package:mcr/controller/sitecontroller.dart';
import 'package:mcr/controller/subcontcontroller.dart';
import 'package:mcr/home/menu/main_menu/workOrder_Direct/workOrder_Direct_EntryScreen.dart';
import 'package:mcr/home/menu/main_menu/workOrder_Direct/workOrder_Direct_Entrylist.dart';
import 'package:mcr/provider/workOrderDirectProvider.dart';
import '../db_model/workOrderGST_calculation_model.dart';
import '../db_services/workOrdDirect_itemlist_service.dart';
import '../models/wordOrder_itemlist_model.dart';
import '../models/workOrderDirectEdit_model.dart';
import '../models/workOrderDirectSave_model.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class WorkOrderDirectController extends GetxController{
  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final workOrdentryDateController = TextEditingController();
  final WorkOrdActiveTypeText = TextEditingController();
  final WorkStatusTypeText = TextEditingController();
  final PreparedByController = TextEditingController();
  final RemarksController = TextEditingController();
  final termsConditionController = TextEditingController();

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  PendingListController pendingListController = Get.put(PendingListController());
  LoginController loginController = Get.put(LoginController());


  RxList ItemGetTableListdata = [].obs;
  var ItemListTableModel = WorkOrderItemListTableModel();
  var workOrder_ItemlistService = WorkOrder_ItemlistService();
  late List<WorkOrderItemListTableModel> ItemListTableModelList = <WorkOrderItemListTableModel>[];
  late List<WorkOrderItemListTableModel> itemListUpdateModelList = <WorkOrderItemListTableModel>[];
  late List<WorkOrderItemListTableModel> deleteitemListModelList = <WorkOrderItemListTableModel>[];
  List ItemListTableModelReadList = <WorkOrderItemListTableModel>[];
  RxList<Detail> getDetList = <Detail>[].obs;
  RxList<AddLess> getDetAddLessList = <AddLess>[].obs;
  RxList<Master> workOrderMasterList = <Master>[].obs;
  RxList<EditDetail> workOrderDetailList = <EditDetail>[].obs;
  RxList<EditAddLess> workOrderAddLessList = <EditAddLess>[].obs;

  var workOrderTable = WorkOrderGSTCalTable();
  RxList<WorkOrderGSTCalTable> workOrder_ItemReadList = <WorkOrderGSTCalTable>[].obs;
  late List<WorkOrderGSTCalTable> updateBillGen_ItemReadList = <WorkOrderGSTCalTable>[];
  late List<WorkOrderGSTCalTable> workOrderTableModelList = <WorkOrderGSTCalTable>[];

  List<TextEditingController> itemlist_ListDescController = [];
  List<TextEditingController> itemlist_ListUnitsController = [];
  List<TextEditingController> itemlist_ListQtyController = [];
  List<TextEditingController> itemlist_ListRateController = [];
  List<TextEditingController> itemlist_ListAmtController = [];

  final itemDescController = TextEditingController();
  final itemUnitController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemRateController = TextEditingController();
  final workOrdamount = TextEditingController();
  final rebateAmount = TextEditingController();
  final Roundoff = TextEditingController();
  final netpayamt = TextEditingController();


  RxList main_entryList = [].obs;
  RxList workOrderDir_entryList = [].obs;
  int workid = 0;
  RxString workOrdActTypeID = "".obs;
  RxString workOrdStsTypeId = "".obs;
  bool isRestoring = false;
  double baseNetPayAmt = 0.0;
  String oldRebateValue = "0.0";
  String oldRoundOffValue = "0.0";
  RxList workOrderDet_Calculation = [].obs;
  RxList workOrder_editListApiDatas = [].obs;


  List<TextEditingController> percentControllers = [];

  RxString saveButton = RequestConstant.SUBMIT.obs;

  Future WorkOrdDirect_EntryList() async {
    main_entryList.value.clear();
    workOrderDir_entryList.value.clear();
    await WorkOrderDirectProvider.getWorkOrdDirectEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        EntrylistFrDate.text,
        EntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        main_entryList.value = value;
        workOrderDir_entryList.value = main_entryList.value;
        return main_entryList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future WorkOrder_CalculationList() async {
    workOrderDet_Calculation.value.clear();
    await WorkOrderDirectProvider.getWorkOrderCalculation_List(
        subcontractorController.selectedSubcontId.value,0).then((value) async {
      if (value != null && value.length > 0) {
        workOrderDet_Calculation.value = value;
        await workOrderCal_itemlistTable_Delete();
        await workOrderCalculationSave();
        await getWorkorderCalDatas();
        if (saveButton.value == RequestConstant.RESUBMIT ||
            saveButton.value == RequestConstant.VERIFY ||
            saveButton.value == RequestConstant.APPROVAL) {
          setBaseNetPay();
          await preloadEditAddLessData(
              workOrderAddLessList);
          return workOrderDet_Calculation.value;
        }
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  workOrder_itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    ItemListTableModel = new WorkOrderItemListTableModel();
    ItemListTableModel.Name = itemDescController.text;
    ItemListTableModel.unit = itemUnitController.text;
    ItemListTableModel.qty = double.parse(itemQuantityController.text);
    ItemListTableModel.rate = double.parse(itemRateController.text);
    ItemListTableModel.amount =
        (ItemListTableModel.qty!) * (ItemListTableModel.rate!);
    ItemListTableModelList.add(ItemListTableModel);
    var savedatas =
    await workOrder_ItemlistService.workOrder_ItemlistTable_Save(
        ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {
    var datas = await workOrder_ItemlistService.workOrder_ItemlistTable_readAll();
    ItemListTableModelReadList = <WorkOrderItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    ItemGetTableListdata.refresh();
    datas.forEach((value) {
      ItemListTableModel = new WorkOrderItemListTableModel();
      ItemListTextInitiate();
      ItemListTableModel.Id = value['id'];
      ItemListTableModel.reqDetId = value['reqDetId'];
      ItemListTableModel.Name = value['Name'];
      ItemListTableModel.unit = value['unit'];
      ItemListTableModel.qty = value['qty'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  ItemListTextInitiate() {
    itemlist_ListDescController.add(new TextEditingController());
    itemlist_ListUnitsController.add(new TextEditingController());
    itemlist_ListQtyController.add(new TextEditingController());
    itemlist_ListRateController.add(new TextEditingController());
    itemlist_ListAmtController.add(new TextEditingController());
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      ItemListTextInitiate();
      itemlist_ListDescController[i].text = datas.Name.toString();
      itemlist_ListUnitsController[i].text = datas.unit.toString();
      itemlist_ListQtyController[i].text = datas.qty.toString();
      itemlist_ListRateController[i].text = datas.rate.toString();
      itemlist_ListAmtController[i].text = datas.amount.toString();
      i++;
    });
  }

  itemListclickChanged() {
    int i = 0;
    ItemGetTableListdata.value.forEach((element) {
      ItemListTextInitiate();
      itemlist_ListAmtController[i].text = (double.parse(
          itemlist_ListQtyController[i].text != ""
              ? itemlist_ListQtyController[i].text
              : "0") *
          double.parse(itemlist_ListRateController[i].text != ""
              ? itemlist_ListRateController[i].text
              : "0"))
          .toString();
      i++;
    });
    updateItemlistTable();
  }

  clearDatas(){
    saveButton.value=RequestConstant.SUBMIT;
    workid=0;
    projectController.projectname.text="--Select--";
    projectController.selectedProjectId.value=0;
    subcontractorController.Subcontractorname.text="--Select--";
    subcontractorController.selectedSubcontId.value=0;
    RemarksController.clear();
    // billentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    // FromdateController.text=BaseUtitiles.initiateCurrentDateFormat();
    // TodateController.text=BaseUtitiles.initiateCurrentDateFormat();
    siteController.selectedsiteId=0.obs;
    siteController.selectedsitedropdownName="--Select--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    workOrder_itemlistTable_Delete();
    ItemGetTableListdata.value.clear();
    workOrdamount.text="0.0";
    Roundoff.text="0";
    netpayamt.text="0.0";
  }

  Future SaveButton_DeductionScreen(BuildContext context, int id) async {
    getDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = workOrdDirectSaveModelToJson(WorkOrdDirectSaveModel(
      workorderId: id != 0 ? id : 0,
      workOrderNo: autoYearWiseNoController.text,
      eDate: workOrdentryDateController.text,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subContId: subcontractorController.selectedSubcontId.value,
      workStatus: workOrdStsTypeId.value,
      activeStatus: workOrdActTypeID.value,
      termsCondition: termsConditionController.text,
      remarks: RemarksController.text,
      roundOff: double.tryParse(Roundoff.text) ?? 0.0,
      workOrderAmt: double.tryParse(workOrdamount.text) ?? 0.0,
      billWhaAmt: double.tryParse(rebateAmount.text) ?? 0.0,
      netAmount: double.tryParse(netpayamt.text) ?? 0.0,
      preparedBy: int.tryParse(loginController.EmpId()) ?? 0,
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode: saveButton.value == "Submit" ? "ADD" : saveButton.value ==
          RequestConstant.RESUBMIT ? "UPDATE" : saveButton.value == RequestConstant.VERIFY
          ? "VERIFY"
          : saveButton.value == RequestConstant.APPROVAL ? "APPROVE" : "",
      appstatus: saveButton.value == RequestConstant.APPROVAL ? "Y" : "N",
      verifystatus: saveButton.value == RequestConstant.APPROVAL || saveButton.value == RequestConstant.VERIFY ? "Y" : "N",
        verifiedby: saveButton.value == RequestConstant.APPROVAL || saveButton.value == RequestConstant.VERIFY
            ? loginController.EmpId().toString()
            : "0",
        approvedby: saveButton.value == RequestConstant.APPROVAL
             ? loginController.EmpId().toString()
            : "0",
        details: getNmrBillDet(),
      addLess: getWorkOrderDetAddLess()
    ));
    final list = await WorkOrderDirectProvider.SaveSubContScreenEntryAPI(
        body, id, context);
    if (list != null) {
      if (id != 0) {
        workOrder_itemlistTable_Delete();
        ItemGetTableListdata.value.clear();
        if (id != 0) {
          if(saveButton.value==RequestConstant.RESUBMIT){
            await WorkOrdDirect_EntryList();
          }
          else{
            await pendingListController.getPendingList();
          }
          BaseUtitiles.showToast(list);
          clearDatas();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return;
        }
      } else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          Navigator.pop(context);
          Navigator.pop(context);
          return BaseUtitiles.showToast(list!);
        } else {
          workOrder_itemlistTable_Delete();
          ItemGetTableListdata.value.clear();
          BaseUtitiles.showToast(list!);
          clearDatas();
          await WorkOrdDirect_EntryList();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return;
        }
      }
    }

  }

  List<Detail>? getNmrBillDet() {
    getDetList.value.clear();
    ItemGetTableListdata.value.forEach((element) {
      if(element.qty > 0){
      var list = Detail(
        itemDesc:element.Name.toString(),
        unit:element.unit.toString(),
        qty:element.qty.toString(),
        rate:element.rate.toString(),
        amount:element.amount.abs().toString(),
      );
      getDetList.value.add(list);
      }
    });
    return getDetList.value;
  }

  List<AddLess>? getWorkOrderDetAddLess() {
    getDetAddLessList.value.clear();
    workOrder_ItemReadList.value.forEach((element) {
      if (element.percentValue! > 0) {
        var list = AddLess(
          // addLessId: element.reqDetId,
          addLessId: element.addLessId,
          percentage: element.percentValue.toString(),
          amount: element.amount.toString(),
        );
        getDetAddLessList.value.add(list);
      }
    });
    return getDetAddLessList.value;
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      ItemListTableModel = WorkOrderItemListTableModel();
      ItemListTableModel.Id = element.Id;
      ItemListTableModel.reqDetId = element.reqDetId;
      ItemListTableModel.Name = element.Name;
      ItemListTableModel.unit = itemlist_ListUnitsController[i].text;
      ItemListTableModel.qty = double.parse(
          itemlist_ListQtyController[i].text != ""
              ? itemlist_ListQtyController[i].text
              : "0");
      ItemListTableModel.rate = double.parse(
          itemlist_ListRateController[i].text != ""
              ? itemlist_ListRateController[i].text
              : "0");
      ItemListTableModel.amount =
          ItemListTableModel.qty! * ItemListTableModel.rate!;
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await workOrder_ItemlistService.workOrder_ItemlistTable_Update(
        itemListUpdateModelList);
  }

  double roundWhole(double value) {
    return value.roundToDouble();
  }

  Future<bool> deductionPaymentCalculation() async {
    await getItemlistTablesDatas();

    if (ItemGetTableListdata.value.isEmpty) return false;

    // ============================================================
    // BILL AMOUNT
    // ============================================================

    double totalNetAmount = 0.0;

    for (var item in ItemGetTableListdata.value) {
      totalNetAmount += item.amount ?? 0;
    }

    totalNetAmount = roundWhole(totalNetAmount);

    workOrdamount.text = totalNetAmount.toStringAsFixed(0);

    double bill = roundWhole(
      double.tryParse(workOrdamount.text) ?? 0,
    );

    // ============================================================
    // ROUND OFF
    // ============================================================

    String roundText = Roundoff.text.trim();

    double round = (roundText.isEmpty || roundText == "-")
        ? 0
        : roundWhole(double.tryParse(roundText) ?? 0);

    // ============================================================
    // RECALCULATE
    // ============================================================

    recalculateAddLessAmounts(
      bill: bill,
      round: round,
    );

    // ============================================================
    // VALIDATION
    // ============================================================

    if ((double.tryParse(netpayamt.text) ?? 0) < 0) {
      return false;
    }

    workOrder_ItemReadList.refresh();

    await saveUpdatedCalcData();

    return true;
  }

  void recalculateAddLessAmounts({
    required double bill,
    required double round,
  }) {

    final double baseAmount = roundWhole(bill);

    double retentionAmount = 0.0;

    for (var item in workOrder_ItemReadList) {
      final name = (item.addLessName ?? "")
          .trim()
          .toUpperCase();

      if (name == "RETENTION") {
        final double percent =
            double.tryParse(
              item.percentValue?.toString() ?? "0",
            ) ??
                0;

        // Round retention amount
        double amount = (baseAmount * percent / 100).floorToDouble();

        if (item.addLessType == "-") {
          item.amount = -amount;
        } else {
          item.amount = amount;
        }

        retentionAmount = amount;
      }
    }

    double rebate = baseAmount;

    if (retentionAmount > 0) {
      rebate = roundWhole(
        baseAmount - retentionAmount,
      );
    }

    rebateAmount.text = rebate.toStringAsFixed(0);

    for (var item in workOrder_ItemReadList) {
      final name = (item.addLessName ?? "")
          .trim()
          .toUpperCase();

      final double percent =
          double.tryParse(
            item.percentValue?.toString() ?? "0",
          ) ??
              0;

      if (name == "S-GST" ||
          name == "C-GST" ||
          name == "I-GST" ||
          name == "TDS" ||
          name == "HOLD") {

        // TDS uses REBATE amount
        final double calculationBase =
        name == "TDS"
            ? rebate
            : baseAmount;

        // Round every percentage amount
        double amount = (calculationBase * percent / 100).floorToDouble();
        // double amount = roundWhole(
        //   calculationBase * percent / 100,
        // );

        if (item.addLessType == "-") {
          item.amount = -amount;
        } else {
          item.amount = amount;
        }
      }
    }

    double finalAmount = baseAmount;

    for (var item in workOrder_ItemReadList) {
      final name = (item.addLessName ?? "")
          .trim()
          .toUpperCase();

      if (name == "S-GST" ||
          name == "C-GST" ||
          name == "I-GST" ||
          name == "RETENTION" ||
          name == "TDS" ||
          name == "HOLD") {

        finalAmount = roundWhole(
          finalAmount + (item.amount ?? 0),
        );
      }
    }

    finalAmount = roundWhole(
      finalAmount + round,
    );

    netpayamt.text = finalAmount.toStringAsFixed(0);

    workOrder_ItemReadList.refresh();
    update();
  }

  // void recalculateAddLessAmounts({
  //   required double bill,
  //   required double round,
  // }) {
  //
  //   final double baseAmount = bill;
  //
  //   double retentionAmount = 0.0;
  //
  //   for (var item in workOrder_ItemReadList) {
  //     final name = (item.addLessName ?? "").trim().toUpperCase();
  //
  //     final percent = item.percentValue ?? 0.0;
  //
  //     // Only percentage based rows
  //     if (name == "S-GST" ||
  //         name == "C-GST" ||
  //         name == "I-GST" ||
  //         name == "RETENTION" ||
  //         name == "TDS" ||
  //         name == "HOLD") {
  //       final double amount = baseAmount * percent / 100;
  //
  //       if (item.addLessType == "-") {
  //         item.amount = -amount;
  //       } else {
  //         item.amount = amount;
  //       }
  //       if (name == "RETENTION") {
  //         retentionAmount = amount;
  //       }
  //     }
  //   }
  //
  //   double rebate = baseAmount;
  //
  //   if (retentionAmount > 0) {
  //     rebate = baseAmount - retentionAmount;
  //   }
  //
  //   rebateAmount.text = rebate.toStringAsFixed(2);
  //
  //   double finalAmount = baseAmount;
  //
  //   for (var item in workOrder_ItemReadList) {
  //     final name = (item.addLessName ?? "").trim().toUpperCase();
  //
  //     if (name == "S-GST" ||
  //         name == "C-GST" ||
  //         name == "I-GST" ||
  //         name == "RETENTION" ||
  //         name == "TDS" ||
  //         name == "HOLD") {
  //       finalAmount += item.amount ?? 0.0;
  //     }
  //   }
  //
  //
  //   finalAmount += round;
  //
  //
  //   netpayamt.text = finalAmount.toStringAsFixed(2);
  //
  //
  //   workOrder_ItemReadList.refresh();
  //   update();
  // }

  void setBaseNetPay() {
    double bill = double.tryParse(workOrdamount.text) ?? 0;
    double netBill = bill;
    baseNetPayAmt = netBill;
    print("=== Base Net Bill : $baseNetPayAmt ===");
  }

  double getTotalAddLess() {
    double total = 0;

    for (final item in workOrder_ItemReadList) {
      total += item.amount ?? 0;
    }

    return total;
  }

  Future<void> saveUpdatedCalcData() async {
    await updateDirectBillCalDatas();
  }

  updateDirectBillCalDatas() async {
    int i = 0;
    updateBillGen_ItemReadList.clear();
    workOrder_ItemReadList.forEach((element) {
      workOrderTable = WorkOrderGSTCalTable();
      workOrderTable.reqDetId = element.reqDetId;
      workOrderTable.addLessId = element.addLessId;
      workOrderTable.percentValue = element.percentValue;
      workOrderTable.amount = element.amount;
      workOrderTable.addLessName = element.addLessName;
      workOrderTable.addLessType = element.addLessType;
      updateBillGen_ItemReadList.add(workOrderTable);
      i++;
    });
    await workOrder_ItemlistService.workOrderGST_ItemlistTable_Update(
        updateBillGen_ItemReadList);
  }

  bool calculateAndUpdate(int addLessId, double percent) {
    final item = workOrder_ItemReadList.firstWhereOrNull(
          (e) => e.addLessId == addLessId,
    );

    if (item == null) return false;

    // Save old percentage
    final oldPercent = item.percentValue ?? 0.0;

    // Update current percentage
    item.percentValue = percent;

    final roundText = Roundoff.text.trim();

    final double round = (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;


    final double bill = double.tryParse(workOrdamount.text) ?? 0;

    recalculateAddLessAmounts(
      bill: bill,
      round: round,
    );


    final double netPay = double.tryParse(netpayamt.text) ?? 0;

    if (netPay < 0) {
      BaseUtitiles.showToast(
        "Net Pay Amount cannot be negative.",
      );

      // Restore only current percentage
      item.percentValue = oldPercent;

      // Recalculate using restored value
      recalculateAddLessAmounts(
        bill: bill,
        round: round,
      );

      workOrder_ItemReadList.refresh();
      update();

      return false;
    }

    workOrder_ItemReadList.refresh();
    update();

    return true;
  }

  Future<void> workOrderCalculationSave() async {
    workOrderTableModelList = [];

    for (final element in workOrderDet_Calculation.value) {
      final directBillTable = WorkOrderGSTCalTable();

      directBillTable.reqDetId = 0;
      directBillTable.addLessId = element.id;
      directBillTable.percentValue = element.per;
      directBillTable.amount = 0.0;
      directBillTable.addLessName = element.addLessName;
      directBillTable.addLessType = element.addLessType;

      workOrderTableModelList.add(directBillTable);
    }

    await workOrder_ItemlistService.workOrderGST_ItemTable_Save(
        workOrderTableModelList);
  }



  Future getWorkorderCalDatas() async {
    var datas = await workOrder_ItemlistService
        .workOrderGST_ItemlistTable_readAll();
    workOrder_ItemReadList.value = <WorkOrderGSTCalTable>[];
    workOrder_ItemReadList.clear();
    datas.forEach((value) {
      workOrderTable = WorkOrderGSTCalTable();
      workOrderTable.reqDetId = value['reqDetId'];
      workOrderTable.addLessId = value['addLessId'];
      workOrderTable.percentValue = value['percentValue'];
      workOrderTable.amount = value['amount'];
      workOrderTable.addLessName = value['addLessName'];
      workOrderTable.addLessType = value['addLessType'];
      workOrder_ItemReadList.add(workOrderTable);
    });
    initPercentControllers();
  }


  void initPercentControllers() {
    percentControllers.clear();
    for (var item in workOrder_ItemReadList) {
      percentControllers.add(
        TextEditingController(
          text: (item.percentValue ?? 0.0) == 0.0
              ? ''
              : item.percentValue.toString(),
        ),
      );
    }
  }

  Future<void> workOrderEntryList_EditApi(
      int workId,
      BuildContext context, {
        String? type,
      }) async {
    final response =
    await WorkOrderDirectProvider.workOrder_entryList_editAPI(workId);

    if (response == null) {
      BaseUtitiles.showToast("Something Went Wrong...");
      return;
    }

    if (response.success != true) {
      BaseUtitiles.showToast(
        response.message ?? "Something went wrong.",
      );
      return;
    }

    final result = response.result;

    if (result == null) {
      BaseUtitiles.showToast("No Data Found");
      return;
    }

    // Save button type
    saveButton.value = type == "Approve"
        ? RequestConstant.APPROVAL
        : type == "Verify"
        ? RequestConstant.VERIFY
        : RequestConstant.RESUBMIT;

    // Store API data
    workOrderMasterList.assignAll(result.master ?? []);
    workOrderDetailList.assignAll(result.details ?? []);
    workOrderAddLessList.assignAll(result.addLess ?? []);

    // Save to local DB / Controllers
    await workOrder_EditTable_SaveTable("");

    // Reload local tables
    await getItemlistTablesDatas();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => WorkOrderDirectEntryScreen(),
      ),
    );
  }

  workOrder_EditTable_SaveTable(name) async {
    ItemListTableModelList.clear();
        for (var value in workOrderDetailList) {
          ItemListTableModel = new WorkOrderItemListTableModel();
          ItemListTableModel.Name = value.itemDesc == null ? "-" : value.itemDesc.toString();
          ItemListTableModel.unit = value.unit == null ? "-" : value.unit.toString();
          ItemListTableModel.qty = value.qty;
          ItemListTableModel.rate = value.rate;
          ItemListTableModel.amount = value.amount;
          ItemListTableModelList.add(ItemListTableModel);
      }
        var savedatas =
    await workOrder_ItemlistService.workOrder_ItemlistTable_Save(
        ItemListTableModelList);
    return savedatas;
  }


  Future<void> preloadEditAddLessData(List<dynamic> editAddLessList) async {
    // First load local DB rows
    await getWorkorderCalDatas();


    // Update local rows with edit API values
    for (var editItem in editAddLessList) {
      int index = workOrder_ItemReadList.indexWhere(
            (e) => e.addLessId == editItem.addLessId,
      );

      if (index != -1) {
        // workOrder_ItemReadList[index].reqDetId = editItem.id;

        workOrder_ItemReadList[index].percentValue =
            (editItem.percentValue ?? 0).toDouble();

        workOrder_ItemReadList[index].amount =
            (editItem.amount ?? 0).toDouble();

        // Update controller text also
        percentControllers[index].text = (editItem.percentValue ?? 0) == 0
            ? ''
            : editItem.percentValue.toString();
      }
    }

    // Refresh UI
    workOrder_ItemReadList.refresh();

    // Recalculate total/netpay
    updateNetPay();
  }

  void updateNetPay() {
    String roundText = Roundoff.text.trim();

    double round = (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    recalculateAddLessAmounts(
      bill: double.tryParse(workOrdamount.text) ?? 0,
      round: round,
    );
  }

  // void updateNetPay() {
  //   double bill = double.tryParse(workOrdamount.text) ?? 0;
  //   double round = double.tryParse(Roundoff.text) ?? 0;
  //
  //   double addLessTotal = totalAddLess;
  //
  //   double netAmount = bill + round + addLessTotal;
  //
  //   netpayamt.text = netAmount.toStringAsFixed(2);
  // }

  workOrderCal_itemlistTable_Delete() async {
    await workOrder_ItemlistService.workOrderGST_ItemlistTable_delete();
  }

  Future deleteByIditemlistTableable(
      WorkOrderItemListTableModel data) async {
    deleteitemListModelList.clear();
    ItemListTableModel = new WorkOrderItemListTableModel();
    ItemListTableModel.Id = data.Id;
    ItemListTableModel.Name = data.Name;
    deleteitemListModelList.add(ItemListTableModel);
    await workOrder_ItemlistService.workOrder_ItemlistTable_deleteById(
        deleteitemListModelList);
  }


  workOrder_itemlistTable_Delete() async {
    await workOrder_ItemlistService.workOrder_ItemlistTable_delete();
  }

  Future EntryList_DeleteApi(int WorkId,String WorkNo) async {
    await WorkOrderDirectProvider.entryList_deleteAPI(WorkId,WorkNo,loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
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
                        onPressed: () {
                          workOrder_itemlistTable_Delete();
                          ItemGetTableListdata.value.clear();
                          EntryList_DeleteApi(workOrderDir_entryList[index].workOrderId,workOrderDir_entryList[index].workOrderNo);
                          workOrderDir_entryList.removeAt(index);
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
          //    editCheck=0;
          //    entrycheck=0;
          //    billgen_itemlistTable_Delete();
          //    ItemGetTableListdata.value.clear();
          //    EntryList_DeleteApi(bill_entryList[index].workId,bill_entryList[index].subContId,bill_entryList[index].workNo);
          //    bill_entryList.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }

}