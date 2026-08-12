import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcr/controller/pendinglistcontroller.dart';
import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/billBoq_itemlist_model.dart';
import '../db_model/direct_bill_gst_calculation_model.dart';
import '../db_services/bill_boq_itemlist_service.dart';
import '../home/menu/daily_entries/bill_generation/bill_generation_boq_entry.dart';
import '../models/directbill_gener_saveapireq_model.dart';
import '../provider/billgenerationBoq_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dailywrk_done_dpr_controller.dart';

class BillGenerationBoqController extends GetxController{

  final billentryDateController = TextEditingController();
  final billInvoiceDateController = TextEditingController();
  final billPaymentWkDateController = TextEditingController();
  final entryTypeController = TextEditingController();
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
  List<TextEditingController> itemlist_ListAppQtyController = [];
  List<TextEditingController> itemlist_ListBalQtyController = [];
  List<TextEditingController> itemlist_ListCurQtyController = [];

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
  final netBillAmt = TextEditingController();
  final finalBillAmt = TextEditingController();
  final netpayamt = TextEditingController();
  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();

  var directBillGen_ItemlistService = BillGenBoq_ItemlistService();

  RxList main_entryList = [].obs;
  RxList bill_entryList = [].obs;

  RxList ItemGetTableListdata = [].obs;

  RxString saveButton=RequestConstant.SUBMIT.obs;

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController =
  Get.put(SubcontractorController());
  PendingListController pendingListController = Get.put(PendingListController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
  Get.put(DailyWrkDone_DPR_Controller());
  LoginController loginController = Get.put(LoginController());


  String to_be_dection_advance = "0";

  int workid = 0;


  var ItemListTableModel = BillGenBoqItemListTableModel();
  late List<BillGenBoqItemListTableModel> ItemListTableModelList = <BillGenBoqItemListTableModel>[];
  List ItemListTableModelReadList = <BillGenBoqItemListTableModel>[];
  late List<BillGenBoqItemListTableModel> itemListUpdateModelList = <BillGenBoqItemListTableModel>[];
  late List<BillGenBoqItemListTableModel> deleteitemListModelList = <BillGenBoqItemListTableModel>[];

  var directBillTable = DirectBillGSTCalTable();
  late List<DirectBillGSTCalTable> directBillTableModelList = <DirectBillGSTCalTable>[];
  RxList<DirectBillGSTCalTable> directBillGen_ItemReadList = <DirectBillGSTCalTable>[].obs;
  late List<DirectBillGSTCalTable> updateBillGen_ItemReadList = <DirectBillGSTCalTable>[];
  List<TextEditingController> percentControllers = [];

  // RxList<SubContractorWorkQtyDet> getDetList = <SubContractorWorkQtyDet>[].obs;
  // RxList<SubContractorBillAddLessSetup> getDetAddLessList = <SubContractorBillAddLessSetup>[].obs;

  Future BillGenBoq_EntryList() async {
    main_entryList.value.clear();
    bill_entryList.value.clear();
    await BillGenerationBoqProvider.getBillBoqEntry_List(
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

  billgen_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_delete();
  }

  Future EntryList_DeleteApi(int WorkId,int subId,String WorkNo) async {
    await BillGenerationBoqProvider.entryList_deleteAPI(WorkId,subId,WorkNo,loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  Future DeleteAlert(BuildContext context, int index ) async {
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
                          EntryList_DeleteApi(bill_entryList[index].workId,bill_entryList[index].subContId,bill_entryList[index].workNo);
                          bill_entryList.removeAt(index);
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


}