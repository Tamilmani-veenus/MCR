import '../app_theme/app_colors.dart';
import '../controller/logincontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../db_services/transfer_ackdet_service.dart';
import '../home/pending_list/transferacknowledgement_pendinglist/transferacknow_entrylistscreen.dart';
import '../home/pending_list/transferacknowledgement_pendinglist/transferacknow_entryscreen.dart';
import '../provider/pendinglist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_model/transfer_ackdet_tablemodel.dart';
import '../models/transfer_ackentryscreen_savereqapi.dart';
import '../provider/common_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class TransferAcknowledgmentPendingController extends GetxController{
  final entryDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final aknowldge_numberController = TextEditingController();
  final fromProjectController = TextEditingController();
  final toprojectController = TextEditingController();

  final entrylist_fromDate = TextEditingController();
  final entrylist_toDate = TextEditingController();

  LoginController loginController=Get.put(LoginController());
  PendingListController pendingListController=Get.put(PendingListController());

  List<TextEditingController> transferQtyListController = [];
  List<TextEditingController> ackQtyListController = [];
  List<TextEditingController> detremarksListController = [];


  int frProjectID=0;
  int toProjectId=0;
  int editcheck=0;
  int entrycheck=0;
  int ackno=0;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  int checkitemlist = 0;

  RxList transferAlldatas=[].obs;
  RxList entrylistDatas=[].obs;
  RxList mainentrylist=[].obs;
  RxList editlistDatas=[].obs;
  RxList<TransferAckDet> getTransferDetList = <TransferAckDet>[].obs;


  List transferAckDetReadList = <TransferAckDetTableModel>[];
  RxList readListdata = [].obs;
  late List<TransferAckDetTableModel> deleteModelList = <TransferAckDetTableModel>[];
  late List<TransferAckDetTableModel> transferDetModelList = <TransferAckDetTableModel>[];
  late List<TransferAckDetTableModel> UpdateModelList = <TransferAckDetTableModel>[];
  var transferAckDetService = TransferAck_DetService();
  var transferAckDetModel = TransferAckDetTableModel();

  RxList getSiteDropdownvalue = [].obs;
  RxList mainlist=[].obs;
  RxList siteDropdownName = [].obs;
  RxInt toSiteid = 0.obs;
  RxString toSiteName = "".obs;
  final toSitename=new TextEditingController();


  Future to_siteDropdowntList(BuildContext context) async {
    getSiteDropdownvalue.value.clear();
    mainlist.value.clear();
    getSiteDropdownvalue.value = await CommonProvider.getSiteDropdown(toProjectId);
    mainlist.value=getSiteDropdownvalue.value;
    getSiteDropdownvalue.value.forEach((element) {
      return siteDropdownName.add(element.siteName);
    });
    AckSiteName(context, getSiteDropdownvalue.value);

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return TransACKtoSitePopup(list:getSiteDropdownvalue.value);
    //     });

  }

  setSelectedSiteID(String value) {
    if (getSiteDropdownvalue.value.length>0) {
      getSiteDropdownvalue.forEach((element) {
        if(value == element.siteName){
          toSiteid(element.siteId);
        }
      });
    }
    setSelectedMRNListName(toSiteid.value);
  }

  setSelectedMRNListName(int? id) {
    if (getSiteDropdownvalue.value != null) {
      getSiteDropdownvalue.value.forEach((element) {
        if (id == element.siteId) {
          toSiteName(element.siteName.toString());
        }
      });
    }
    toSitename.text=toSiteName.value;
  }



  //--------------Ack site Name------------

  final searchcontroller = TextEditingController();

  AckSiteName(context, list ){
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
                    },
                    textInputAction: TextInputAction.search,
                    onChanged: (value)  {
                      list = BaseUtitiles.sitePopupAlert(value, getSiteDropdownvalue.value);
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
                    child: Text("Site Name", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
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
                          child: Text(list[index].siteName.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.Lable_Font_SIZE,fontWeight: FontWeight.bold),),
                        ),
                        onTap: (){
                          toSiteid.value = list[index].siteId;
                          toSitename.text = list[index].siteName.toString();
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


  Future getEntryList() async {
    mainentrylist.value.clear();
    entrylistDatas.value.clear();
    await PendingListProvider.gettransferACk_Entry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        entrylist_fromDate.text,
        entrylist_toDate.text).then((value) async {
      if (value != null && value.length > 0) {
        mainentrylist.value = value;
        entrylistDatas.value = mainentrylist.value;
        return mainentrylist.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }



  Future tranAckAlldatasApi(int transferId, BuildContext context) async {
    await PendingListProvider.TransferAcknowPendingAPI(transferId).then((value) async {
      if (value != null && value.length > 0) {
        editcheck=0;
        entrycheck=0;
        transferAlldatas.value = value;
        SaveDetTable();
        getDetTablesDatas();
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  TransferAcknow_EntryScreen()),);
        // return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  TransferAcnowPending(0)),);
      }
    });
  }


  deleteDetTableDatas() async {
    await transferAckDetService.TransferAck_Dettable_delete();
  }

  Future SaveDetTable() async {
    transferDetModelList.clear();
    transferAlldatas.forEach((element) {
      element.transferDet.forEach((val) {
        transferAckDetModel = new TransferAckDetTableModel();
        //  subContDetModel.id = val.lbrCatId;
        transferAckDetModel.transferDetId = val.transferDetId;
        transferAckDetModel.materialId = val.materialId;
        transferAckDetModel.materialName = val.materialName.toString();
        transferAckDetModel.scale = val.scale.toString().toString();
        transferAckDetModel.transQty = val.transQty;
        transferAckDetModel.ackQty=val.ackQty.toDouble();
        transferAckDetModel.detRemarks=val.detRemarks.toString();
        transferDetModelList.add(transferAckDetModel);
      });
    });
    var savedatas = await transferAckDetService.TransferAck_DetTable_Save(transferDetModelList);
    return  savedatas;
  }


  Future getDetTablesDatas() async {
    var datas = await transferAckDetService.TransferAck_DetTable_readAll();
    transferAckDetReadList = <TransferAckDetTableModel>[];
    transferAckDetReadList.clear();
    readListdata.value.clear();
    datas.forEach((user) {
      transferAckDetModel = new TransferAckDetTableModel();
     transferAckDetModel.transferDetId = user['transferDetId'];
     transferAckDetModel.materialId = user['materialId'];
     transferAckDetModel.materialName = user['materialName'];
     transferAckDetModel.scale = user['scale'];
     transferAckDetModel.transQty = user['transQty'];
     transferAckDetModel.ackQty = user['ackQty'];
     print("pppppp...${transferAckDetModel.ackQty}");
     transferAckDetModel.detRemarks = user['detRemarks'];
      transferAckDetReadList.add(transferAckDetModel);
      readListdata.value = transferAckDetReadList;
    });
    setTextControllersValue();

  }

  setTextControllersValue() async {
    for (var index = 0; index < readListdata.length; index++) {
      textControllersInitiate();
      transferQtyListController[index].text = readListdata[index].transQty.toString();
      ackQtyListController[index].text = readListdata[index].ackQty.toString();
      detremarksListController[index].text = readListdata[index].detRemarks.toString();
    }
  }

  clickEdit() {
    int i=0;
    readListdata.value.forEach((element) {
      textControllersInitiate();
      if (element.transQty >=
          (double.tryParse(ackQtyListController[i].text.trim()) ?? 0.0)) {
      } else{
        ackQtyListController[i].text='0.0';
        BaseUtitiles.showToast("Can't accept more than of transfer qty");
      }
      i++;
    });
    updateDetTable();
  }


  updateDetTable() async {
    UpdateModelList.clear();
    for (var n = 0; n < readListdata.length; n++) {
      textControllersInitiate();
      transferAckDetModel = new TransferAckDetTableModel();
      // transferAckDetModel.id = readListdata[n].transferDetId;
      transferAckDetModel.transferDetId = readListdata[n].transferDetId;
      transferAckDetModel.materialId = readListdata[n].materialId;
      transferAckDetModel.materialName = readListdata[n].materialName.toString();
      transferAckDetModel.scale = readListdata[n].scale.toString();
      transferAckDetModel.transQty = readListdata[n].transQty;
      transferAckDetModel.ackQty =  double.tryParse(ackQtyListController[n].text.trim()) ?? 0.0;
      transferAckDetModel.detRemarks=detremarksListController[n].text;
      UpdateModelList.add(transferAckDetModel);
    }
    await transferAckDetService.TransferAck_DetTable_Update(UpdateModelList);

  }

  textControllersInitiate(){
    transferQtyListController.add(new TextEditingController());
    ackQtyListController.add(new TextEditingController());
    detremarksListController.add(new TextEditingController());
  }



  Future Save_EntryScreen(BuildContext context,int id) async {
    getTransferDetList.value.clear();
    await Future.delayed(const Duration(seconds:0));
    String body = transferAckSaveReqToJson(TransferAckSaveReq(
      ackId:id!=0?id.toString(): "0",
      ackNo:autoYearWiseNoController.text,
      ackDate:entryDateController.text,
      transferId:transferAlldatas[0].transferId.toString(),
      transferNo:transferAlldatas[0].transferNo.toString(),
      frProjectId:frProjectID.toString(),
      toProjectId:toProjectId.toString(),
      toSiteId:toSiteid.toString(),
      remarks:"",
      preparedby:loginController.EmpId(),
      userId:loginController.UserId(),
      deviceName:BaseUtitiles.deviceName,
      entryMode:saveButton.value=="Submit"?"ADD":saveButton.value=="Re-Submit"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
      transferAckDet:getTransferDetList.value.length==0 ? getDetDetails(): getTransferDetList.value,
    ));
   // if(checkitemlist==0){
     final list = await PendingListProvider.transferACk_SaveApi(body,id,context);
     if(list!=null) {
       if ( id != 0) {
         entrycheck = 2;
         Navigator.pop(context);
         Navigator.pop(context);
         Navigator.pop(context);
         BaseUtitiles.showToast(list);
         await pendingListController.getPendingList();
         // Navigator.pop(context);
         return;
       }
       else {
         if (list == RequestConstant.DUPLICATE_OCCURED) {
           Navigator.pop(context);
           Navigator.pop(context);
           return BaseUtitiles.showToast(list);
         } else {
           entrycheck = 2;
           BaseUtitiles.showToast(list);
           await pendingListController.getPendingList();
           Navigator.pop(context);
           Navigator.pop(context);
           Navigator.pop(context);

         }
       }
     }
   // }
   // else{
   //   BaseUtitiles.showToast("Please check ack qty 0.0 can't to save");
   //   Navigator.pop(context);
   // }
  }

  List<TransferAckDet>? getDetDetails() {
    checkitemlist = 0;
    for (int index = 0; index < readListdata.length; index++) {
      // if(readListdata[index].ackQty>0){
        var list = new TransferAckDet(
          transferDetId:readListdata[index].transferDetId.toString(),
          materialId:readListdata[index].materialId.toString(),
          detRemarks:readListdata[index].detRemarks,
          ackQty:readListdata[index].ackQty.toString(),
        );
        getTransferDetList.add(list);
      // }else{
      //   checkitemlist = 1;
      // }
    }
    return getTransferDetList.value;
  }


  Future EntryList_EditApi(int ackId,int transferID,BuildContext context) async {
    await PendingListProvider.entryList_editAPI(ackId,transferID).then((value) async {
      if (value != null && value.length > 0) {
        editcheck = 1;
        editlistDatas.value = value;
        EditTable_SaveTable();
        getDetTablesDatas();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TransferacknowEntryList()),
        );
      }
    });
  }

  Future EntryList_DeleteApi(int transId,String ackNo,String transNo) async {
    await PendingListProvider.entryList_deleteAPI(transId,ackNo,transNo,loginController.UserId(),BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  EditTable_SaveTable() async {
    transferDetModelList.clear();
    editlistDatas.forEach((element) {
      element.transferAckEditDet.forEach((val) {
        transferAckDetModel = new TransferAckDetTableModel();
        //  subContDetModel.id = val.lbrCatId;
        transferAckDetModel.transferDetId = val.transferDetId;
        transferAckDetModel.materialId = val.materialId;
        transferAckDetModel.materialName = val.materialName.toString();
        transferAckDetModel.scale = val.scale.toString().toString();
        transferAckDetModel.transQty = val.transQty;
        transferAckDetModel.ackQty=val.ackQty.toDouble();
        transferDetModelList.add(transferAckDetModel);
      });
    });
    var savedatas = await transferAckDetService.TransferAck_DetTable_Save(transferDetModelList);
    return  savedatas;
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
                          EntryList_DeleteApi(entrylistDatas[index].transferId,entrylistDatas[index].ackNo,entrylistDatas[index].transferNo);
                          entrylistDatas.removeAt(index);
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
          //    EntryList_DeleteApi(entrylistDatas[index].transferId,entrylistDatas[index].ackNo,entrylistDatas[index].transferNo);
          //    entrylistDatas.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }


}