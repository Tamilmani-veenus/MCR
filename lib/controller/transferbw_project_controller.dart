import '../controller/fromproject_ccontroller.dart';
import '../controller/fromsite_controller.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../db_model/transbet_itemlistTable_model.dart';
import '../db_services/transferbet_itemlist_service.dart';
import '../home/menu/materials/transfer_between_projects/transfer_between_project_itemlist.dart';
import '../home/menu/materials/transfer_between_projects/transferbetween_projects_entry.dart';
import '../home/menu/materials/transfer_between_projects/transferbetween_projects_list.dart';
import '../home/pending_list/pending_list.dart';
import '../models/transferbet_save_apireq_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../provider/transferbetweenproject_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class TransferBW_project_Controller extends GetxController {
  final TRPEntrylistFrDate = TextEditingController();
  final TRPEntrylistToDate = TextEditingController();

  final autoyrwiseText = TextEditingController();
  final entryDateText = TextEditingController();
  final transferTypeText = TextEditingController();
  final ReqordNoText = TextEditingController();
  final appNoText = TextEditingController();
  final prearedbyText = TextEditingController();
  final vechicleNoText = TextEditingController();
  final driverNameText = TextEditingController();
  final dcNoText = TextEditingController();
  final transportCostText = TextEditingController();
  final remarksText = TextEditingController();
  double totAmtText = 0.0;

  List<TextEditingController> Itemlist_stockQty_ListController = [];
  List<TextEditingController> Itemlist_TransQty_ListController = [];
  List<TextEditingController> Itemlist_balQty_ListControllers = [];
  List<TextEditingController> Itemlist_Rate_ListController = [];
  List<TextEditingController> Itemlist_Amt_ListController = [];

  List<TextEditingController> Show_Itemlist_stockQtyControllers = [];
  List<TextEditingController> Show_Itemlist_TransQtyController = [];
  List<TextEditingController> Show_Itemlist_RateController = [];
  List<TextEditingController> Show_Itemlist_AmtController = [];

  final toprojectname = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  FromProjectController fromprojectController = Get.put(FromProjectController());
  FromSiteController fromsiteController = Get.put(FromSiteController());
  ProjectController projectController = Get.put(ProjectController());
  PendingListController pendingListController=Get.put(PendingListController());

  RxList transferAllDatasList = [].obs;
  RxList transferItemListdatas = [].obs;
  RxList mainlist=[].obs;
  RxList TRPEtyList = [].obs;
  RxList mainEntrylist = [].obs;
  RxInt selectedFrProjectId = 0.obs;
  RxString selectedFrProjectName = "".obs;


  late List<TransferBetItemListTableModel> ItemListTableModelList =
  <TransferBetItemListTableModel>[];
  var ItemListTableModel = TransferBetItemListTableModel();
  var transfer_ItemlistService = Transferbet_ItemlistService();
  List ItemListTableModelReadList = <TransferBetItemListTableModel>[];
  late List<TransferBetItemListTableModel> itemListUpdateModelList =
  <TransferBetItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  RxList<TransferDet> getTransfferbetDetList = <TransferDet>[].obs;
  RxList editListApiDatas = [].obs;

  int editcheck = 0;
  int entrycheck = 0;
  int checkColor = 0;
  int buttonControl = 0;

  int transferId = 0;
  RxString type = "".obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;

  clearDatas() {
    transferId = 0;
    entryDateText.text = BaseUtitiles.initiateCurrentDateFormat();
    prearedbyText.text = loginController.UserName();
    projectController.projectnameAll.text = "--SELECT--";
    projectController.selectedProjectIdAll.value = 0;
    fromprojectController.fromprojectname.text = "--SELECT--";
    fromprojectController.selectedProjectId = 0.obs;
    fromsiteController.selectedsiteId = 0.obs;
    fromsiteController.FromSitename.text = "--SELECT--";
    vechicleNoText.text = "";
    driverNameText.text = "";
    dcNoText.text = "";
    transportCostText.text = "0.0";
    remarksText.text = "";
  }

  Future getTransferProject_Alldatas(int reqId, BuildContext context) async {
    transferAllDatasList.value=[];
    transferItemListdatas.value=[];
    await TransferBetweenProject_provider.getTransferProj_ALLDatas(reqId).then((value) async {
      if (value != null && value.length > 0) {
        transferAllDatasList.value = value;
        editcheck = 0;
        entrycheck = 0;
        FocusScope.of(context).unfocus();
        type.value="Against Approval";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TrasferBetweenProjects_Entry()));
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future getTransproject_EntryList() async {
    mainEntrylist.value.clear();
    TRPEtyList.value.clear();
    await TransferBetweenProject_provider.getTransprojectEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        TRPEntrylistFrDate.text,
        TRPEntrylistToDate.text).then((value) async {
      if (value != null && value.length > 0) {
        mainEntrylist.value = value;
        TRPEtyList.value = mainEntrylist.value;
        return mainEntrylist.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future getTransproject_ItemList(int prid, int siteId, int reqId, String typ, BuildContext context) async {
    mainlist.value=[];
    transferItemListdatas.value=[];
    await TransferBetweenProject_provider.getItemList(prid, siteId, reqId, typ).then((value) async {
      if (value != null && value.length > 0) {
        transferItemListdatas.value = value;
        print("ssss...${transferItemListdatas.value.length}");
        type == "Direct" ?
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Transfer_Between_Project_ItemList()))
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AddItemPopup();
        //     })
            : Container();
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  itemlistTable_Delete() async {
    await transfer_ItemlistService.Transferbet_ItemlistTable_delete();
  }

  itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    transferItemListdatas.value.forEach((element) {
      // if(element.stockQty> 0.0){
        ItemListTableModel = new TransferBetItemListTableModel();
        ItemListTableModel.materialId = element.materialId;
        ItemListTableModel.materialName = element.material.toString();
        ItemListTableModel.scale = element.scale.toString();
        ItemListTableModel.stockQty = element.stockQty;
        ItemListTableModel.balQty = element.balQty;
        ItemListTableModel.Qty = 0.0;
        ItemListTableModel.reqDetId = element.reqDetId;
        ItemListTableModel.rate = 0.0;
        ItemListTableModel.amount = 0.0;
        ItemListTableModelList.add(ItemListTableModel);
      // }
    });
    var savedatas = await transfer_ItemlistService.Transferbet_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {
    var datas = await transfer_ItemlistService.Transferbet_ItemlistTable_readAll();
    ItemListTableModelReadList = <TransferBetItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new TransferBetItemListTableModel();
      itemlist_textControllersInitiate();
      ItemListTableModel.id = value['id'];
      ItemListTableModel.materialId = value['materialId'];
      ItemListTableModel.materialName = value['materialName'];
      ItemListTableModel.scale = value['scale'];
      ItemListTableModel.stockQty = value['stockQty'];
      ItemListTableModel.balQty = value['balQty'];
      ItemListTableModel.Qty = value['Qty'];
      ItemListTableModel.reqDetId = value['reqDetId'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  itemlist_textControllersInitiate() {
    Itemlist_stockQty_ListController.add(new TextEditingController());
    Itemlist_balQty_ListControllers.add(new TextEditingController());
    Itemlist_TransQty_ListController.add(new TextEditingController());
    Itemlist_Rate_ListController.add(new TextEditingController());
    Itemlist_Amt_ListController.add(new TextEditingController());

    Show_Itemlist_stockQtyControllers.add(new TextEditingController());
    Show_Itemlist_TransQtyController.add(new TextEditingController());
    Show_Itemlist_RateController.add(new TextEditingController());
    Show_Itemlist_AmtController.add(new TextEditingController());
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      itemlist_textControllersInitiate();
      Itemlist_stockQty_ListController[i].text = datas.stockQty.toString();
      Itemlist_TransQty_ListController[i].text = datas.Qty.toString();
      Itemlist_balQty_ListControllers[i].text = datas.balQty.toString();
      Itemlist_Rate_ListController[i].text = datas.rate.toString();
      Itemlist_Amt_ListController[i].text = datas.amount.toString();
      i++;
    });
  }

  ItemListEdit() {
    print("eeeeeeee");
    for (var index = 0; index < ItemGetTableListdata.length; index++) {
      if (Itemlist_Rate_ListController[index].value.text == "") {
      } else {
        // if(type.value=="Direct"){
        //   if(double.parse(Itemlist_TransQty_ListController[index].text)<=ItemGetTableListdata[index].stockQty){
        //     Itemlist_Amt_ListController[index].text = ((double.parse(Itemlist_Rate_ListController[index].text)*double.parse(Itemlist_TransQty_ListController[index].text)).toString());
        //   }
        //   else{
        //     Itemlist_TransQty_ListController[index].text="0.0";
        //     Itemlist_Amt_ListController[index].text="0.0";
        //   }
        //
        // }
        // else{
        //   Itemlist_Amt_ListController[index].text = (double.parse(Itemlist_Rate_ListController[index].text)*ItemGetTableListdata[index].balQty).toString();
        // }
        if (double.parse(Itemlist_TransQty_ListController[index].text) <= ItemGetTableListdata[index].balQty && double.parse(Itemlist_TransQty_ListController[index].text) <= ItemGetTableListdata[index].stockQty ) {
          Itemlist_Amt_ListController[index].text = ((double.parse(Itemlist_Rate_ListController[index].text) * double.parse(Itemlist_TransQty_ListController[index].text)).toString());
        } else {
          BaseUtitiles.showToast("Transfer qty should not exceed stock and balance qty");
          Itemlist_TransQty_ListController[index].text = "0.0";
          Itemlist_Amt_ListController[index].text = "0.0";
        }
        totAmtText = double.parse(Itemlist_Amt_ListController[index].text) + double.parse(transportCostText.text);
        print("TotatAmt :: $totAmtText");
      }
    }
    updateItemlistTable();
  }

  var transqtyvalue = 0;


  ItemListclickEdit() {
    bool isToastDisplayed = false;
    for (var index = 0; index < ItemGetTableListdata.length; index++) {
      if (Itemlist_Rate_ListController[index].value.text == "") {
      } else {
        // if(type.value=="Direct"){
        //   if(double.parse(Itemlist_TransQty_ListController[index].text)<=ItemGetTableListdata[index].stockQty){
        //     Itemlist_Amt_ListController[index].text = ((double.parse(Itemlist_Rate_ListController[index].text)*double.parse(Itemlist_TransQty_ListController[index].text)).toString());
        //   }
        //   else{
        //     Itemlist_TransQty_ListController[index].text="0.0";
        //     Itemlist_Amt_ListController[index].text="0.0";
        //   }
        //
        // }
        // else{
        //   Itemlist_Amt_ListController[index].text = (double.parse(Itemlist_Rate_ListController[index].text)*ItemGetTableListdata[index].balQty).toString();
        // }

        if (type.value == "Against Approval") {
          double? transferQty = double.tryParse(Itemlist_TransQty_ListController[index].text);
          transferQty = double.parse(transferQty!.toStringAsFixed(2));
          if (ItemGetTableListdata[index].stockQty > ItemGetTableListdata[index].balQty) {
            if (!isToastDisplayed && transferQty != null && transferQty > ItemGetTableListdata[index].balQty) {
              BaseUtitiles.showToast('Transfer qty is greater than bal qty');
              Itemlist_TransQty_ListController[index].text = "0.0";
              isToastDisplayed = true;
            }else{
              transqtyvalue = 1;
              print('transqtyvalue1 :: $transqtyvalue');
            }
          } else if (ItemGetTableListdata[index].balQty > ItemGetTableListdata[index].stockQty) {
            if (!isToastDisplayed && transferQty != null && transferQty > ItemGetTableListdata[index].stockQty) {
              BaseUtitiles.showToast('Transfer qty is greater than stock qty');
              Itemlist_TransQty_ListController[index].text = "0.0";
              isToastDisplayed = true;
            } else {
              transqtyvalue = 2;
              print('transqtyvalue2 :: $transqtyvalue');
            }
          } else {
            transqtyvalue = 3;
            print('transqtyvalue3 :: $transqtyvalue');
          }
        }

        //   if(type.value == "Against MRN Approval"){
        //     if(ItemGetTableListdata[index].stockQty > ItemGetTableListdata[index].balQty){
        //       transqtyvalue = 1;
        //       if( ItemGetTableListdata[index].balQty < double.tryParse(Itemlist_TransQty_ListController[index].text)){
        //         BaseUtitiles.showToast('Transfer qty is greater then of bal qty');
        //       }
        //       print('transqtyvalue1 :: $transqtyvalue');
        //     }else if(ItemGetTableListdata[index].balQty > ItemGetTableListdata[index].stockQty){
        //       transqtyvalue = 2;
        //       if( ItemGetTableListdata[index].stockQty < double.tryParse(Itemlist_TransQty_ListController[index].text) ){
        //         BaseUtitiles.showToast('Transfer qty is greater then of stock qty');
        //       }
        //       print('transqtyvalue2 :: $transqtyvalue');
        //     }else{
        //       transqtyvalue = 3;
        //       print('transqtyvalue3 :: $transqtyvalue');
        //     }
        // }

        if (double.parse(Itemlist_TransQty_ListController[index].text) <= ItemGetTableListdata[index].stockQty) {
          Itemlist_Amt_ListController[index].text = ((double.parse(Itemlist_Rate_ListController[index].text) * double.parse(Itemlist_TransQty_ListController[index].text)).toString());
        } else {
          BaseUtitiles.showToast('Transfer qty is greater than stock qty');
          Itemlist_TransQty_ListController[index].text = "0.0";
          Itemlist_Amt_ListController[index].text = "0.0";
        }
        totAmtText = double.parse(Itemlist_Amt_ListController[index].text) * double.parse(transportCostText.text);
      }
    }
    updateItemlistTable();
  }

  popupChaneEdit(String value) {
    int i = 0;
    mainlist.forEach((element) {
      itemlist_textControllersInitiate();
      if (double.parse(Show_Itemlist_TransQtyController[i].text) <=
          element.stockQty) {
        Show_Itemlist_AmtController[i].text =
        ((double.parse(Show_Itemlist_RateController[i].text) *
            double.parse(Show_Itemlist_TransQtyController[i].text))
            .toString());
      } else {
        Show_Itemlist_TransQtyController[i].text = "0.0";
        Show_Itemlist_AmtController[i].text = "0.0";
      }
      i++;
    });
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      itemlist_textControllersInitiate();
      ItemListTableModel = new TransferBetItemListTableModel();
      ItemListTableModel.id = element.id;
      ItemListTableModel.materialId = element.materialId;
      ItemListTableModel.materialName = element.materialName.toString();
      ItemListTableModel.balQty = element.balQty;
      ItemListTableModel.scale = element.scale;
      ItemListTableModel.stockQty = element.stockQty;
      ItemListTableModel.Qty = double.parse(Itemlist_TransQty_ListController[i].text);
      ItemListTableModel.reqDetId = element.reqDetId;
      ItemListTableModel.rate =
          double.parse(Itemlist_Rate_ListController[i].text);
      ItemListTableModel.amount =
          double.parse(Itemlist_Amt_ListController[i].text);
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await transfer_ItemlistService.Transferbet_ItemlistTable_Update(
        itemListUpdateModelList);
  }


  Future Save_EntryScreen(BuildContext context, int id) async {
    buttonControl=1;
    getTransfferbetDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = transferbetSaveApiReqToJson(TransferbetSaveApiReq(
      transferId: id != 0 ? id.toString() : "0",
      transferNo: autoyrwiseText.text,
      transferDate: entryDateText.text,
      frProjectId: fromprojectController.selectedProjectId.value.toString(),
      frSiteId: fromsiteController.selectedsiteId.value.toString(),
      toProjectId: projectController.selectedProjectIdAll.value.toString(),
      transType: type == "Direct" ? "D" : "A",
      reqId: type == "Direct"
          ? "0" : (type == "Against Approval" && transferAllDatasList.value.length !=0)
          ? transferAllDatasList.value[0].reqMasId.toString() : editListApiDatas.value[0].reqId.toString(),
      reqAppId:  "0",
      vechileNo: vechicleNoText.text,
      driverName: driverNameText.text,
      transAmt: transportCostText.text,
      totAmt: totAmtText.toString(),
      dcNo: dcNoText.text,
      remarks: remarksText.text,
      preparedby: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode:saveButton.value=="Submit"?"ADD":saveButton.value=="Re-Submit"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
      transferDet: getTransfferbetDetList.value.length == 0
          ? getDetDetails()
          : getTransfferbetDetList.value,
    ));
    final list = await TransferBetweenProject_provider.transferbet_SaveApi(body, id, context);
    if (list != null) {
      if (id != 0) {
        entrycheck = 2;
        buttonControl = 0;
        clearDatas();
        itemlistTable_Delete();
        ItemGetTableListdata.clear();
        BaseUtitiles.showToast(list);
        Navigator.pop(context);
        Navigator.pop(context);
        await getTransproject_EntryList();
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                new TransferBtweenProjects_Entrylist()));
        return Navigator.pop(context);
      }
      else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          buttonControl = 0;
          Navigator.pop(context);
          Navigator.pop(context);
          return BaseUtitiles.showToast(list);
        } else {
          entrycheck = 2;
          buttonControl = 0;
          clearDatas();
          itemlistTable_Delete();
          ItemGetTableListdata.clear();
          BaseUtitiles.showToast(list);

          if (type != "Direct") {
            buttonControl = 0;
            await pendingListController.getPendingList();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            // await getTransproject_EntryList();
            // Navigator.pushReplacement(
            //     context,
            //     new MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //         new TransferBtweenProjects_Entrylist()));
            // await pendingListController.getPendingList();
          }
          else {
            buttonControl = 0;
            Navigator.pop(context);
            Navigator.pop(context);
            await getTransproject_EntryList();
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new TransferBtweenProjects_Entrylist()));
            return Navigator.pop(context);
          }
        }
      }
    }
  }

  List<TransferDet>? getDetDetails() {
    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      var list = new TransferDet(
        materialId: ItemGetTableListdata[index].materialId.toString(),
        stockQty: ItemGetTableListdata[index].stockQty.toString(),
        qty: ItemGetTableListdata[index].Qty.toString(),
        rate: ItemGetTableListdata[index].rate.toString(),
        amount: ItemGetTableListdata[index].amount.toString(),
        reqDetId: type == "Direct" ? "0" : ItemGetTableListdata[index].reqDetId.toString(),
      );
      getTransfferbetDetList.add(list);
    }
    return getTransfferbetDetList.value;
  }

  Future EntryList_EditApi(int workid, BuildContext context) async {
    await TransferBetweenProject_provider.entryList_editAPI(workid).then((value) async {
      if (value != null && value.length > 0) {
        editcheck = 1;
        transferAllDatasList.value=[];
        editListApiDatas.value = value;
        EditTable_SaveTable();
        getItemlistTablesDatas();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TrasferBetweenProjects_Entry()),
        );
      }
    });
  }

  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((element) {
      element.transferEditDet.forEach((value) {
        ItemListTableModel = new TransferBetItemListTableModel();
        ItemListTableModel.materialId = value.materialId;
        ItemListTableModel.materialName = value.materialName.toString();
        ItemListTableModel.stockQty = value.stockQty;
        ItemListTableModel.balQty = value.balQty;
        ItemListTableModel.scale = value.unit;
        ItemListTableModel.Qty = value.qty;
        ItemListTableModel.amount = value.amount;
        ItemListTableModel.rate = value.rate;
        ItemListTableModel.reqDetId = value.reqDetId;
        ItemListTableModelList.add(ItemListTableModel);
      });
    });
    var savedatas =
    await transfer_ItemlistService.Transferbet_ItemlistTable_Save(
        ItemListTableModelList);
    return savedatas;
  }

  Future EntryList_DeleteApi(int InwId, String InwNo) async {
    await TransferBetweenProject_provider.entryList_deleteAPI(
        InwId, InwNo, loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  String ButtonChanges(int id) {
    if (id != 0)
      return saveButton.value = RequestConstant.RESUBMIT;
    else
      return saveButton.value = RequestConstant.SUBMIT;
  }

  itemlistpopupInitiatevalue() {
    int i = 0;
    mainlist.value.forEach((element) {
      itemlist_textControllersInitiate();
      Show_Itemlist_stockQtyControllers[i].text = element.stockQty.toString();
      Show_Itemlist_TransQtyController[i].text = "0.0";
      Show_Itemlist_RateController[i].text = "0.0";
      Show_Itemlist_AmtController[i].text = "0.0";
      i++;
    });
  }

  itemlistPopup_saveLabTableDatas(BuildContext context) async {

    int j =0;

    ItemListTableModelList.clear();
    transferItemListdatas.value.forEach((element) {
      if(element.check==true){
        ItemListTableModel = new TransferBetItemListTableModel();
        ItemListTableModel.materialId = element.materialId;
        ItemListTableModel.materialName = element.material.toString();
        ItemListTableModel.scale = element.scale.toString();
        ItemListTableModel.stockQty = element.stockQty;
        ItemListTableModel.balQty = element.balQty.toDouble();
        ItemListTableModel.Qty = 0.0;
        ItemListTableModel.reqDetId = element.reqDetId;
        ItemListTableModel.rate = 0.0;
        ItemListTableModel.amount = 0.0;
        ItemGetTableListdata.value.forEach((element) {
          if (element.materialId == ItemListTableModel.materialId) {
            j = 1;
            BaseUtitiles.showToast("Entries already exist");
          }
        });
        if (j == 0) {
          ItemListTableModelList.add(ItemListTableModel);
        } else {
          j = 0;
        }
      }
    });
    var savedatas = await transfer_ItemlistService.Transferbet_ItemlistTable_Save(ItemListTableModelList);
    return Navigator.pop(context, savedatas);
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
                          entrycheck=0;
                          editcheck=0;
                          itemlistTable_Delete();
                          ItemGetTableListdata.clear();
                          EntryList_DeleteApi(TRPEtyList[index].transferId,TRPEtyList[index].transferNo);
                          TRPEtyList.removeAt(index);
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
          //     entrycheck=0;
          //     editcheck=0;
          //     itemlistTable_Delete();
          //     ItemGetTableListdata.clear();
          //     EntryList_DeleteApi(TRPEtyList[index].transferId,TRPEtyList[index].transferNo);
          //     TRPEtyList.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }

  setCheck(int id,bool value){
    transferItemListdatas.value.forEach((element) {
      if(element.materialId==id){
        element.check = value;
      }
    });
  }

  serachsetCheck(int id,bool value){
    mainlist.forEach((element) {
      if(element.materialId==id){
        element.check = value;
      }
    });
  }
}
