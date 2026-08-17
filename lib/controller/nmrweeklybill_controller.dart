import 'dart:convert';

import 'package:mcr/controller/pendinglistcontroller.dart';

import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/direct_bill_gst_calculation_model.dart';
import '../db_services/direct_bill_itemlist_service.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entry_site.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entrylist_site.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_week_billgeneration_site.dart';
// import '../models/billdirectgstcalculations.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../provider/common_provider.dart';
import '../provider/directbill_generat_provider.dart';
import '../provider/nmrwkly_provider.dart';
import '../provider/workOrderDirectProvider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../home/menu/daily_entries/subcont_nmr_weekbill_site/aprovedpopup.dart';
import 'billgenerationdirect_controller.dart';

class NMRWklyController extends GetxController {
  final NmrentryDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final RemarksController = TextEditingController();
  final billamount = TextEditingController();
  final foodDeduction = TextEditingController();
  final Creditamt = TextEditingController();
  final CreditRemarksController = TextEditingController();
  final Debitamt = TextEditingController();
  final DebitRemarksController = TextEditingController();
  final tobededadv = TextEditingController();
  final Advded = TextEditingController();
  final Roundoff = TextEditingController();
  final netBillAmt = TextEditingController();
  final netpayamt = TextEditingController();
  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();
  final BillNoController = TextEditingController();

  RxList billDet_Calculation = [].obs;
  RxBool isAdvanceReadOnly = true.obs;

  List<TextEditingController> SitenameController = [];
  List<TextEditingController> CategorynameController = [];
  List<TextEditingController> TotalNosController = [];
  List<TextEditingController> TotalOTController = [];
  List<TextEditingController> NetAmtController = [];
  List<TextEditingController> TotalAmtController = [];

  RxList<NmrBillDet> getNMRDetList = <NmrBillDet>[].obs;
  RxList<NMRBillAdd> getNMRAddLessDetList = <NMRBillAdd>[].obs;
  int workid = 0;
  RxList NmrEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList NmritemList = [].obs;
  RxList NmrcheckStatusList = [].obs;
  RxList NmrcheckCountList = [].obs;
  RxList getNMRBillNoValue = [].obs;
  List<TextEditingController> WagesController = [];
  List<TextEditingController> TotalOTHrsController = [];

  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxInt createdById = 0.obs;
  double totalNetBillamount = 0.0;
  double totalNetPayAmt = 0.0;
  double baseNetPayAmt = 0.0;
  String oldAdvValue = "0.0";
  RxList reqDetIdNmrDet = [].obs;
  String oldRoundOffValue = "0.0";
  String oldDebitValue = "0.0";
  String oldFoodValue = "0.0";
  String oldCreditValue = "0.0";
  String to_be_dection_advance = "0.0";
  bool isRestoring = false;

  RxList EditListSaveDatas = [].obs;

  LoginController loginController = Get.put(LoginController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  BillGenerationDirectController billGenerationDirectController = Get.put(BillGenerationDirectController());
  var directBillTable = DirectBillGSTCalTable();
  late List<DirectBillGSTCalTable> directBillTableModelList = <DirectBillGSTCalTable>[];
  var directBillGen_ItemlistService = DirectBillGen_ItemlistService();
  RxList<DirectBillGSTCalTable> directBillGen_ItemReadList = <DirectBillGSTCalTable>[].obs;
  late List<DirectBillGSTCalTable> updateBillGen_ItemReadList = <DirectBillGSTCalTable>[];
  List<TextEditingController> percentControllers = [];
  PendingListController pendingListController = Get.put(PendingListController());


  Future getNmrEntryList() async {
    NmrEtyList.value.clear();
    mainEtyList.value.clear();
    await NMRWklyprovider.getSubcontNmrEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        EntrylistFrDate.text,
        EntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainEtyList.value = value;
        NmrEtyList.value = mainEtyList.value;
        return mainEtyList.value;
      }
    });
  }

  Future getNMRBillNoList(int pid,  int subid) async {
    getNMRBillNoValue.value = await CommonProvider.getNMRBillNoList(pid,subid);
    getNMRBillNoValue.value.forEach((element){
      BillNoController.text=element.EntryAutoNo.toString();
    });
  }

  // void validateAdvanceAmount(String value) {
  //   final double enteredAmt = double.tryParse(value) ?? 0.0;
  //   final double maxAmt = double.tryParse(tobededadv.text) ?? 0.0;
  //
  //   if (enteredAmt > maxAmt) {
  //     BaseUtitiles.showToast(
  //         "Advance deduction cannot exceed the advance amount.");
  //
  //     Advded.text = "0.0";
  //
  //     // Move cursor to end
  //     Advded.selection = TextSelection.fromPosition(
  //       TextPosition(offset: Advded.text.length),
  //     );
  //   }
  // }


  Future submit_getNmrItemList_Site() async {
    NmritemList.value.clear();
    await NMRWklyprovider.getSubcontNmrItem_List_Site(
        subcontractorController.selectedSubcontId.value,
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        FromdateController.text,
        TodateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        NmritemList.value = value;
        BaseUtitiles.showToast(RequestConstant.RECORD_SUCCESSFULLY);
        return NmritemList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
    setTextControllersValue();
  }


  setTextControllersValue() async {
    int i = 0;
    NmritemList.value.forEach((element) {
      totalNetBillamount = totalNetBillamount + element.netAmt;
      textControllersInitiate();
      SitenameController[i].text = element.siteName;
      CategorynameController[i].text = element.categoryName;
      WagesController[i].text = element.Rate.toString();
      TotalNosController[i].text = element.totnos.toString();
      TotalOTHrsController[i].text = element.total_othrs.toString();
      TotalAmtController[i].text = element.Totamt.toString();
      TotalOTController[i].text = element.totalOtamt.toString();
      NetAmtController[i].text = element.netAmt.toString();
      i++;
    });
  }

  setTextEditListControllersValue() async {
    int i = 0;
    EditListSaveDatas.value.forEach((element) {
      element.nmrBillDet.forEach((value) {
        textControllersInitiate();
        SitenameController[i].text = value.siteName;
        CategorynameController[i].text = value.categoryName;
        WagesController[i].text = value.wages.toString();
        TotalNosController[i].text = value.totnos.toString();
        TotalOTHrsController[i].text = value.totalOthrs.toString();
        TotalAmtController[i].text = value.amt.toString();
        TotalOTController[i].text = value.totalOtamt.toString();
        NetAmtController[i].text = value.nmrAmt.toString();
        i++;
      });
    });
  }

  textControllersInitiate() {
    SitenameController.add(new TextEditingController());
    CategorynameController.add(new TextEditingController());
    WagesController.add(new TextEditingController());
    TotalNosController.add(new TextEditingController());
    TotalOTHrsController.add(new TextEditingController());
    TotalAmtController.add(new TextEditingController());
    NetAmtController.add(new TextEditingController());
    TotalOTController.add(new TextEditingController());
  }


  clearDatas(){
    NmritemList.value=[];
    projectController.projectname.text="--SELECT--";
    projectController.selectedProjectId.value=0;
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.selectedsiteId.value=0;
    subcontractorController.Subcontractorname.text="--SELECT--";
    subcontractorController.selectedSubcontId.value=0;
    RemarksController.clear();
    // subcontractorController.InvoiceNo.text="-";
    NmrentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    FromdateController.text=BaseUtitiles.initiateCurrentDateFormat();
    TodateController.text=BaseUtitiles.initiateCurrentDateFormat();
    EditListSaveDatas.value=[];
    workid=0;
    billamount.text="0.0";
    foodDeduction.text="0.0";
    Creditamt.text="0.0";
    Debitamt.text="0.0";
    CreditRemarksController.text="-";
    DebitRemarksController.text="-";
    Advded.text="0.0";
    Roundoff.text="0.0";
    netpayamt.text="0.0";
  }

  Future SaveButton_DeductionScreen(BuildContext context, int id) async {
    getNMRDetList.value.clear();
    String body = subcontNmrSaveRequestToJson(NmrSaveRequest(
      workId: id != 0 ? id.toString() : "0",
      workNo: autoYearWiseNoController.text,
      entryDate: NmrentryDateController.text,
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.toString(),
      subContId: subcontractorController.selectedSubcontId.value.toString(),
      fromDate: FromdateController.text,
      toDate: TodateController.text,
      remarks: RemarksController.text,
      rndOff: Roundoff.text,
      billNo: BillNoController.text==""?"-":BillNoController.text,
      billAmt: billamount.text,
      actAdvAmt: tobededadv.text,
      advAmt: Advded.text,
      netPayAmt: netpayamt.text,
      debitAmt: Debitamt.text,
      creditAmt: Creditamt.text,
      debitRemarks: DebitRemarksController.text,
      creditRemarks: CreditRemarksController.text,
      preparedby: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode:saveButton.value=="Submit"?"ADD":saveButton.value=="Re-Submit"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
      verifiedby: (saveButton.value==RequestConstant.SUBMIT || saveButton.value==RequestConstant.RESUBMIT)?"0":loginController.EmpId(),
      verifystatus: (saveButton.value==RequestConstant.SUBMIT || saveButton.value==RequestConstant.RESUBMIT)?"N":"Y",
      appstatus:(saveButton.value==RequestConstant.APPROVAL)?"Y":"N" ,
      approvedby: (saveButton.value==RequestConstant.APPROVAL)?loginController.EmpId():"0",
      nmrBillDet: getNmrBillDet(id),
      nmrBillAdd: getNmrBillAddLess()
    ));
    final list = await NMRWklyprovider.SaveSubContScreenEntryAPI(body, id);
    if (list != null ) {
      if (id != 0) {
        if(saveButton.value==RequestConstant.RESUBMIT){
          await getNmrEntryList();
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
        return;
      } else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          Navigator.pop(context);
          Navigator.pop(context);
          return BaseUtitiles.showToast(list);
        } else {
          BaseUtitiles.showToast(list);
          await getNmrEntryList();
          clearDatas();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return;
        }
      }
    }
  }

  List<NmrBillDet>? getNmrBillDet(int id) {
    NmritemList.value.forEach((element) {
      var list = new NmrBillDet(
        projectId: "0",
        siteId: element.siteId.toString(),
        nmrAmt: element.nmrAmt.toString(),
        categoryId: element.categoryId.toString(),
        totnos: element.totnos.toString(),
        totalOtamt: element.totalOtamt.toString(),
      );
      getNMRDetList.value.add(list);
    });
    return getNMRDetList.value;
  }

  List<NMRBillAdd>? getNmrBillAddLess() {
    getNMRAddLessDetList.value=[];
    directBillGen_ItemReadList.forEach((element) {
      if(element.percentValue!>0) {
        var list = NMRBillAdd(
            id: element.addLessId.toString(),
            percent:  element.percentValue.toString(),
            amount: (element.amount ?? 0).abs().toString()
        );
        getNMRAddLessDetList.add(list);
      }
    });
    return getNMRAddLessDetList;
  }


  Future<bool> deduction_paymentCalculation() async {

    double advLimit = double.tryParse(tobededadv.text) ?? 0;
    double advDed = double.tryParse(Advded.text) ?? 0;

    if (advLimit < advDed) {
      BaseUtitiles.showToast("Please change the adv deduction amount");
      return false;
    }

    if (NmritemList.value.isEmpty) return false;

    double totalNetAmount = 0.0;

    for (var item in NmritemList.value) {
      totalNetAmount +=
      (saveButton.value == RequestConstant.RESUBMIT ||
          saveButton.value == RequestConstant.VERIFY ||
          saveButton.value == RequestConstant.APPROVAL)
          ? (item.nmrAmt ?? 0)
          : (item.netAmt ?? 0);
    }

    billamount.text = totalNetAmount.toStringAsFixed(2);

    double bill = double.tryParse(billamount.text) ?? 0;
    double food = double.tryParse(foodDeduction.text) ?? 0;
    double credit = double.tryParse(Creditamt.text) ?? 0;
    double debit = double.tryParse(Debitamt.text) ?? 0;
    double adv = double.tryParse(Advded.text) ?? 0;
    String roundText = Roundoff.text.trim();

    double round =
    (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    // Recalculate all Add/Less, NetBill and NetPay
    recalculateAddLessAmounts(
      bill: bill,
      credit: credit,
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

    final double round =
    (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;

    // ============================================================
    // ALWAYS USE BILL AMOUNT AS BASE
    // ============================================================

    final double bill =
        double.tryParse(billamount.text) ?? 0;

    recalculateAddLessAmounts(
      bill: bill,
      credit: double.tryParse(Creditamt.text) ?? 0,
      debit: double.tryParse(Debitamt.text) ?? 0,
      adv: double.tryParse(Advded.text) ?? 0,
      round: round,
    );

    // ============================================================
    // VALIDATE NET PAY
    // ============================================================

    final double netPay =
        double.tryParse(netpayamt.text) ?? 0;

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
    required double adv,
    required double round,
  }) {
    // ============================================================
    // STEP 1 : CALCULATION BASE
    // Base Amount + Credit - Debit
    // ============================================================

    final double calculationBase = bill + credit - debit;

    // ============================================================
    // STEP 2 : ADD/LESS PERCENTAGES
    // ============================================================

    for (var item in directBillGen_ItemReadList) {
      final name = (item.addLessName ?? "").trim().toUpperCase();
      final percent = item.percentValue ?? 0.0;

      if (name == "S-GST" ||
          name == "C-GST" ||
          name == "I-GST" ||
          name == "RETENTION" ||
          name == "TDS" ||
          name == "HOLD") {
        final amount = calculationBase * percent / 100;

        item.amount = item.addLessType == "-" ? -amount : amount;
      }
    }

    // ============================================================
    // STEP 3 : NET BILL
    // ============================================================

    double netBill = calculationBase;

    for (var item in directBillGen_ItemReadList) {
      netBill += item.amount ?? 0.0;
    }

    // Round Off
    netBill += round;

    // ============================================================
    // STEP 4 : NET PAY
    // ============================================================

    final double netPay = netBill - adv;

    netBillAmt.text = netBill.toStringAsFixed(2);
    netpayamt.text = netPay.toStringAsFixed(2);

    directBillGen_ItemReadList.refresh();
    update();
  }

  void updateAdvanceReadOnly() {
    final amt = double.tryParse(tobededadv.text) ?? 0.0;
    isAdvanceReadOnly.value = amt <= 0;
  }

  void updateNetPay() {
    String roundText = Roundoff.text.trim();

    double round =
    (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    recalculateAddLessAmounts(
      bill: double.tryParse(billamount.text) ?? 0,
      credit: double.tryParse(Creditamt.text) ?? 0,
      debit: double.tryParse(Debitamt.text) ?? 0,
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

  Future getNmrAdvance() async {
    to_be_dection_advance="0";
    await NMRWklyprovider.NMR_adv_balance(projectController.selectedProjectId.value,
      subcontractorController.selectedSubcontId.value,
      // siteController.selectedsiteId.value
    ).then((value){
      if (value != null) {
        to_be_dection_advance = value;
        return to_be_dection_advance;
      }
    });
  }

  Future DirectBill_CalculationList({type}) async {
    billDet_Calculation.value=[];
    final value =  await WorkOrderDirectProvider.getWorkOrderCalculation_List(type=="Subcont"?subcontractorController.selectedSubcontId.value:0,0);
    if (value != null && value.length > 0) {
      billDet_Calculation.value = value;
      await DirectBillCal_itemlistTable_Delete();
      await directBillCalculationSave();
      await getDirectBillCalDatas();
      if(saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.APPROVAL) {
        await preloadEditAddLessData(EditListSaveDatas);
      }
    }
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

    await directBillGen_ItemlistService
        .DirectBillGST_ItemTable_Save(directBillTableModelList);
  }

  Future getDirectBillCalDatas() async {
    var datas = await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_readAll();
    directBillGen_ItemReadList.value = <DirectBillGSTCalTable>[];
    directBillGen_ItemReadList.clear();
    datas.forEach((value) {
      directBillTable = DirectBillGSTCalTable();
      directBillTable.reqDetId=value['reqDetId'];
      directBillTable.addLessId=value['addLessId'];
      directBillTable.percentValue=value['percentValue'];
      directBillTable.amount=value['amount'];
      directBillTable.addLessName=value['addLessName'];
      directBillTable.addLessType=value['addLessType'];
      directBillGen_ItemReadList.add(directBillTable);
    });
    initPercentControllers();
  }

  updateDirectBillCalDatas() async {
    int i=0;
    updateBillGen_ItemReadList.clear();
    directBillGen_ItemReadList.forEach((element) {
      directBillTable = DirectBillGSTCalTable();
      directBillTable.reqDetId=element.reqDetId;
      directBillTable.addLessId=element.addLessId;
      directBillTable.percentValue=element.percentValue;
      directBillTable.amount=element.amount;
      directBillTable.addLessName=element.addLessName;
      directBillTable.addLessType=element.addLessType;
      updateBillGen_ItemReadList.add(directBillTable);
      i++;
    });
    await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_Update(updateBillGen_ItemReadList);
  }

  DirectBillCal_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_delete();
  }

  Future<void> preloadEditAddLessData(List<dynamic> editAddLessList) async {

    await getDirectBillCalDatas();

    for (var editItem in editAddLessList) {

      int index = directBillGen_ItemReadList.indexWhere(
            (e) => e.addLessId == editItem.aLid,
      );

      if (index != -1) {

        // directBillGen_ItemReadList[index].reqDetId = editItem.id;

        directBillGen_ItemReadList[index].percentValue =
            (editItem.percent ?? 0).toDouble();

        // Don't use API amount. Recalculate it.
        directBillGen_ItemReadList[index].amount = 0;

        percentControllers[index].text =
        (editItem.percent ?? 0) == 0
            ? ''
            : editItem.percent.toString();
      }
    }

    directBillGen_ItemReadList.refresh();
    String roundText = Roundoff.text.trim();

    double round =
    (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    recalculateAddLessAmounts(
      bill: double.tryParse(billamount.text) ?? 0,
      credit: double.tryParse(Creditamt.text) ?? 0,
      debit: double.tryParse(Debitamt.text) ?? 0,
      adv: double.tryParse(Advded.text) ?? 0,
      round: round,
    );
  }


  Future NmrEntryList_EditApi(int workid, BuildContext context, type) async {
    EditListSaveDatas.value.clear();
    NmritemList.value.clear();
    await NMRWklyprovider.nmr_entryList_editAPI(workid).then((value) async {
      if (value != null && value.length > 0) {
        saveButton.value= type=="Edit"?RequestConstant.RESUBMIT:type=="Verify"?RequestConstant.VERIFY:RequestConstant.APPROVAL;
        EditListSaveDatas.value = value;
        setTextEditListControllersValue();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Subcont_Nmr_EntryScreen_Site()),
        );
      }
    });
  }

  Future Nmr_EntryList_DeleteApi(int WorkId, int subid, String WorkNo) async {
    await NMRWklyprovider.nmr_entryList_deleteAPI(WorkId, subid, WorkNo,
        loginController.UserId(), BaseUtitiles.deviceName)
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
                          NmritemList.value.clear();
                          Nmr_EntryList_DeleteApi(NmrEtyList[index].nmrWorkId,NmrEtyList[index].subcontid,NmrEtyList[index].workNo);
                          NmrEtyList.removeAt(index);
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getNmrcheckstatus(int pid,String subId,int sid,String fadte,String tdate,BuildContext context) async {
    NmrcheckStatusList.value.clear();
    await NMRWklyprovider.getNmrcheckedapproved(pid,subId,sid,fadte,tdate).then((value) async {
      if (value != null && value.length > 0) {
        NmrcheckStatusList.value = value;
        return   showDialog(
            context: context,
            builder: (BuildContext context) {
              return ApprovedAlertPopup(list:NmrcheckStatusList.value);
            });
      }
      else{
        BaseUtitiles.showToast("No Record Found..");
      }
    });
  }

  Future getNmrcheckstatusCount(int pid,String subId,int sid,String fadte,String tdate) async {
    NmrcheckCountList.value.clear();
    await NMRWklyprovider.getNmrcheckedapprovedCount(pid,subId,sid,fadte,tdate).then((value) async {
      if (value != null && value.length > 0) {
        if(value[0].reccount==value[0].appCount){
          submit_getNmrItemList_Site();
        }
        else{
          NmritemList.value.clear();
        }
      }
    });
  }
}

