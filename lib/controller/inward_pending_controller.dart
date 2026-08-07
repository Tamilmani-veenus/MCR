import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../db_model/inwardpending_itemlist_table_model.dart';
import '../db_services/inwardpending_itemlist_service.dart';
import '../home/menu/materials/inward/inward_Entry.dart';
import '../home/menu/materials/inward/inward_list.dart';
import '../models/getting_image_response.dart';
import '../models/image_delete_response.dart';
import '../models/image_payload.dart';
import '../models/inward_pending_entrylist_model.dart';
import '../models/inwardimageres_model.dart';
import '../models/inwardpending_save_apireq_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/poamdapproveres_model.dart';
import '../provider/inward_pending_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';
import 'pendinglistcontroller.dart';


int? inwardId;

class ImageState {

  ImageState();
}

class InwardPending_Controller extends GetxController with StateMixin<ImageState> {

  final InwardAutoyearText = TextEditingController();
  final InwardEntryDateText = TextEditingController();
  final InwardSupplierNameText = TextEditingController();
  final InwardProjectNameText = TextEditingController();
  final InwardSiteNameText = TextEditingController();
  final InwardInvoiceNoText = TextEditingController();
  final InwardInvoiceDateText = TextEditingController();
  final InwardDCNoText = TextEditingController();
  final InwardDCDateText = TextEditingController();
  final InwardManualNoText = TextEditingController();
  final InwardTypeText = TextEditingController();
  final InwardNoText = TextEditingController();
  final InwardVechileNoText = TextEditingController();
  final InwardDriverNameText = TextEditingController();
  final InwardFreightChargesText = TextEditingController();
  final InwardLabourChargesText = TextEditingController();
  final InwardRoundoffText = TextEditingController();
  final InwardNetAmtText = TextEditingController();
  final InwardRemarksText = TextEditingController();

  List<TextEditingController> Itemlist_Inward_QtyListController = [];
  List<TextEditingController> Itemlist_Qty_PlusListController = [];
  List<TextEditingController> Itemlist_Qty_MinusListController = [];
  RxList<InwardDet> getInwardDetList = <InwardDet>[].obs;
  RxList<InwardDetList> getInwardDetAmedmentList = <InwardDetList>[].obs;

  RxList editListApiDatas = [].obs;

  final InwardEntrylistFrDate = TextEditingController();
  final InwardEntrylistToDate = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  PendingListController pendingListController = Get.put(PendingListController());

  late List<InwardPendingItemListTableModel> ItemListTableModelList =
  <InwardPendingItemListTableModel>[];
  var ItemListTableModel = InwardPendingItemListTableModel();
  var inwardPending_ItemlistService = InwardPending_ItemlistService();
  List ItemListTableModelReadList = <InwardPendingItemListTableModel>[];
  late List<InwardPendingItemListTableModel> itemListUpdateModelList = <InwardPendingItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  RxList<InwardDetList> getInwardDetAmedment_List = <InwardDetList>[].obs;
  RxList<InwardPendingItemListTableModel> add_PoAmdaprovalListvalue = <InwardPendingItemListTableModel>[].obs;


  RxList inwardEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList PoAmdList = [].obs;
  RxList poAmd_mainList = [].obs;
  RxList validatecheck = [].obs;
  RxList inwardAllDatasList = [].obs;
  RxList inwardItemListdatas = [].obs;
  RxString base64TypeImage = "".obs;

  List<bool>? ischecked;
  bool save_checked = false;
  List<ImageView>? gettingNetworkImages;
  RxList<String> gettingNetworkImageList = <String>[].obs;
  RxList<int> imageId = <int>[].obs;
  RxBool checkImgList = false.obs;

  RxInt netWorkImageCount = 0.obs;
  RxInt pickedImageCount = 0.obs;

  int projectId = 0;
  int siteId = 0;
  int supId = 0;
  int inwardID = 0;
  int buttonControl = 0;

  int entryvalue = 0;
  int editvalue = 0;
  String screenCheck = "";
  int checkColor = 0;
  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxInt count = 0.obs;

  clearDatas() {
    inwardID = 0;
    InwardSupplierNameText.text = "--Select--";
    InwardProjectNameText.text = "--Select--";
    InwardSiteNameText.text = "--Select--";
    projectId = 0;
    siteId = 0;
    supId = 0;
    InwardNoText.text = "";
    InwardFreightChargesText.text = "0";
    InwardLabourChargesText.text = "0";
    InwardRoundoffText.text = "0";
    InwardNetAmtText.text = "0";
    InwardInvoiceNoText.text = "";
    InwardDCNoText.text = "";
    InwardManualNoText.text = "";
    InwardVechileNoText.text = "";
    InwardDriverNameText.text = "";
    InwardRemarksText.text = "";
    Zerovalueset(ItemGetTableListdata);
    itemlistTable_Delete();
    ItemGetTableListdata.value.clear();
  }

  // Future getInward_EntryList(BuildContext context) async {
  //   inwardEtyList.value.clear();
  //   mainEtyList.value.clear();
  //   await Inward_Pending_provider.getInwardEntry_List(
  //       loginController.user.value.userId,
  //       loginController.UserType(),
  //       InwardEntrylistFrDate.text,
  //       InwardEntrylistToDate.text).then((value)  {
  //     if (value != null && value.length > 0) {
  //       mainEtyList.value = value;
  //       inwardEtyList.value = mainEtyList.value;
  //       return  mainEtyList.value;
  //     }
  //     else {
  //       BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
  //     }
  //   });
  // }
  //
  // Future<List<Inwardentrylist>> getInward_EntryList(BuildContext context) async {
  //   var data;
  //   data = await Inward_Pending_provider.getInwardEntry_List(
  //       loginController.user.value.userId,
  //       loginController.UserType(),
  //       InwardEntrylistFrDate.text,
  //       InwardEntrylistToDate.text);
  //   return data;
  // }

  Future<List<Inwardentrylist>> getInward_EntryList(BuildContext context) async {
    List<Inwardentrylist> data = [];
    data = await Inward_Pending_provider.getInwardEntry_List(loginController.user.value.userId, loginController.UserType(), InwardEntrylistFrDate.text, InwardEntrylistToDate.text);
    inwardEtyList.value = data;
    return data;
  }

  /// ----- Po Amendment List -----

  Future getPo_AmendmentList(BuildContext context, int purOrdId) async {
    PoAmdList.value=[];
    poAmd_mainList.value=[];
    Inward_Pending_provider.getPoAmendment(purOrdId).then((value)  {
      if (value != null && value.length > 0) {
        poAmd_mainList.value = value;
        PoAmdList.value = poAmd_mainList.value;
        return PoAmdList.value ;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future getInward_Alldatas(int poId, BuildContext context) async {
    inwardAllDatasList.clear();
    inwardItemListdatas.value.clear();
    await Inward_Pending_provider.getInward_ALLDatas(poId).then((value) async {
      if (value != null && value.length > 0) {
        inwardAllDatasList.value = value;
        entryvalue = 0;
        editvalue = 0;
        inwardAllDatasList.value.forEach((element) {
          element.getPoDet.forEach((val) {
            inwardItemListdatas.value.add(val!);
            // print(inwardItemListdatas);
          });
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Inward_entry()));
        FocusScope.of(context).unfocus();
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Zerovalueset(List list) {
    int index = 0;
    list.forEach((element) {
      itemlist_textControllersInitiate();
      Itemlist_Inward_QtyListController[index].text = "0.0";
      Itemlist_Qty_PlusListController[index].text = "0.0";
      Itemlist_Qty_MinusListController[index].text = "0.0";
      index++;
    });
  }

  editClick(String value) {
    int i = 0;
    ItemGetTableListdata.value.forEach((element) {
      itemlist_textControllersInitiate();
      if (Itemlist_Inward_QtyListController[i].value.text == "" ||
          Itemlist_Inward_QtyListController[i].value.text == "0.0" ||
          Itemlist_Inward_QtyListController[i].value.text == "0") {
        Itemlist_Qty_PlusListController[i].text = "0.0";
        Itemlist_Qty_MinusListController[i].text = "0.0";
      } else {
        Itemlist_Qty_PlusListController[i].text = ItemGetTableListdata[i]
            .balQty <=
            double.parse(
                Itemlist_Inward_QtyListController[i].value.text.toString())
            ? (double.parse(Itemlist_Inward_QtyListController[i]
            .value
            .text
            .toString()) -
            ItemGetTableListdata[i].balQty)
            .toString()
            : Itemlist_Qty_PlusListController[i].text = "0.0";
        Itemlist_Qty_MinusListController[i].text = ItemGetTableListdata[i]
            .balQty >=
            double.parse(
                Itemlist_Inward_QtyListController[i].value.text.toString())
            ? (ItemGetTableListdata[i].balQty -
            double.parse(Itemlist_Inward_QtyListController[i]
                .value
                .text
                .toString()))
            .toString()
            : Itemlist_Qty_MinusListController[i].text = "0.0";
        ischecked![i] = ItemGetTableListdata[i].balQty <
            double.parse(Itemlist_Inward_QtyListController[i].value.text.toString())
            ? true
            : false || ItemGetTableListdata[i].balQty > double.parse(Itemlist_Inward_QtyListController[i].value.text.toString())
            ? false
            : false;
        InwardNetAmtText.text = (double.parse(Itemlist_Inward_QtyListController[i].value.text) * ItemGetTableListdata[i].rate).toString();
      }
      i++;
    });
    updateItemlistTable();
  }

  itemlist_textControllersInitiate() {
    Itemlist_Inward_QtyListController.add(TextEditingController());
    Itemlist_Qty_PlusListController.add(TextEditingController());
    Itemlist_Qty_MinusListController.add(TextEditingController());
  }

  itemlistTable_Delete() async {
    await inwardPending_ItemlistService.InwardPending_ItemlistTable_delete();
  }

  inwardpending_itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    inwardItemListdatas.value.forEach((element) {
      ItemListTableModel = new InwardPendingItemListTableModel();
      ItemListTableModel.poDetId = element.poDetId;
      ItemListTableModel.materialId = element.materialId;
      ItemListTableModel.materialName = element.materialName.toString();
      ItemListTableModel.unit = element.unit.toString();
      ItemListTableModel.poQty = element.poQty;
      ItemListTableModel.balQty = element.balQty;
      ItemListTableModel.rate = element.rate;
      ItemListTableModel.inwQty = element.inwQty;
      ItemListTableModel.addQty = element.addQty;
      ItemListTableModel.lessQty = element.lessQty;
      ItemListTableModel.amdCheck = element.amdCheck;
      ItemListTableModelList.add(ItemListTableModel);
    });
    var savedatas =
    await inwardPending_ItemlistService.InwardPending_ItemlistTable_Save(
        ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {
    var datas = await inwardPending_ItemlistService
        .InwardPending_ItemlistTable_readAll();
    ItemListTableModelReadList = <InwardPendingItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new InwardPendingItemListTableModel();
      itemlist_textControllersInitiate();
      ItemListTableModel.id = value['id'];
      ItemListTableModel.poDetId = value['poDetId'];
      ItemListTableModel.materialId = value['materialId'];
      ItemListTableModel.materialName = value['materialName'];
      ItemListTableModel.unit = value['unit'];
      ItemListTableModel.poQty = value['poQty'];
      ItemListTableModel.balQty = value['balQty'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.inwQty = value['inwQty'];
      ItemListTableModel.addQty = value['addQty'];
      ItemListTableModel.lessQty = value['lessQty'];
      ItemListTableModel.amdCheck = value['amdCheck'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      itemlist_textControllersInitiate();
      Itemlist_Inward_QtyListController[i].text = datas.inwQty.toString();
      Itemlist_Qty_PlusListController[i].text = datas.addQty.toString();
      Itemlist_Qty_MinusListController[i].text = datas.lessQty.toString();
      i++;
    });
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      itemlist_textControllersInitiate();
      ItemListTableModel = new InwardPendingItemListTableModel();
      ItemListTableModel.id = element.id;
      ItemListTableModel.poDetId = element.poDetId;
      ItemListTableModel.materialId = element.materialId;
      ItemListTableModel.materialName = element.materialName.toString();
      ItemListTableModel.unit = element.unit.toString();
      ItemListTableModel.poQty = element.poQty;
      ItemListTableModel.balQty = element.balQty;
      ItemListTableModel.rate = element.rate;
      ItemListTableModel.inwQty = double.parse(Itemlist_Inward_QtyListController[i].text);
      ItemListTableModel.addQty = double.parse(Itemlist_Qty_PlusListController[i].text);
      ItemListTableModel.lessQty = double.parse(Itemlist_Qty_MinusListController[i].text);
      ItemListTableModel.amdCheck = ischecked![i] == true ? 1 : 0;
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await inwardPending_ItemlistService.InwardPending_ItemlistTable_Update(itemListUpdateModelList);
  }

  RxList<File> imageFiles = <File>[].obs;

  Future Save_EntryScreen(BuildContext context, int id) async {
    buttonControl = 1;
    validatecheck.value.clear();
    ItemGetTableListdata.forEach((element) {
      if (element.amdCheck == 1) {
        validatecheck.add(element);
      }
    });
    if ((validatecheck.isEmpty && !save_checked) || (validatecheck.isNotEmpty && save_checked)) {
      getInwardDetList.value.clear();
      await Future.delayed(const Duration(seconds: 0));
      InwardPendingSaveReq formdata = InwardPendingSaveReq(
        inwardId: id != 0 ? id.toString() : "0",
        inwardNo: InwardAutoyearText.text,
        inwardDate: InwardEntryDateText.text,
        projectId: projectId.toString(),
        siteId: siteId.toString(),
        supplierId: supId.toString(),
        dcNo: InwardDCNoText.text,
        dcDate: InwardDCDateText.text,
        remarks: InwardRemarksText.text,
        preparedby: loginController.EmpId(),
        vehicleNo: InwardVechileNoText.text,
        driverName: InwardDriverNameText.text,
        invNo: InwardInvoiceNoText.text,
        invDate: InwardInvoiceDateText.text,
        id: editvalue == 1
            ? editListApiDatas.value[0].id.toString()
            : inwardAllDatasList[0].id.toString(),
        no: editvalue == 1
            ? editListApiDatas.value[0].no.toString()
            : inwardAllDatasList[0].no.toString(),
        type: editvalue == 1
            ? editListApiDatas.value[0].type.toString()
            : inwardAllDatasList[0].type.toString(),
        purType: editvalue == 1
            ? editListApiDatas.value[0].purType.toString()
            : inwardAllDatasList[0].purType.toString(),
        frieght: InwardFreightChargesText.text,
        loading: "0",
        roff: InwardRoundoffText.text,
        netAmt: InwardNetAmtText.text,
        // image: base64TypeImage.value,
        userId: loginController.UserId(),
        deviceName: BaseUtitiles.deviceName,
        entryMode: saveButton.value == RequestConstant.SUBMIT
            ? "ADD"
            : "UPDATE",
        ChkAmdSave: save_checked == true ? "1" : "0",
        inwardDet: getDetDetails(),
        files: imageFiles,
      );
      // final list = await Inward_Pending_provider.inward_Save(formdata, id, 0);
      final list = await Inward_Pending_provider.inward_Save(
          id, formdata, imageFiles,context);
      if (list != null) {
        if (list == "Inward Qty Should Not Zero(0)... Record Not Saved") {
          Navigator.pop(context);
          buttonControl = 0;
          Fluttertoast.showToast(msg: "0.0 inward qty in list please check once again");
          return;
        }
        else if (list == "Already Entry Made for this InvoiceNo") {
          Navigator.pop(context);
          buttonControl = 0;
          Fluttertoast.showToast(msg: "Already Entry Made for this InvoiceNo");
          return;
        }
        else if (id != 0) {
          buttonControl = 0;
          BaseUtitiles.showToast(list);
          clearDatas();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return;
        }
        else {
          if (list == RequestConstant.DUPLICATE_OCCURED) {
            Navigator.pop(context);
            buttonControl = 0;
            return BaseUtitiles.showToast(list!);
          } else {
            if (InwardTypeText.text == "Against PO") {
              buttonControl = 0;
              clearDatas();
              entryvalue = 2;
              editvalue = 0;
              await pendingListController.getPendingList();
              BaseUtitiles.showToast(list!);
              pendingListController.getSubcontractor_ExpensesList(
                  loginController.UserId(),
                  loginController.UserType(),
                  "INWARD PENDING",
                  context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              return;
            } else {
              buttonControl = 0;
              clearDatas();
              entryvalue = 2;
              editvalue = 0;
              BaseUtitiles.showToast(list!);
              await pendingListController.getPendingList();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              return;
            }
          }
        }
      }
    }
    else {
      buttonControl = 0;
      BaseUtitiles.showToast("Please select a CheckBox");
    }
  }

  List<InwardDet>? getDetDetails() {
    getInwardDetList.value=[];

    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      var qty = double.parse(Itemlist_Inward_QtyListController[index].text);
      var rate = double.parse(ItemGetTableListdata[index].rate.toString());
      if(qty > 0){
        var list = new InwardDet(
          materialId: ItemGetTableListdata[index].materialId.toString(),
          qty: qty.toString(),
          balQty: ItemGetTableListdata[index].balQty.toString(),
          rate: rate.toString(),
          amount: qty * rate,
          purOrdDetId: ItemGetTableListdata[index].poDetId.toString(),
          reqOrdDetId: '0',
          amdCheck: ItemGetTableListdata[index].amdCheck.toString(),
          addQty: Itemlist_Qty_PlusListController[index].text,
          lessQty: Itemlist_Qty_MinusListController[index].text,
        );
        getInwardDetList.add(list);
      }
    }
    return getInwardDetList.value;
  }

  /// ------ PoApproval Approval API --------------

  Future PoAmendment_ApprovalButtonsave(BuildContext context) async {
    await Future.delayed(const Duration(seconds:0));
    String body = poAmendmentApproveResModelToJson(PoAmendmentApproveResModel(
      id: pendingListController.mainlist.value[0].id.toString(),
      preparedby: loginController.EmpId(),
      entryMode: "ADD",
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      inwardDet: getInwardDetAmedment_List.value.length==0
          ? getDetDetailsAmendment()
          : getInwardDetAmedment_List.value,
    ));
    var list = await Inward_Pending_provider.inward_PoAmendment_ApprovalAPI(body,context);
    if(list!=null){
      BaseUtitiles.showToast(list);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
    return list;
  }

  //--------Po Amendment InwardDet List-----------

  List<InwardDetList>? getDetDetailsAmendment() {
    getInwardDetAmedmentList.value=[];
    PoAmdList.value.forEach((element) {
      if(element.isCheck==true){
        var list = new InwardDetList(
          purOrdDetId: element.purOrdDetId.toString(),
          materialId: element.materialid.toString(),
          lessQty: element.balQty.toString(),
        );
        getInwardDetAmedmentList.add(list);
      }
    });
    return getInwardDetAmedmentList.value;
  }

  setCheck(int id,bool value){
    PoAmdList.forEach((element) {
      if(element.materialid==id){
        element.isCheck = value;
      }
    });
  }

  Future<void> EntryList_EditApi(int workid, String type, BuildContext context) async {
    var value = await Inward_Pending_provider.entryListeditAPI(workid, type);
    if (value != null && value.result != null && value.result!.isNotEmpty) {
      entryvalue = 1;
      editvalue = 1;
      editListApiDatas.value = value.result;
      EditTable_SaveTable();
      getItemlistTablesDatas();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Inward_entry()),);
    }
  }


  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((element) {
      element.inwardEditDet.forEach((value) {
        ItemListTableModel = new InwardPendingItemListTableModel();
        ItemListTableModel.materialId = value.materialId;
        ItemListTableModel.materialName = value.materialName.toString();
        ItemListTableModel.poDetId = value.purOrdDetId;
        ItemListTableModel.unit = value.unit.toString();
        ItemListTableModel.poQty = value.poQty;
        ItemListTableModel.balQty = value.balQty;
        ItemListTableModel.rate = value.rate;
        ItemListTableModel.inwQty = value.inwQty;
        ItemListTableModel.addQty = value.addQty;
        ItemListTableModel.lessQty = value.lessQty;
        ItemListTableModel.amdCheck = value.amdCheck;
        ItemListTableModelList.add(ItemListTableModel);
      });
    });
    var savedatas = await inwardPending_ItemlistService.InwardPending_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }

  Future EntryList_DeleteApi(int InwId, String InwNo) async {
    await Inward_Pending_provider.entryList_deleteAPI(InwId, InwNo, loginController.UserId(), BaseUtitiles.deviceName).then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  String ButtonChanges(int id) {
    if (id != 0) {
      return saveButton.value = RequestConstant.RESUBMIT;
    } else {
      return saveButton.value = RequestConstant.SUBMIT;
    }
  }

  Future DeleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
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
                          entryvalue = 0;
                          editvalue = 0;
                          itemlistTable_Delete();
                          ItemGetTableListdata.value.clear();
                          EntryList_DeleteApi(inwardEtyList[index].inwardId, inwardEtyList[index].inwardNo);
                          inwardEtyList.value.removeAt(index);
                          await getInward_EntryList(context);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                            "Delete",
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


  /// Sending multiple images controller.....

  // Future<void> sendMultipleImage (int inWardId,String inWardNo) async{
  //   InwardImageRes inwardImageRes = await Inward_Pending_provider().sendMultipleImageProvider(ImagePayload(
  //     inwardId: inWardId.toString(),
  //     inwardNo: inWardNo,
  //     entryMode: saveButton.value == RequestConstant.SUBMIT ? "ADD" : saveButton.value == RequestConstant.RESUBMIT ? "UPDATE" : "",
  //   ),imageFiles);
  //   if(inwardImageRes.retString != null){
  //     if (kDebugMode) {
  //       print("Successfully upload the images");
  //       print(inwardImageRes.retString.toString());
  //     }
  //   } else {
  //     BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //   }
  // }

  /// Getting image.....

  Future<void> gettingImage() async {
    GettingImage gettingImage = await Inward_Pending_provider().gettingImageProvider(inwardId!);
    gettingNetworkImages = gettingImage.imageView;
    netWorkImageCount.value = gettingImage.imageView.length;
    print("Getting count :: $netWorkImageCount");
    if(gettingNetworkImages!.isNotEmpty){
      checkImgList.value=true;
      gettingNetworkImageList!.clear();
      imageId!.clear();
      for(int i=0 ; i < gettingNetworkImages!.length; i++){
        gettingNetworkImageList!.add(gettingImage.imageView[i].imageUrl.toString());
        imageId!.add(gettingImage.imageView[i].imageId);
      }
    }
  }

  /// Delete image.....

  Future<void> deletingImage(int imageId) async {
    ImageDelete imageDelete = await Inward_Pending_provider().deleteImageProvider(imageId);
    BaseUtitiles.showToast(imageDelete.message.toString());
  }

}
