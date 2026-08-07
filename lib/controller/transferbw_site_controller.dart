import '../app_theme/app_colors.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/transferbet_sitewise_itemlistTable_model.dart';
import '../db_services/transferbet_sitewise_itemlist_service.dart';
import '../home/menu/materials/transfer_between_sites/transferbetween_sites_entry.dart';
import '../home/menu/materials/transfer_between_sites/transferbetween_sites_list.dart';
import '../models/transferbet_site_saveapi_req_model.dart';
import '../provider/common_provider.dart';
import '../provider/transferbetween_site_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logincontroller.dart';

class TransferBt_Site_Controller extends GetxController{

  final TRPEntrylistFrDate = TextEditingController();
  final TRPEntrylistToDate = TextEditingController();
  final autoyrwiseText = TextEditingController();
  final entryDateText = TextEditingController();
  final prearedbyText = TextEditingController();
  final remarksText = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  SubcontractorController subcontractorController=Get.put(SubcontractorController());

  List<TextEditingController> Itemlist_stockQty_ListController = [];
  List<TextEditingController> Itemlist_TransQty_ListController = [];

  List<TextEditingController> Show_Itemlist_stockQtyControllers = [];
  List<TextEditingController> Show_Itemlist_TransQtyController = [];


  int editcheck=0;
  int entrycheck=0;
  int transId=0;
  int checkColor=0;
  int buttonControl = 0;

  RxString type="".obs;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  RxList transferItemListdatas=[].obs;
  RxList mainlist=[].obs;
  RxList entryList=[].obs;
  RxList mainentryList=[].obs;

  RxList getSiteDropdownvalue = [].obs;
  RxList siteDropdownName = [].obs;
  RxList editListApiDatas = [].obs;
  RxInt from_selectedsiteId = 0.obs;
  RxString from_selectedsitedropdownName = "".obs;
  final FromSitename=new TextEditingController();
  final searchcontroller = TextEditingController();
  String? radioValue="transfer_usage";

  late List<TransferBet_Site_ItemListTableModel> ItemListTableModelList = <TransferBet_Site_ItemListTableModel>[];
  var ItemListTableModel = TransferBet_Site_ItemListTableModel();
  var transferSite_ItemlistService = Transferbet_Site_ItemlistService();
  List ItemListTableModelReadList = <TransferBet_Site_ItemListTableModel>[];
  late List<TransferBet_Site_ItemListTableModel> itemListUpdateModelList = <TransferBet_Site_ItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  RxList<TransferDet> getTransfferbetDetList = <TransferDet>[].obs;
  late List<TransferBet_Site_ItemListTableModel> deleteModelList = <TransferBet_Site_ItemListTableModel>[];
  var transqtyvalue = 0;

  // FromSiteName(context, list){
  //   showModalBottomSheet(context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),),
  //     builder: (BuildContext context) {
  //       return Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Container(
  //                 width: BaseUtitiles.getWidthtofPercentage(context, 50),
  //                 margin: EdgeInsets.only(top: 10, left: 15),
  //                 child: TextField(
  //                   controller: searchcontroller,
  //                   decoration: InputDecoration(
  //                     filled: true,
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                       borderSide: BorderSide.none,
  //                     ),
  //                     prefixIcon: const Icon(Icons.search,
  //                       color: Colors.black,
  //                     ),
  //                     hintText: "search..",
  //                     hintStyle: TextStyle(color: Colors.black),
  //                     isDense: true,
  //                     fillColor: Setmybackground,
  //                   ),
  //                   onEditingComplete: () {
  //                     FocusScope.of(context).unfocus();
  //                     // if (onSearch != null) onSearch!(searchcontroller.text);
  //                   },
  //                   textInputAction: TextInputAction.search,
  //                   onChanged: (value) {
  //                     list=BaseUtitiles.sitePopupAlert(value, fromsiteController.getSiteDropdownvalue.value);
  //                   },
  //                 ),
  //               ),
  //               SizedBox(width: 20),
  //               Container(
  //                 width: BaseUtitiles.getWidthtofPercentage(context, 25),
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(width: 2, color: Theme.of(context).primaryColor),
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.all(3),
  //                   child: Text("From Sites", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
  //                 ),
  //               ),
  //               InkWell(
  //                   onTap: (){
  //                     Navigator.pop(context);
  //                     searchcontroller.text = "";
  //                   },
  //                   child: Container(
  //                       margin: EdgeInsets.only(right: 10),
  //                       child: Icon(Icons.expand_circle_down, color: Theme.of(context).primaryColor))),
  //             ],
  //           ),
  //           Divider(),
  //           Expanded(
  //             child: ListView.builder(
  //               padding: EdgeInsets.zero,
  //               physics: BouncingScrollPhysics(),
  //               itemCount: list.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return Column(
  //                   children: [
  //                     InkWell(
  //                       child: Container(
  //                         margin: EdgeInsets.only(left: 10),
  //                         alignment: Alignment.center,
  //                         child: Text(list[index].siteName
  //                             .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),),
  //                       ),
  //                       onTap: () async {
  //                         fromsiteController.FromSitename.text = list[index].siteName.toString();
  //                         fromsiteController.selectedsiteId.value = list[index].siteId;
  //                         await siteController.subcontEntry_siteDropdowntList(context,0);
  //                         searchcontroller.text = "";
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                     Divider(),
  //                   ],
  //                 );
  //               }, ),
  //           )
  //         ],
  //       );
  //     },);
  // }

  Future from_siteDropdowntList(BuildContext context) async {
    getSiteDropdownvalue.value = await CommonProvider.getSiteDropdown(projectController.selectedProjectId.value);
    getSiteDropdownvalue.value.forEach((element) {
      return siteDropdownName.add(element.siteName);
    });
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return SitefromPopup(list:getSiteDropdownvalue.value);
    //     });
  }

  Future deleteParticularList(TransferBet_Site_ItemListTableModel data) async {
    deleteModelList=[];
    ItemListTableModel = new TransferBet_Site_ItemListTableModel();
    ItemListTableModel.materialId = data.materialId;
    deleteModelList.add(ItemListTableModel);
    await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_deleteById(deleteModelList);

  }

  setSelectedSiteID(String value) {
    if (getSiteDropdownvalue.value.length>0) {
      getSiteDropdownvalue.forEach((element) {
        if(value == element.siteName){
          from_selectedsiteId(element.siteId);
        }
      });
    }
    setSelectedMRNListName(from_selectedsiteId.value);
  }

  setSelectedMRNListName(int? id) {
    if (getSiteDropdownvalue.value != null) {
      getSiteDropdownvalue.value.forEach((element) {
        if (id == element.siteId) {
          from_selectedsitedropdownName(element.siteName.toString());
        }
      });
    }
    FromSitename.text=from_selectedsitedropdownName.value;
  }


  From_SiteName(context, list){
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
                      list=BaseUtitiles.sitePopupAlert(value, getSiteDropdownvalue.value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text("From Sites", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
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
                          child: Text(list[index].siteName
                              .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),),
                        ),
                        onTap: () async {
                          FromSitename.text = list[index].siteName.toString();
                          from_selectedsiteId.value = list[index].siteId;
                          await siteController.subcontEntry_siteDropdowntList(context,0);
                          searchcontroller.text = "";
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
      },);
  }

  Future getItemList(int prid,int siteId,int reqId,String type) async {
    transferItemListdatas.value.clear();
    await TransferBetSiteProvider.getItemList(prid,siteId,reqId,type)
        .then((value) async {
      if (value != null && value.length > 0) {
        transferItemListdatas.value = value;
        return transferItemListdatas.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  itemlist_textControllersInitiate() {
    Itemlist_stockQty_ListController.add(new TextEditingController());
    Itemlist_TransQty_ListController.add(new TextEditingController());
    Show_Itemlist_stockQtyControllers.add(new TextEditingController());
    Show_Itemlist_TransQtyController.add(new TextEditingController());
  }


  itemlistTable_Delete() async {
    await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_delete();
  }

  itemlistPopup_saveLabTableDatas(BuildContext context) async {
    int i = 0;
    int j=0;
    ItemListTableModelList.clear();
    transferItemListdatas.value.forEach((element) {
      if(element.check==true){
        ItemListTableModel = new TransferBet_Site_ItemListTableModel();
        ItemListTableModel.materialId = element.materialId;
        ItemListTableModel.materialName = element.material.toString();
        ItemListTableModel.scale = element.scale.toString();
        ItemListTableModel.stockQty = element.stockQty;
        ItemListTableModel.balQty = element.balQty;
        ItemListTableModel.Qty = double.parse("0");
        ItemListTableModel.reqDetId = element.reqDetId;
        ItemGetTableListdata.value.forEach((element) {
          if(element.materialId ==ItemListTableModel.materialId){
            j=1;
            BaseUtitiles.showToast("Entries already exist");
          }
        });
        if(j==0){
          ItemListTableModelList.add(ItemListTableModel);
        }
        else{
          j=0;
        }

      }
      i++;
    });
    var savedatas = await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_Save(ItemListTableModelList);
    return Navigator.pop(context, savedatas);
  }



  Future getItemlistTablesDatas() async {
    var datas = await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_readAll();
    ItemListTableModelReadList = <TransferBet_Site_ItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new TransferBet_Site_ItemListTableModel();
      itemlist_textControllersInitiate();
      ItemListTableModel.id = value['id'];
      ItemListTableModel.materialId = value['materialId'];
      ItemListTableModel.materialName = value['materialName'];
      ItemListTableModel.scale = value ['scale'];
      ItemListTableModel.stockQty = value ['stockQty'];
      ItemListTableModel.balQty = value ['balQty'];
      ItemListTableModel.Qty = value ['Qty'] ;
      ItemListTableModel.reqDetId = value ['reqDetId'];
      ItemListTableModel.rate = value ['rate'];
      ItemListTableModel.amount = value ['amount'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      itemlist_textControllersInitiate();
      Itemlist_stockQty_ListController[i].text=datas.stockQty.toString();
      Itemlist_TransQty_ListController[i].text=datas.Qty.toString();
      i++;
    });
  }

  // ConsumItemlist_clickEdit() {
  //   for (var index = 0; index < ItemGetTableListdata.value.length; index++) {
  //     if (Itemlist_TransQty_ListController[index].text == "0"||Itemlist_TransQty_ListController[index].text == "0.0") {
  //
  //       BaseUtitiles.showToast("Zero is not allowed please change the value");
  //
  //     } else {
  //       if(double.parse(Itemlist_TransQty_ListController[index].text) > double.parse(Itemlist_stockQty_ListController[index].text)){
  //         BaseUtitiles.showToast("Please enter less than of Stock Qty");
  //       }
  //       else{
  //         updateItemlistTable();
  //       }
  //     }
  //   }
  // }


  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      itemlist_textControllersInitiate();
      if (Itemlist_TransQty_ListController[i].text == "0"||Itemlist_TransQty_ListController[i].text == "0.0") {
        Itemlist_TransQty_ListController[i].text="0.0";
        BaseUtitiles.showToast("Zero is not allowed please change the value");
      }else if(double.parse(Itemlist_TransQty_ListController[i].text) > double.parse(Itemlist_stockQty_ListController[i].text)){
        Itemlist_TransQty_ListController[i].text = "0.0";
        BaseUtitiles.showToast("Please enter less than of Stock Qty");
      }
      else{
        ItemListTableModel = new TransferBet_Site_ItemListTableModel();
        ItemListTableModel.id = element.id;
        ItemListTableModel.materialId = element.materialId;
        ItemListTableModel.materialName = element.materialName.toString();
        ItemListTableModel.balQty = element.balQty;
        ItemListTableModel.scale = element.scale;
        ItemListTableModel.stockQty = element.stockQty;
        ItemListTableModel.Qty = double.parse(Itemlist_TransQty_ListController[i].text) ;
        ItemListTableModel.reqDetId = element.reqDetId;
        itemListUpdateModelList.add(ItemListTableModel);
      }
      i++;
    });
    await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_Update(itemListUpdateModelList);
  }


  Future Save_EntryScreen(BuildContext context,int id) async {
    buttonControl = 1;
    await getItemlistTablesDatas();
    getTransfferbetDetList.value.clear();
    String body = transferbetSiteSaveApiReqToJson(TransferbetSiteSaveApiReq(
      transferId: id != 0 ? id.toString() : "0",
      transferNo: autoyrwiseText.text,
      transferDate: entryDateText.text,
      frProjectId: projectController.selectedProjectId.value.toString(),
      frSiteId: from_selectedsiteId.value.toString(),
      toSiteId: siteController.selectedsiteId.value.toString(),
      subContId: subcontractorController.selectedSubcontId.value.toString(),
      transType: radioValue == "transfer_usage" ? "0" : "1",
      remarks: remarksText.text,
      preparedby: loginController.EmpId(),
      preparedbyName: loginController.EmpName(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode: saveButton.value == "Submit" ? "ADD" : saveButton.value ==
          "Re-Submit" ? "UPDATE" : saveButton.value == "Verify"
          ? "VERIFY"
          : saveButton.value == "Approve" ? "APPROVE" : "",
      transferDet: getTransfferbetDetList.value.length == 0
          ? getDetDetails()
          : getTransfferbetDetList.value,
    ));
    final list = await TransferBetSiteProvider.transferbet_Site_SaveApi(
        body, id, context);
    if (list != null) {
      if (id != 0) {
        buttonControl = 0;
        BaseUtitiles.showToast(list);
        await getEntryList();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context) =>
            new TransferBetweenSites_Entrylist()));
        return Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   new MaterialPageRoute(
        //       builder: (BuildContext context) =>
        //       new Transfer_Between_Sites(2)));
      }
      else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          buttonControl = 0;
          Navigator.pop(context);
          Navigator.pop(context);
          return BaseUtitiles.showToast(list);
        } else {
          buttonControl = 0;
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          BaseUtitiles.showToast(list);
          await getEntryList();
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new TransferBetweenSites_Entrylist()));
          return Navigator.pop(context);

          // Navigator.pushReplacement(
          //   context,
          //   new MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //       new Transfer_Between_Sites(2)));
        }
      }
    }
  }

  List<TransferDet>? getDetDetails() {
    getTransfferbetDetList.value.clear();
    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      var list = new TransferDet(
        materialId:ItemGetTableListdata[index].materialId.toString(),
        qty:ItemGetTableListdata[index].Qty.toString(),
        rate:"0",
        amount:"0",
      );
      getTransfferbetDetList.add(list);
    }
    return getTransfferbetDetList.value;
  }

  itemlistpopupInitiatevalue(){
    int i=0;
    transferItemListdatas.value.forEach((element) {
      itemlist_textControllersInitiate();
      Show_Itemlist_stockQtyControllers[i].text=element.stockQty.toString();
      Show_Itemlist_TransQtyController[i].text="0.0";
      i++;
    });
  }


  Future getEntryList() async {
    mainentryList.value.clear();
    entryList.value.clear();
    await TransferBetSiteProvider.get_Entry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        TRPEntrylistFrDate.text,
        TRPEntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainentryList.value = value;
        entryList.value = mainentryList.value;
        return mainentryList.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future EntryList_EditApi(int workid,BuildContext context) async {
    await TransferBetSiteProvider.entryList_editAPI(workid).then((value) async {
      if (value != null && value.length > 0) {
        editcheck = 1;
        editListApiDatas.value = value;
        EditTable_SaveTable();
        getItemlistTablesDatas();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TransferBetweenSites_Entry()),
        );
      }
    });
  }

  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((value) {
      value.transferEditDet.forEach((element) {
        ItemListTableModel = new TransferBet_Site_ItemListTableModel();
        ItemListTableModel.materialId = element.materialId;
        ItemListTableModel.materialName = element.materialName.toString();
        ItemListTableModel.stockQty = element.stockQty;
        ItemListTableModel.scale = element.unit;
        // ItemListTableModel.balQty = element.balQty;
        ItemListTableModel.Qty = element.qty;
        ItemListTableModelList.add(ItemListTableModel);
      });
    });
    var savedatas = await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }

  Future EntryList_DeleteApi(int InwId,String InwNo) async {
    await TransferBetSiteProvider.entryList_deleteAPI(InwId,InwNo,loginController.UserId(),BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  String ButtonChanges(int id){
    if(id!=0)
      return saveButton.value=RequestConstant.RESUBMIT;
    else
      return saveButton.value=RequestConstant.SUBMIT;
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
                          EntryList_DeleteApi(entryList[index].transferId,entryList[index].transferNo);
                          entryList.removeAt(index);
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