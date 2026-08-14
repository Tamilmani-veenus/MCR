import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:mcr/controller/pendinglistcontroller.dart';
import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/direct_bill_gst_calculation_model.dart';
import '../db_model/directbill_gen_itemlist_model.dart';
import '../db_services/direct_bill_itemlist_service.dart';
import '../home/menu/daily_entries/bill_generation_direct/bill_generationdirect_entry.dart';
import '../models/directbill_gener_saveapireq_model.dart';
import '../provider/directbill_generat_provider.dart';
import '../provider/workOrderDirectProvider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dailywrk_done_dpr_controller.dart';

class BillGenerationDirectController extends GetxController {
  final billentryDateController = TextEditingController();
  final billInvoiceDateController = TextEditingController();
  final billPaymentWkDateController = TextEditingController();

  final autoYearWiseNoController = TextEditingController();
  final DirectBillTypeText = TextEditingController();
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final RemarksController = TextEditingController();
  final itemDescController = TextEditingController();
  final itemUnitController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemRateController = TextEditingController();
  List<TextEditingController> itemlist_ListDescController = [];
  List<TextEditingController> itemlist_ListUnitsController = [];
  List<TextEditingController> itemlist_ListQtyController = [];
  List<TextEditingController> itemlist_ListRateController = [];
  List<TextEditingController> itemlist_ListAmtController = [];

  final billamount = TextEditingController();
  final Creditamt = TextEditingController();
  final CreditRemarksController = TextEditingController();
  final materialDebitamt = TextEditingController();
  final materialDebitRemarks = TextEditingController();

  final Debitamt = TextEditingController();
  final DebitRemarksController = TextEditingController();
  final tobededadv = TextEditingController();
  final Advded = TextEditingController();
  final Roundoff = TextEditingController();
  final balAmt = TextEditingController();
  final netBillAmt = TextEditingController();
  final finalBillAmt = TextEditingController();
  final netpayamt = TextEditingController();
  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  RxList main_entryList = [].obs;
  RxList bill_entryList = [].obs;
  RxList billDet_Calculation = [].obs;
  RxList bill_itemList = [].obs;
  RxList bill_editListApiDatas = [].obs;
  RxString directBillTypeID = "".obs;
  RxList reqDetIdNmrDet = [].obs;
  double baseNetPayAmt = 0.0;
  double totalNetBillamount = 0.0;
  double totalNetPayAmt = 0.0;
  String oldCreditValue = "0.0";
  String oldDebitValue = "0.0";
  bool isRestoring = false;
  String oldRoundOffValue = "0.0";
  String oldmatDebitValue = "0.0";
  RxBool isAdvanceReadOnly = true.obs;
  RxInt createdById = 0.obs;

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  PendingListController pendingListController =
      Get.put(PendingListController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
      Get.put(DailyWrkDone_DPR_Controller());

  String to_be_dection_advance = "0";

  int workid = 0;

  RxString saveButton = RequestConstant.SUBMIT.obs;

  var directBillGen_ItemlistService = DirectBillGen_ItemlistService();

  var ItemListTableModel = DirectBillGenItemListTableModel();
  late List<DirectBillGenItemListTableModel> ItemListTableModelList =
      <DirectBillGenItemListTableModel>[];
  List ItemListTableModelReadList = <DirectBillGenItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  late List<DirectBillGenItemListTableModel> itemListUpdateModelList =
      <DirectBillGenItemListTableModel>[];
  late List<DirectBillGenItemListTableModel> deleteitemListModelList =
      <DirectBillGenItemListTableModel>[];

  var directBillTable = DirectBillGSTCalTable();
  late List<DirectBillGSTCalTable> directBillTableModelList =
      <DirectBillGSTCalTable>[];
  RxList<DirectBillGSTCalTable> directBillGen_ItemReadList =
      <DirectBillGSTCalTable>[].obs;
  late List<DirectBillGSTCalTable> updateBillGen_ItemReadList =
      <DirectBillGSTCalTable>[];
  List<TextEditingController> percentControllers = [];

  RxList<BillDet> getDetList = <BillDet>[].obs;
  RxList<BillAddless> getDetAddLessList = <BillAddless>[].obs;

  Future DirectBill_EntryList() async {
    main_entryList.value.clear();
    bill_entryList.value.clear();
    await DirectBillGenerateProvider.getBillDirectEntry_List(
            loginController.user.value.userId,
            loginController.UserType(),
            EntrylistFrDate.text,
            EntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        main_entryList.value = value;
        bill_entryList.value = main_entryList.value;
        return main_entryList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future DirectBill_CalculationList({type}) async {
    billDet_Calculation.value = [];
    final value = await WorkOrderDirectProvider.getWorkOrderCalculation_List(
        type == "WorkOrd" ? subcontractorController.selectedSubcontId.value : 0,
        type == "WorkOrd"
            ? subcontractorController.selectedWorkOrderId.value
            : 0);
    if (value != null && value.length > 0) {
      billDet_Calculation.value = value;
      await DirectBillCal_itemlistTable_Delete();
      await directBillCalculationSave();
      await getDirectBillCalDatas();
      if (saveButton.value == RequestConstant.RESUBMIT ||
          saveButton.value == RequestConstant.VERIFY ||
          saveButton.value == RequestConstant.APPROVAL) {
        setBaseNetPay();
        await preloadEditAddLessData(
            bill_editListApiDatas[0].billEditAddless);
      }
    } else {
      BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
    }
  }

  void setBaseNetPay() {
    double bill = double.tryParse(billamount.text) ?? 0;

    double credit = double.tryParse(Creditamt.text) ?? 0;

    double debit = double.tryParse(Debitamt.text) ?? 0;

    double matDebit = double.tryParse(materialDebitamt.text) ?? 0;

    double netBill = bill + credit - debit - matDebit;

    baseNetPayAmt = netBill;

    netBillAmt.text = netBill.toStringAsFixed(2);
    balAmt.text = netBill.toStringAsFixed(2);

    print("=== Base Net Bill : $baseNetPayAmt ===");
  }

  Future getNmrAdvance() async {
    to_be_dection_advance = "0";
    await DirectBillGenerateProvider.billadv_balance(
            projectController.selectedProjectId.value,
            siteController.selectedsiteId.value,
            subcontractorController.selectedSubcontId.value)
        .then((value) async {
      if (value != null) {
        to_be_dection_advance = value;
        return to_be_dection_advance;
      }
    });
  }

  Future getWorkOrderList(type) async {
    ItemGetTableListdata.value = [];
    bill_editListApiDatas.value = [];
    await DirectBillGenerateProvider.getWorkOrderList(
            projectController.selectedProjectId.value,
            siteController.selectedsiteId.value,
            subcontractorController.selectedSubcontId.value,
            subcontractorController.selectedWorkOrderId.value,
            FromdateController.text,
            TodateController.text,type)
        .then((value) async {
      if (value != null && value.length > 0) {
        await billgen_DeleteApiRows();
        bill_editListApiDatas.value = value;
        await billgen_EditTable_SaveTable("ItemListDet");
        await getItemlistTablesDatas();
      }
    });
  }

  billgen_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_delete();
  }

  billgen_DeleteApiRows() async {
    await directBillGen_ItemlistService.billgen_DeleteApiRows();
  }

  Future deleteByIditemlistTableable(
      DirectBillGenItemListTableModel data) async {
    print("Deleting ID = ${data.Id}");

    deleteitemListModelList.clear();
    ItemListTableModel = new DirectBillGenItemListTableModel();
    ItemListTableModel.Id = data.Id;
    ItemListTableModel.Name = data.Name;
    deleteitemListModelList.add(ItemListTableModel);
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_deleteById(
        deleteitemListModelList);
  }

  billgen_itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    ItemListTableModel = new DirectBillGenItemListTableModel();
    ItemListTableModel.workDetId = 0;
    ItemListTableModel.Name = itemDescController.text;
    ItemListTableModel.unit = itemUnitController.text;
    ItemListTableModel.qty = double.parse(itemQuantityController.text);
    ItemListTableModel.rate = double.parse(itemRateController.text);
    ItemListTableModel.isApi = 0;
    ItemListTableModel.amount =
        (ItemListTableModel.qty!) * (ItemListTableModel.rate!);
    ItemListTableModelList.add(ItemListTableModel);
    var savedatas =
        await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Save(
            ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {
    var datas = await directBillGen_ItemlistService
        .DirectBillGen_ItemlistTable_readAll();
    ItemListTableModelReadList = <DirectBillGenItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new DirectBillGenItemListTableModel();
      ItemListTextInitiate();
      ItemListTableModel.Id = value['id'];
      ItemListTableModel.workDetId = value['workDetId'];
      ItemListTableModel.Name = value['Name'];
      ItemListTableModel.unit = value['unit'];
      ItemListTableModel.qty = value['qty'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModel.isApi = value['isApi'];
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

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      ItemListTableModel = DirectBillGenItemListTableModel();
      ItemListTableModel.Id = element.Id;
      ItemListTableModel.workDetId = element.workDetId;
      ItemListTableModel.Name = element.Name;
      ItemListTableModel.unit = itemlist_ListUnitsController[i].text;
      ItemListTableModel.isApi = element.isApi;
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
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Update(
        itemListUpdateModelList);
  }

  clearDatas() {
    to_be_dection_advance = "0";
    saveButton.value = RequestConstant.SUBMIT;
    workid = 0;
    projectController.projectname.text = "--Select--";
    projectController.selectedProjectId.value = 0;
    subcontractorController.Subcontractorname.text = "--Select--";
    subcontractorController.selectedSubcontId.value = 0;
    RemarksController.clear();
    billentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    billPaymentWkDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    billInvoiceDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    FromdateController.text = BaseUtitiles.initiateCurrentDateFormat();
    TodateController.text = BaseUtitiles.initiateCurrentDateFormat();
    siteController.selectedsiteId = 0.obs;
    siteController.selectedsitedropdownName = "--Select--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    DirectBillTypeText.text = "";
    directBillTypeID.value = "";
    billgen_itemlistTable_Delete();
    ItemGetTableListdata.value.clear();
    billamount.text = "0.0";
    Creditamt.text = "0.0";
    Debitamt.text = "0.0";
    CreditRemarksController.text = "-";
    DebitRemarksController.text = "-";
    Advded.text = "0.0";
    Roundoff.text = "0";
    netpayamt.text = "0.0";
    materialDebitamt.text = "0.0";
    tobededadv.text = to_be_dection_advance;
  }

  Future SaveButton_DeductionScreen(BuildContext context, int id) async {
    await Future.delayed(const Duration(seconds: 0));
    String body = billDirectGenSaveApiReqToJson(BillDirectGenSaveApiReq(
        workId: saveButton.value == "Submit" ? 0 : id,
        workNo: autoYearWiseNoController.text,
        workDate: billentryDateController.text,
        projectId: projectController.selectedProjectId.value,
        siteId: siteController.selectedsiteId.value,
        subContId: subcontractorController.selectedSubcontId.value,
        balAmt: double.tryParse(balAmt.text) ?? 0.0,
        remarks: RemarksController.text,
        preparedby: int.parse(loginController.EmpId()),
        fromDate: FromdateController.text,
        toDate: TodateController.text,
        entryType: "D",
        workOrderid: subcontractorController.selectedWorkOrderId.value,
        billAmt: double.tryParse(billamount.text) ?? 0.0,
        actAdvAmt: double.tryParse(tobededadv.text) ?? 0.0,
        advAmt: double.tryParse(Advded.text) ?? 0.0,
        netPayAmt: double.tryParse(netpayamt.text) ?? 0.0,
        debitAmt: double.tryParse(Debitamt.text) ?? 0.0,
        creditAmt: double.tryParse(Creditamt.text) ?? 0.0,
        billWhaAmount: double.tryParse(netBillAmt.text) ?? 0.0,
        rndOff: double.tryParse(Roundoff.text) ?? 0.0,
        debitRemarks: DebitRemarksController.text,
        creditRemarks: CreditRemarksController.text,
        billNo: subcontractorController.InvoiceNo.text,
        entryMode:saveButton.value=="Submit"?"ADD":saveButton.value=="Re-Submit"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
        verifyby: (saveButton.value==RequestConstant.SUBMIT || saveButton.value==RequestConstant.RESUBMIT)?0:int.tryParse(loginController.EmpId()),
        verifySatus: (saveButton.value==RequestConstant.SUBMIT || saveButton.value==RequestConstant.RESUBMIT)?"N":"Y",
        appstatus:(saveButton.value==RequestConstant.APPROVAL)?"Y":"N" ,
        approvedby: (saveButton.value==RequestConstant.APPROVAL)?int.tryParse(loginController.EmpId()):0,
        materialdebitAmt: double.tryParse(materialDebitamt.text) ?? 0.0,
        materiadebitremarks: materialDebitRemarks.text,
        paymentDate: billPaymentWkDateController.text,
        userId: int.tryParse(loginController.UserId()),
        deviceName: BaseUtitiles.deviceName,
        billDet: getNmrBillDet(),
        billAddless: getNmrBillDetAddLess()));

    final list = await DirectBillGenerateProvider.SaveBillDirectAPI(
        body, saveButton.value, context,"D");

    if (list != null) {
      if (id != 0) {
        billgen_itemlistTable_Delete();
        ItemGetTableListdata.value.clear();
        if (id != 0) {
          if(saveButton.value==RequestConstant.RESUBMIT){
            await DirectBill_EntryList();
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
          billgen_itemlistTable_Delete();
          ItemGetTableListdata.value.clear();
          BaseUtitiles.showToast(list!);
          clearDatas();
          await DirectBill_EntryList();
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

  List<BillDet>? getNmrBillDet() {
    getDetList.value = [];
    ItemGetTableListdata.forEach((element) {
      var list = BillDet(
        unit: element.unit.toString(),
        rate: element.rate,
        amt: element.amount,
        actualQty: element.qty,
        workorderdetid: element.workDetId,
        itemDes: element.Name,
        wtype: "D",
      );
      getDetList.add(list);
    });
    return getDetList;
  }

  List<BillAddless>? getNmrBillDetAddLess() {
    getDetAddLessList.value = [];
    directBillGen_ItemReadList.forEach((element) {
      if (element.percentValue! > 0) {
        var list = BillAddless(
          alId: element.addLessId,
          percent: element.percentValue,
          amount: element.amount?.abs().toDouble(),
        );
        getDetAddLessList.add(list);
      }
    });
    return getDetAddLessList;
  }

  void updateAdvanceReadOnly() {
    final amt = double.tryParse(tobededadv.text) ?? 0.0;
    isAdvanceReadOnly.value = amt <= 0;
  }

  Future<bool> deductionPaymentCalculation() async {
    double advLimit = double.tryParse(tobededadv.text) ?? 0;
    double advDed = double.tryParse(Advded.text) ?? 0;

    if (advLimit < advDed) {
      BaseUtitiles.showToast("Please change the adv deduction amount");
      return false;
    }

    if (ItemGetTableListdata.value.isEmpty) return false;

    // Calculate Bill Amount
    double totalNetAmount = 0.0;

    for (var item in ItemGetTableListdata.value) {
      totalNetAmount += item.amount ?? 0;
    }

    billamount.text = totalNetAmount.toStringAsFixed(2);
    balAmt.text = totalNetAmount.toStringAsFixed(2);

    double bill = double.tryParse(billamount.text) ?? 0;
    // double food = double.tryParse(foodDeduction.text) ?? 0;
    double credit = double.tryParse(Creditamt.text) ?? 0;
    double matDebit = double.tryParse(materialDebitamt.text) ?? 0;
    double debit = double.tryParse(Debitamt.text) ?? 0;
    double adv = double.tryParse(Advded.text) ?? 0;
    String roundText = Roundoff.text.trim();

    double round = (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    // Recalculate all Add/Less, NetBill and NetPay
    recalculateAddLessAmounts(
      bill: bill,
      credit: credit,
      matDebit: matDebit,
      debit: debit,
      adv: adv,
      round: round,
    );

    // Optional validation
    if ((double.tryParse(netpayamt.text) ?? 0) < 0) {
      return false;
    }

    directBillGen_ItemReadList.refresh();

    await saveUpdatedCalcData();

    return true;
  }
  // ADD THIS

  bool calculateAndUpdate(int addLessId, double percent) {
    final item = directBillGen_ItemReadList.firstWhereOrNull(
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

    // ============================================================
    // ALWAYS USE BILL AMOUNT AS BASE
    // ============================================================

    final double bill = double.tryParse(billamount.text) ?? 0;

    recalculateAddLessAmounts(
      bill: bill,
      credit: double.tryParse(Creditamt.text) ?? 0,
      debit: double.tryParse(Debitamt.text) ?? 0,
      matDebit: double.tryParse(materialDebitamt.text) ?? 0,
      adv: double.tryParse(Advded.text) ?? 0,
      round: round,
    );

    // ============================================================
    // VALIDATE NET PAY
    // ============================================================

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
        credit: double.tryParse(Creditamt.text) ?? 0,
        debit: double.tryParse(Debitamt.text) ?? 0,
        matDebit: double.tryParse(materialDebitamt.text) ?? 0,
        adv: double.tryParse(Advded.text) ?? 0,
        round: round,
      );

      directBillGen_ItemReadList.refresh();
      update();

      return false;
    }

    directBillGen_ItemReadList.refresh();
    update();

    return true;
  }

  void recalculateAddLessAmounts({
    required double bill,
    required double credit,
    required double debit,
    required double matDebit,
    required double adv,
    required double round,
  }) {
    // ============================================================
    // BILL AMOUNT IS THE BASE FOR ALL PERCENTAGES
    // ============================================================

    final double baseAmount = bill;

    // ============================================================
    // STEP 1
    // CALCULATE EVERY PERCENTAGE ROW
    // ============================================================

    for (var item in directBillGen_ItemReadList) {
      final name = (item.addLessName ?? "").trim().toUpperCase();

      final percent = item.percentValue ?? 0.0;

      // Only percentage based rows
      if (name == "S-GST" ||
          name == "C-GST" ||
          name == "I-GST" ||
          name == "RETENTION" ||
          name == "TDS" ||
          name == "HOLD") {
        final double amount = baseAmount * percent / 100;

        if (item.addLessType == "-") {
          item.amount = -amount;
        } else {
          item.amount = amount;
        }
      }
    }

    // ============================================================
    // STEP 2
    // FINAL AMOUNT STARTS FROM BILL
    // ============================================================

    double finalAmount = baseAmount;

    // Credit
    finalAmount += credit;

    // Debit
    finalAmount -= debit;

    finalAmount -= matDebit;

    // ============================================================
    // STEP 3
    // ADD / LESS AMOUNTS
    // ============================================================

    for (var item in directBillGen_ItemReadList) {
      final name = (item.addLessName ?? "").trim().toUpperCase();

      if (name == "S-GST" ||
          name == "C-GST" ||
          name == "I-GST" ||
          name == "RETENTION" ||
          name == "TDS" ||
          name == "HOLD") {
        finalAmount += item.amount ?? 0.0;
      }
    }

    // ============================================================
    // STEP 4
    // ROUNDOFF
    // ============================================================

    finalAmount += round;

    // ============================================================
    // STEP 5
    // ADVANCE
    // ============================================================

    finalAmount -= adv;

    // ============================================================
    // STEP 6
    // NET BILL = NET PAY
    // ============================================================

    netBillAmt.text = finalAmount.toStringAsFixed(2);

    netpayamt.text = finalAmount.toStringAsFixed(2);

    // ============================================================
    // REFRESH
    // ============================================================

    directBillGen_ItemReadList.refresh();
    update();
  }

  void updateNetPay() {
    String roundText = Roundoff.text.trim();

    double round = (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    recalculateAddLessAmounts(
      bill: double.tryParse(billamount.text) ?? 0,
      credit: double.tryParse(Creditamt.text) ?? 0,
      debit: double.tryParse(Debitamt.text) ?? 0,
      matDebit: double.tryParse(materialDebitamt.text) ?? 0,
      adv: double.tryParse(Advded.text) ?? 0,
      round: round,
    );
  }

// ADD THIS
  Future<void> saveUpdatedCalcData() async {
    await updateDirectBillCalDatas();
  }

  double getTotalAddLess() {
    double total = 0;

    for (final item in directBillGen_ItemReadList) {
      total += item.amount ?? 0;
    }

    return total;
  }

  Future<void> directBillCalculationSave() async {
    directBillTableModelList = [];

    for (final element in billDet_Calculation.value) {
      final directBillTable = DirectBillGSTCalTable();

      directBillTable.reqDetId = 0;
      directBillTable.addLessId = element.id;
      directBillTable.percentValue = element.per;
      directBillTable.amount = 0.0;
      directBillTable.addLessName = element.addLessName;
      directBillTable.addLessType = element.addLessType;

      directBillTableModelList.add(directBillTable);
    }

    await directBillGen_ItemlistService.DirectBillGST_ItemTable_Save(
        directBillTableModelList);
  }

  Future getDirectBillCalDatas() async {
    var datas = await directBillGen_ItemlistService
        .DirectBillGST_ItemlistTable_readAll();
    directBillGen_ItemReadList.value = <DirectBillGSTCalTable>[];
    directBillGen_ItemReadList.clear();
    datas.forEach((value) {
      directBillTable = DirectBillGSTCalTable();
      directBillTable.reqDetId = value['reqDetId'];
      directBillTable.addLessId = value['addLessId'];
      directBillTable.percentValue = value['percentValue'];
      directBillTable.amount = value['amount'];
      directBillTable.addLessName = value['addLessName'];
      directBillTable.addLessType = value['addLessType'];
      directBillGen_ItemReadList.add(directBillTable);
    });
    initPercentControllers();
  }

  updateDirectBillCalDatas() async {
    int i = 0;
    updateBillGen_ItemReadList.clear();
    directBillGen_ItemReadList.forEach((element) {
      directBillTable = DirectBillGSTCalTable();
      directBillTable.reqDetId = element.reqDetId;
      directBillTable.addLessId = element.addLessId;
      directBillTable.percentValue = element.percentValue;
      directBillTable.amount = element.amount;
      directBillTable.addLessName = element.addLessName;
      directBillTable.addLessType = element.addLessType;
      updateBillGen_ItemReadList.add(directBillTable);
      i++;
    });
    await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_Update(
        updateBillGen_ItemReadList);
  }

  DirectBillCal_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_delete();
  }

  Future<void> preloadEditAddLessData(List<dynamic> editAddLessList) async {
    // First load local DB rows
    await getDirectBillCalDatas();

    // Update local rows with edit API values
    for (var editItem in editAddLessList) {
      int index = directBillGen_ItemReadList.indexWhere(
        (e) => e.addLessId == editItem.addlessid,
      );

      if (index != -1) {
        // directBillGen_ItemReadList[index].reqDetId = editItem.id;

        directBillGen_ItemReadList[index].percentValue =
            (editItem.per ?? 0).toDouble();

        directBillGen_ItemReadList[index].amount =
            (editItem.amount ?? 0).toDouble();

        // Update controller text also
        percentControllers[index].text = (editItem.per ?? 0) == 0
            ? ''
            : editItem.per.toString();
      }
    }

    // Refresh UI
    directBillGen_ItemReadList.refresh();

    // Recalculate total/netpay
    updateNetPay();
  }

  void initPercentControllers() {
    percentControllers.clear();
    for (var item in directBillGen_ItemReadList) {
      percentControllers.add(
        TextEditingController(
          text: (item.percentValue ?? 0.0) == 0.0
              ? ''
              : item.percentValue.toString(),
        ),
      );
    }
  }

  Future directBillEntryList_EditApi(int workid, BuildContext context,type) async {
    bill_editListApiDatas.value=[];
    await DirectBillGenerateProvider.directBill_entryList_editAPI(workid)
        .then((value) async {
      if (value != null && value.length > 0) {
        saveButton.value= type=="Edit"?RequestConstant.RESUBMIT:type=="Verify"?RequestConstant.VERIFY:RequestConstant.APPROVAL;
        bill_editListApiDatas.value = value;
        billgen_EditTable_SaveTable("");
        getItemlistTablesDatas();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Bill_Generation_EntryScreen()),
        );
      }
    });
  }

  Future EntryList_DeleteApi(int WorkId, int subId, String WorkNo) async {
    await DirectBillGenerateProvider.entryList_deleteAPI(WorkId, subId, WorkNo,
            loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  billgen_EditTable_SaveTable(name) async {
    ItemListTableModelList.clear();
    bill_editListApiDatas.value.forEach((element) {
      if (name == "ItemListDet") {
      ItemListTableModel = DirectBillGenItemListTableModel();
      ItemListTableModel.workDetId = element.dworkDet_id;
      ItemListTableModel.Name = element.itemDesc.toString();
      ItemListTableModel.unit = element.unit.toString();
      ItemListTableModel.qty = element.qty;
      ItemListTableModel.rate = element.rate;
      ItemListTableModel.amount = element.amount;
      ItemListTableModel.isApi = 1;
      ItemListTableModelList.add(ItemListTableModel);
      }
      else {
        element.billEditDet!.forEach((value) {
          ItemListTableModel = DirectBillGenItemListTableModel();
          ItemListTableModel.workDetId = value.workorderDetId;
          ItemListTableModel.Name = value.itemDesc.toString();
          ItemListTableModel.unit = value.unit.toString();
          ItemListTableModel.qty = value.qty;
          ItemListTableModel.rate = value.rate;
          ItemListTableModel.amount = value.amount;
          ItemListTableModel.isApi = 1;
          ItemListTableModelList.add(ItemListTableModel);
        });
      }
    });

    var savedatas =
        await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Save(
            ItemListTableModelList);
    return savedatas;
  }

  Future DeleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
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
                          billgen_itemlistTable_Delete();
                          ItemGetTableListdata.value.clear();
                          EntryList_DeleteApi(
                              bill_entryList[index].workId,
                              bill_entryList[index].subContId,
                              bill_entryList[index].workNo);
                          bill_entryList.removeAt(index);
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
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
}
