import 'package:fluttertoast/fluttertoast.dart';
import '../commonpopup/material_addqty_alert.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_model/materiallist_model.dart';
import '../db_services/materiallist_service.dart';
import '../home/menu/materials/mrn_request(indent)/materials_add.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_entry.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_list.dart';
import '../home/pending_list/pending_list.dart';
import '../models/materialintentsave_model.dart';
import '../models/mrnrq_addmat_resmodel.dart';
import '../provider/common_provider.dart';
import '../provider/mrn_request_indent_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class MRN_Request_Controller extends GetxController {
  final MrnEntrylistFrDate = TextEditingController();
  final MrnEntrylistToDate = TextEditingController();
  final autoYearWiseNoController=TextEditingController();
  final RemarksController=TextEditingController();
  final RequestDateController=TextEditingController();
  final DuedateController=TextEditingController();
  final preparedbyController=TextEditingController();
  final ReqTypeController = TextEditingController();

  RxString ReqType = "".obs;
  int checklist = 0;
  int buttonControl = 0;
  bool quaCheck = false;
  bool willPop = false;

  late List<Materiallist> materialTableList = <Materiallist>[];
  late List<Materiallist> updateListDatas = <Materiallist>[];
  late List<Materiallist> deleteModelList = <Materiallist>[];
  RxList<RequestDet> getRequestDetList = <RequestDet>[].obs;
  RxList<MrnReqAddMaterialResmodel> addmaterialQtylist = <MrnReqAddMaterialResmodel>[].obs;

  List<TextEditingController> Itemlist_qtyControllers = [];
  List<TextEditingController> Addwork_materialidControllers = [];
  List<TextEditingController> Addwork_materialnameControllers = [];
  List<TextEditingController> Addwork_scaleControllers = [];
  List<TextEditingController> Addwork_qtyControllers = [];
  List<TextEditingController> Addwork_descControllers = [];
  List<TextEditingController> Addwork_remarksControllers = [];

  RxList list=[].obs;


  LoginController loginController = Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());

  PendingListController pendingListController=Get.put(PendingListController());
  SiteController siteController=Get.put(SiteController());
  RxInt selectedMaterialId = 0.obs;
  RxString selectedMaterialName = "".obs;
  RxList Material_itemview_GetDbList = [].obs;
  late List<bool> isChecked;
  RxString saveButton=RequestConstant.SUBMIT.obs;

  RxList getmaterialvalue=[].obs;
  // RxList getmaterial=[].obs;
  RxList MrnReqEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList StoreList=[].obs;
  RxList Material_EditListApiValue=[].obs;
  RxList pendingAllDatasList = [].obs;


  late List<bool> check;
  int reqId=0;

  int editCheck=0;
  int entrycheck=0;

  int checkColor = 0;

  String screenCheck="";
  var materialTableModel = Materiallist();
  var materiallistService = MateriallistService();




  Future getMrn_Req_EntryList() async {
    mainEtyList.value.clear();
    MrnReqEtyList.value.clear();
    await Mrn_Req_provider.getmrnreqEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        MrnEntrylistFrDate.text,
        MrnEntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainEtyList.value = value;
        MrnReqEtyList.value = mainEtyList.value;
        return mainEtyList.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future getMaterialList(BuildContext context, String requestType) async {
    getmaterialvalue.value.clear();
    getmaterialvalue.value = await CommonProvider.getmaterial(requestType);
    return Navigator.push(context, MaterialPageRoute(builder: (context) => Materials_Add(list:  getmaterialvalue.value,)));
  }

  setCheck(int id,bool value){
    getmaterialvalue.forEach((element) {
      if(element.materialId==id){
        element.isCheck = value;
      }
    });
  }

  serachsetCheck(int id,bool value){
    list.forEach((element) {
      if(element.materialId==id){
        element.isCheck = value;
      }
    });
  }

  setSelectedMaterialListName(int? id) {
    if (getmaterialvalue.value != null) {
      getmaterialvalue.value.forEach((element) {
        if (id == element.materialName) {
          selectedMaterialName(element.materialName.toString());
        }
      });
    }
  }

  Material_itemlist_textControllersInitiate() {
    Itemlist_qtyControllers.add(TextEditingController());
    Addwork_qtyControllers.add(TextEditingController());
    Addwork_descControllers.add(TextEditingController());
    Addwork_remarksControllers.add(TextEditingController());
  }



  /// ----- Material add in db -----

  materiallist_Save_DB(BuildContext context) async {
    materialTableList.clear();
    int i = 0;
    int j =0;
    getmaterialvalue.forEach((element) {
      Material_itemlist_textControllersInitiate();
      if(element.isCheck == true){
        if (Itemlist_qtyControllers[j].value.text == "0.0" || Itemlist_qtyControllers[j].value.text == "0" || Itemlist_qtyControllers[j].value.text == "") {
        }
        else {
          materialTableModel =  Materiallist();
          materialTableModel.materialid = element.materialId!;
          materialTableModel.material = element.material!;
          materialTableModel.scale = element.scale!;
          materialTableModel.qty = double.parse("0");
          materialTableModel.remarks = "";
          materialTableModel.desc = "";
          Material_itemview_GetDbList.forEach((element) {
            if (element.materialid == materialTableModel.materialid) {
              i = 1;
              BaseUtitiles.showToast("Entries already exist");
            }
          });
          if (i == 0) {
            materialTableList.add(materialTableModel);
          }
          else{
            i=0;
          }
        }
      }
      j++;
    });
    var savedatas = await materiallistService.Material_table_Save(materialTableList);
    return Navigator.pop(context, savedatas);
  }

  //Get Values
  Future getMaterialTablesDatas() async {
    Material_itemview_GetDbList.clear();
    var Matlist = await materiallistService.MaterialItemlist_table_readAll();
    Matlist.forEach((user) {
      var materiallist =Materiallist();
      materiallist.materialid = user['materialid'];
      materiallist.material = user['material'];
      materiallist.scale = user['scale'];
      materiallist.qty = user['qty'];
      materiallist.remarks = user['remarks'];
      materiallist.desc = user['desc'];
      Material_itemview_GetDbList.add(materiallist);
    });
    setTextControllersValue();
  }

  //Set Value
  setTextControllersValue() async {
    for (var index = 0; index < Material_itemview_GetDbList.length; index++) {
      Material_itemlist_textControllersInitiate();
      Addwork_qtyControllers[index].text = Material_itemview_GetDbList.value[index].qty.toString();
      Addwork_remarksControllers[index].text=Material_itemview_GetDbList.value[index].remarks.toString();
      Addwork_descControllers[index].text=Material_itemview_GetDbList.value[index].desc.toString();
    }
  }

  // qty edit
  MaterialItemlist_clickEdit() {
    for (var index = 0; index < Material_itemview_GetDbList.value.length; index++) {
      updateConsumTables();
    }
  }


  // qty Update to db
  updateConsumTables() async {
    int i = 0;
    updateListDatas.clear();
    Material_itemview_GetDbList.forEach((element) {
      if(Addwork_qtyControllers[i].value.text == ""){
        materialTableModel = Materiallist();
        materialTableModel.materialid = element.materialid!;
        materialTableModel.material = element.material!;
        materialTableModel.scale = element.scale!;
        materialTableModel.qty = double.parse("0");
        // materialTableModel.balqty = element.balqty;
        materialTableModel.desc=Addwork_descControllers[i].value.text;
        materialTableModel.remarks=Addwork_remarksControllers[i].value.text;
        updateListDatas.add(materialTableModel);
        i++;
      }
      else{
        materialTableModel =new Materiallist();
        materialTableModel.materialid = element.materialid!;
        materialTableModel.material = element.material!;
        materialTableModel.scale = element.scale!;
        materialTableModel.qty = double.parse(Addwork_qtyControllers[i].value.text);
        // materialTableModel.balqty = element.balqty;
        materialTableModel.desc=Addwork_descControllers[i].value.text;
        materialTableModel.remarks=Addwork_remarksControllers[i].value.text;
        updateListDatas.add(materialTableModel);
        i++;
      }
    });
    await materiallistService.MaterialItemlist_table_Update(updateListDatas);
  }


  //Particular delete
  Future deleteParticularList(Materiallist data) async {
    deleteModelList.clear();
    materialTableModel = new Materiallist();
    materialTableModel.materialid = data.materialid;
    deleteModelList.add(materialTableModel);
    await materiallistService.materialdeleteById(deleteModelList);
  }

  delete_MaterialIntent_itemlist_Table() async {
    await materiallistService.MaterialItemlist_table_delete();
  }


  //----- POST and PUT JSON Values----
  Future SaveButton_MaterialIntentScreen(BuildContext context, int id ) async {
    buttonControl = 1;
    getRequestDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = materiasaveResponseToJson(MateriasaveResponse(
      reqId: id != 0 ? id.toString() : "0",
      reqNo: autoYearWiseNoController.text.trim(),
      reqDate: RequestDateController.text,
      reqDueDate: DuedateController.text,
      requestPurType: ReqType.value.toString(),
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.value.toString(),
      reqRemarks: RemarksController.text,
      preparedBy: loginController.EmpId(),
      Approvedby: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode: saveButton.value == "Submit" ? "ADD" :
      saveButton.value == RequestConstant.RESUBMIT ? "UPDATE" :
      saveButton.value == "Verify" ? "VERIFY" :
          saveButton.value == "PreApprove" ? "PREAPPROVE":
          saveButton.value == "GM Approve" ? "GMAPPROVE":
      saveButton.value == "Approve" ? "APPROVE" : "",
      requestDet: getRequestDetList.value.isEmpty
          ? getRequestDet()
          : getRequestDetList.value,
    ));
    if (checklist == 0) {
      final list = await Mrn_Req_provider.SaveMaterialScreenEntryAPI(body, saveButton.value,context);
      if(list != null) {
        if (list == "Material Request Not Saved With Empty List....") {
          Navigator.pop(context);
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Material Request Not Saved With Empty List....");
          buttonControl = 0;
        }
        else {
          if (id != 0) {
            if ( saveButton.value == RequestConstant.VERIFY || saveButton.value =="PreApprove" || saveButton.value =="GM Approve" ) {
              entrycheck = 2;
              buttonControl = 0;
              BaseUtitiles.showToast(list);
              await pendingListController.getPendingList();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              return;
            }
            else {
              entrycheck = 2;
              editCheck = 0;
              buttonControl = 0;
              delete_MaterialIntent_itemlist_Table();
              Material_itemview_GetDbList.clear();
              BaseUtitiles.showToast(list);
              print(list);
              await getMrn_Req_EntryList();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              return;
            }
          }
          else {
            if (list == RequestConstant.DUPLICATE_OCCURED) {
              buttonControl = 0;
              Navigator.pop(context);
              Navigator.pop(context);
              return BaseUtitiles.showToast(list!);
            }
            else {
              BaseUtitiles.showToast(list);
              print(list);
              entrycheck = 2;
              editCheck = 0;
              buttonControl = 0;
              delete_MaterialIntent_itemlist_Table();
              Material_itemview_GetDbList.clear();
              await getMrn_Req_EntryList();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              return;
            }
          }
        }
      }
    } else {
      if (screenCheck != "Verify") {
        willPop = true;
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        willPop = false;
      }
      buttonControl = 0;
      Fluttertoast.showToast(
        msg: "Material Request Not Saved With Empty List....",
      );
    }
  }

  List<RequestDet>? getRequestDet() {
    getRequestDetList.value.clear();
    checklist = 0;
    Material_itemview_GetDbList.value.forEach((element) {
      if(element.qty > 0){
        var list = RequestDet(
          matId: element.materialid.toString(),
          scale: element.scale.toString(),
          qty: element.qty.toString(),
          detRemarks: element.remarks.toString(),
          detDescription: element.desc.toString(),
        );
        getRequestDetList.value.add(list);
      }
      else{
        checklist = 1;
      }
    });
    return getRequestDetList.value;
  }

  // ---------Edit Call API----------

  Future Material_Intentlist_editSaveDetTable() async {
    materialTableList.clear();
    Material_EditListApiValue.forEach((element) {
      element.requestDet.forEach((val) {
        materialTableModel = Materiallist();
        materialTableModel.materialid = val.matId!;
        materialTableModel.material = val.matName!;
        materialTableModel.scale = val.scale!;
        materialTableModel.qty = val.qty;
        // materialTableModel.balqty = val.balqty!;
        materialTableModel.remarks = val.detRemarks!;
        materialTableModel.desc = val.detDescription;
        materialTableList.add(materialTableModel);
      });
    });
    var savedatas = await materiallistService.Material_table_Save(materialTableList);
    return  savedatas;
  }

  Future MaterialIntentList_EditApi(int reqId, int pId, int sId, BuildContext context,from) async {
    await Mrn_Req_provider.Material_IntentList_editAPI(reqId, pId, sId).then((value) async {
      if (value != null && value.length > 0) {
          saveButton.value = from =="Edit"? "Re-Submit":from =="PreApprove"?"PreApprove":"GM Approve";
          screenCheck = from =="Edit"? "Re-Submit":from =="PreApprove"? "PreApprove":"GMApprove";
        delete_MaterialIntent_itemlist_Table();
        Material_itemview_GetDbList.value=[];
        getRequestDetList.value=[];
        editCheck = 1;
        Material_EditListApiValue.value = value;
        Material_Intentlist_editSaveDetTable();
        getMaterialTablesDatas();
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MRNRequest_Indent_Entry()));
      }
    });
  }

//--Entrylist Delete--

  Future Material_EntryList_DeleteApi(int reqId, String ReqNo) async {
    await Mrn_Req_provider.Material_entryList_deleteAPI(reqId,ReqNo, loginController.UserId(), BaseUtitiles.deviceName).then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  Future getPendingList_Alldatas(int reqId,int pID,int sId, BuildContext context) async {
    pendingAllDatasList.clear();
    await Mrn_Req_provider.Material_IntentList_editAPI(reqId, pID, sId).then((value) async {
      if (value.isNotEmpty) {
        pendingAllDatasList.value = value;
        pendingIntentAlldatas_SaveDetTable();
        getMaterialTablesDatas();
        entrycheck = 1;
        editCheck = 0;
        screenCheck = "Verify";
        saveButton.value = RequestConstant.VERIFY;
        FocusScope.of(context).unfocus();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MRNRequest_Indent_Entry()));
        // return  Navigator.pop(context);
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future pendingIntentAlldatas_SaveDetTable() async {
    materialTableList.clear();
    pendingAllDatasList.value.forEach((element) {
      element.requestDet.forEach((val) {
        materialTableModel = Materiallist();
        materialTableModel.materialid = val.matId!;
        materialTableModel.material = val.matName!;
        materialTableModel.scale = val.scale!;
        materialTableModel.qty = val.qty!;
        // materialTableModel.balqty = val.balqty!;
        materialTableModel.remarks = val.detRemarks!;
        materialTableModel.desc = val.detDescription;
        materialTableList.add(materialTableModel);
      });
    });
    var savedatas = await materiallistService.Material_table_Save(materialTableList);
    return  savedatas;
  }


  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
                          editCheck=0;
                          Material_EntryList_DeleteApi(MrnReqEtyList.value[index].reqMasId,MrnReqEtyList.value[index].reqOrdNo);
                          MrnReqEtyList.removeAt(index);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  addmaterialQty(BuildContext context){
    Mrn_Req_provider.addmatGetQtyApi().then((value){
      addmaterialQtylist.value=value;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MaterialAddQtyAlert(list:addmaterialQtylist.value);
          });
    });
  }









}