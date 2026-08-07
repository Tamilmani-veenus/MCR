
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';

import '../commonpopup/mrnfinalApprovalfrmproject_alert.dart';
import '../db_model/materialapprlist_model.dart';
import '../db_services/materialapprlist_service.dart';
import '../home/pending_list/mrnfinal_aproval/mrnfinal_entryscreen.dart';
import '../models/mrnfinalapproval_aproveapiresmodel.dart';
import '../models/project_name_response.dart';
import '../provider/common_provider.dart';
import '../provider/mrnfinalapproval_provider.dart';
import '../provider/pendinglist_provider.dart';
import '../utilities/baseutitiles.dart';
import 'logincontroller.dart';
import 'mrn_preapproval_controller.dart';
import 'mrn_request_indent_controller.dart';

class MrnFinalApprovalController extends GetxController{


  final RequestNoText = TextEditingController();
  final RequestDateText = TextEditingController();
  final DueDateText = TextEditingController();
  final ApprovalNoText = TextEditingController();
  final ApprovalDateText = TextEditingController();
  final ReqremarksText = TextEditingController();
  final ApprovalremarksText = TextEditingController();
  final ApprovedbyText = TextEditingController();
  final VerifiedbyText = TextEditingController();
  final PreparedbyText = TextEditingController();


  int entrycheck = 0;
  int reqId = 0;
  int checkColor = 0;
  String screenCheck = "";
  RxList mrngetdropDownvalue = [].obs;
  List<ProjectName>? mainlist = [];
  RxList mrnProjectDropdownName = [].obs;
  String? approvalType;
  List<ProjectName>? projectName = [];
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  PendingListController pendingListController = Get.put(PendingListController());


  List<TextEditingController> BalQty_ListController = [];
  List<TextEditingController> ReqQty_ListController = [];
  List<TextEditingController> ApprQty_ListController = [];
  List<TextEditingController> Approval_ListController = [];
  List<TextEditingController> TransfrProject_ListController = [];
  List<TextEditingController> Description_ListController = [];
  List<TextEditingController> Remarks_ListController = [];
  List<TextEditingController> projectId = [];

  RxList<RequestAppDet> getsaveDetList = <RequestAppDet>[].obs;
  RxList mrnfinalAppDetList = [].obs;


  /// ------- Local DB Steps ---------------

  late List<Materialapprlist> materialFinalApprTableList = <Materialapprlist>[];
  late List<Materialapprlist> finalapprupdateTableListDatas = <Materialapprlist>[];
  var materialFinalapprlistTableModel = Materialapprlist();
  var materialFinalapprlistService = MaterialapprlistService();
  RxList MaterialFinalAppr_itemview_GetDbList = [].obs;

  itemlist_textControllersInitiate() {
    BalQty_ListController.add(TextEditingController());
    ReqQty_ListController.add(TextEditingController());
    ApprQty_ListController.add(TextEditingController());
    Approval_ListController.add(TextEditingController());
    TransfrProject_ListController.add(TextEditingController());
    Description_ListController.add(TextEditingController());
    Remarks_ListController.add(TextEditingController());
    projectId.add(TextEditingController());
  }


  /// ------------- Itemlist save in DB ----------------

  finalapp_malerialitemlist_save_DB(BuildContext context){
    materialFinalApprTableList.clear();
    mrnfinalAppDetList.forEach((element) {
      itemlist_textControllersInitiate();
      materialFinalapprlistTableModel = Materialapprlist();
      materialFinalapprlistTableModel.reqDetId = element.reqMasDetId;
      materialFinalapprlistTableModel.materialid = element.materialid;
      materialFinalapprlistTableModel.tranfromprjid = element.refProjectid.toString();
      materialFinalapprlistTableModel.materialname = element.material.toString();
      materialFinalapprlistTableModel.tranfromprjname = element.refProjectName;
      materialFinalapprlistTableModel.scale = element.scale.toString();
      materialFinalapprlistTableModel.balqty = element.balQty;
      materialFinalapprlistTableModel.appqty = element.qty;
      materialFinalapprlistTableModel.reqqty = element.reqQty;
      materialFinalapprlistTableModel.apptype = element.appType.toString()=="null"?"P":element.appType;
      materialFinalapprlistTableModel.remarks = element.remarks==""?"-":element.remarks;
      materialFinalapprlistTableModel.desc = element.description==""?"-":element.description;
      materialFinalApprTableList.add(materialFinalapprlistTableModel);
    });
    var saveData =  materialFinalapprlistService.MaterialApproval_table_Save(materialFinalApprTableList);
    return Navigator.pop(context, saveData);
  }


  /// ------------ Get itemlist from local DB ---------------

  getFinalApp_MaterialsItemlist_TableDatas() async {
    MaterialFinalAppr_itemview_GetDbList.value.clear();
    var MatAppList = await materialFinalapprlistService.Material_ApprovalItemlist_table_readAll();
    MatAppList.forEach((getdatas){
      var materialapprlist =  Materialapprlist();
      materialapprlist.reqDetId = getdatas['reqDetId'];
      materialapprlist.materialid = getdatas['materialid'];
      materialapprlist.tranfromprjid = getdatas['tranfromprjid'];
      materialapprlist.materialname = getdatas['materialname'];
      materialapprlist.tranfromprjname = getdatas['tranfromprjname'];
      materialapprlist.scale =  getdatas['scale'];
      materialapprlist.balqty = getdatas['balqty'];
      materialapprlist.appqty = getdatas['appqty'];
      materialapprlist.reqqty = getdatas['reqqty'];
      materialapprlist.apptype = getdatas['apptype'];
      materialapprlist.remarks = getdatas['remarks'];
      materialapprlist.desc = getdatas['desc'];
      MaterialFinalAppr_itemview_GetDbList.add(materialapprlist);
    });
    setTextControllersValue();
  }


  /// ----- Set Value -----

  setTextControllersValue() async {
    for (var index = 0; index < MaterialFinalAppr_itemview_GetDbList.length; index++) {
      itemlist_textControllersInitiate();
      BalQty_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].balqty.toString();
      ReqQty_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].reqqty.toString();
      ApprQty_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].appqty.toString();
      Approval_ListController[index].text = (MaterialFinalAppr_itemview_GetDbList.value[index].apptype  == "P"?"PO" : MaterialFinalAppr_itemview_GetDbList.value[index].apptype  == "O" ? "Rental WorkOrder" : MaterialFinalAppr_itemview_GetDbList.value[index].apptype  ==  "T" ? "Transfer" : MaterialFinalAppr_itemview_GetDbList.value[index].apptype  == "C" ? "Cancel" : MaterialFinalAppr_itemview_GetDbList.value[index].apptype  == "W" ? "Pending" : "PO");
      // Approval_ListController[index].text = (MaterialFinalAppr_itemview_GetDbList.value[index].apptype  == "PO"?"PO" : MaterialFinalAppr_itemview_GetDbList.value[index].apptype  == "Rental WorkOrder" ? "Rental WorkOrder" : MaterialFinalAppr_itemview_GetDbList.value[index].apptype  ==  "Transfer" ? "Transfer" : MaterialFinalAppr_itemview_GetDbList.value[index].apptype  == "Cancel" ? "Cancel" : MaterialFinalAppr_itemview_GetDbList.value[index].apptype  == "Pending" ? "Pending" : null)!;
      TransfrProject_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].tranfromprjname ==""?"--Select--":"--Select--";
      projectId[index].text=MaterialFinalAppr_itemview_GetDbList.value[index].tranfromprjid.toString();
      Description_ListController[index].text=MaterialFinalAppr_itemview_GetDbList.value[index].desc.toString();
      Remarks_ListController[index].text=MaterialFinalAppr_itemview_GetDbList.value[index].remarks.toString();
      print("Hello Transfer :: ${TransfrProject_ListController[index].text}");
      print("Hello AppType :: ${Approval_ListController[index].text}");
    }
  }

  /// --------- appqty dosen't greater than balqty ----------

  // finalApproval_MaterialItemlist_clickEdit(String value) {
  //   for (var index = 0; index < MaterialFinalAppr_itemview_GetDbList.value.length; index++) {
  //     if(ApprQty_ListController[index].value.text == "" ){
  //     }
  //    else if(double.parse(ApprQty_ListController[index].value.text) <= MaterialFinalAppr_itemview_GetDbList[index].reqqty){
  //
  //     }else{
  //       ApprQty_ListController[index].text = "0.0";
  //     }
  //     finalApproval_updateConsumTables();
  //   }
  // }


  finalApproval_MaterialItemlist_clickEdit() {
    for (var index = 0; index < MaterialFinalAppr_itemview_GetDbList.value.length; index++) {
      finalApproval_updateConsumTables();

      // double balQty = double.parse(MaterialFinalAppr_itemview_GetDbList.value[index].balqty.toString());
      // double enteredQty = 0;
      // if(ApprQty_ListController[index].value.text == ""){
      //   enteredQty = 0;
      // }
      // else{
      //   enteredQty = double.parse(ApprQty_ListController[index].value.text);
      // }
      // if (balQty < enteredQty) {
      //   BaseUtitiles.showToast("More than Bal Qty, Not Allowed");
      //   enteredQty = 0;
      //   ApprQty_ListController[index].text = "0";
      // }
      // else {
      //   finalApproval_updateConsumTables();
      // }
    }
  }

  Future<void> gettingProjectName(int reqMasId,int matId,int proId,BuildContext context) async {
    projectName!.clear();
    ProjectNameResponse projectNameResponse = await MrnFinalApprovalProvider().projectNameProvider(matId, proId);
    projectName = projectNameResponse.projectName;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MrnFinalAprFrProjectAlert(list:projectNameResponse.projectName,data: reqMasId);
        });
  }

  // ---------Update tableList Datas-----------
  finalApproval_updateConsumTables() async {
    int i = 0;
    finalapprupdateTableListDatas.clear();
    MaterialFinalAppr_itemview_GetDbList.forEach((element) {
      // if(ApprQty_ListController[i].value.text == ""){
      //   materialFinalapprlistTableModel = Materialapprlist();
      //   materialFinalapprlistTableModel.reqDetId = element.reqDetId;
      //   materialFinalapprlistTableModel.materialid = element.materialid;
      //   materialFinalapprlistTableModel.tranfromprjid = projectId[i].text;
      //   materialFinalapprlistTableModel.materialname = element.materialname.toString();
      //   materialFinalapprlistTableModel.tranfromprjname = TransfrProject_ListController[i].text;
      //   materialFinalapprlistTableModel.scale =  element.scale;
      //   materialFinalapprlistTableModel.balqty = element.balqty;
      //   materialFinalapprlistTableModel.appqty = 0;
      //   materialFinalapprlistTableModel.reqqty = element.reqqty;
      //   materialFinalapprlistTableModel.apptype = Approval_ListController[i].text;
      //   materialFinalapprlistTableModel.remarks = Remarks_ListController[i].text;
      //   materialFinalapprlistTableModel.desc = Description_ListController[i].text;
      //   finalapprupdateTableListDatas.add(materialFinalapprlistTableModel);
      //   i++;
      // }
      // else {
        materialFinalapprlistTableModel = Materialapprlist();
        materialFinalapprlistTableModel.reqDetId = element.reqDetId;
        materialFinalapprlistTableModel.materialid = element.materialid;
        materialFinalapprlistTableModel.tranfromprjid = Approval_ListController[i].text == "Transfer"? projectId[i].text : "0";
        materialFinalapprlistTableModel.materialname = element.materialname.toString();
        materialFinalapprlistTableModel.tranfromprjname = Approval_ListController[i].text == "Transfer" ? TransfrProject_ListController[i].text : "--Select--";
        materialFinalapprlistTableModel.scale =  element.scale;
        materialFinalapprlistTableModel.balqty = element.balqty;
        materialFinalapprlistTableModel.reqqty = element.reqqty;
        materialFinalapprlistTableModel.appqty = double.parse(ApprQty_ListController[i].value.text);
        // materialFinalapprlistTableModel.apptype = Approval_ListController[i].text;
        materialFinalapprlistTableModel.apptype = Approval_ListController[i].text  == "PO"?"P" : Approval_ListController[i].text  == "Rental WorkOrder" ? "O" : Approval_ListController[i].text ==  "Transfer" ? "T" : Approval_ListController[i].text  == "Cancel" ? "C" : Approval_ListController[i].text  == "Pending" ? "W" : null ;
       materialFinalapprlistTableModel.remarks = Remarks_ListController[i].text;
       materialFinalapprlistTableModel.desc = Description_ListController[i].text;
        finalapprupdateTableListDatas.add(materialFinalapprlistTableModel);
        i++;
      // }
    });
    await materialFinalapprlistService.Material_ApprovalItemlist_table_Update(finalapprupdateTableListDatas);
  }


  /// ---- delete Table data ------

  deleteMaterial_FinalApprvalTable() async {
    await materialFinalapprlistService.Material_ApprovalItemlist_table_delete();
  }



  /// ------------ MRN Final Approval List --------------

  Future mrnFinalapprovalDetListApi(int ReqMasId, BuildContext context) async {
    mrnfinalAppDetList.value.clear();
    await PendingListProvider.getMrnFinalApproval(ReqMasId).then((value) async {
      if (value != null && value.length > 0) {
        mrnfinalAppDetList.value = value;
        await finalapp_malerialitemlist_save_DB(context);
        getFinalApp_MaterialsItemlist_TableDatas();
        Navigator.push(context, MaterialPageRoute(builder: (context) => MrnfinalEntryScreen()),);
      }
    });
  }


  // Future getProjectList(BuildContext context,int id) async {
  //   mrngetdropDownvalue.value.clear();
  //   mrngetdropDownvalue.value= await CommonProvider.getproject(loginController.user.value.userId!,loginController.UserType());
  //     mrngetdropDownvalue.value.forEach((element) {
  //       return mrnProjectDropdownName.value.add(element.project);
  //     });
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return MrnFinalAprFrProjectAlert(list:mrngetdropDownvalue.value,data: id);
  //         });
  // }


  Future ApproveAPI(BuildContext context) async {
    await Future.delayed(const Duration(seconds:0));
    String body = mrnfinalapprovalApprovalResmodelToJson(MrnfinalapprovalApprovalResmodel(
        reqId: reqId.toString(),
        reqNo: RequestNoText.text,
        reqDate: RequestDateText.text,
        reqDueDate: DueDateText.text,
        projectId: projectController.selectedProjectId.value.toString(),
        siteId: siteController.selectedsiteId.value.toString(),
        // appNo: ApprovalNoText.text,
        appDate: ApprovalDateText.text,
        approvedby: loginController.EmpId(),
        appRemarks: ApprovalremarksText.text,
        reqRemarks: ReqremarksText.text,
        preparedBy: loginController.EmpId(),
        userId: loginController.UserId(),
        entryMode: "APPROVE",
        deviceName: BaseUtitiles.deviceName,
        requestAppDet: attendanceListDet(),
    ));
    final list = await MrnFinalApprovalProvider.approveApi(body,context);
    if (list != null) {
      BaseUtitiles.showToast(list);
      await pendingListController.getPendingList();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      return Navigator.pop(context);
    }
  }


  List<RequestAppDet>? attendanceListDet() {
    getsaveDetList.value.clear();
    int i=0;
    MaterialFinalAppr_itemview_GetDbList.value.forEach((element) {
      itemlist_textControllersInitiate();
      if(element.apptype.toString() == "PO"){
        var list = RequestAppDet(
          matId: element.materialid.toString(),
          reqDetId: element.reqDetId.toString(),
          scale: element.scale.toString(),
          qty: element.balqty.toString(),
          appQty: element.appqty.toString(),
          appType: element.apptype == "PO"
            ? "P"
            : element.apptype == "Cash PO"
            ? "H"
            : element.apptype == "Rental WorkOrder"
            ? "O"
            : element.apptype == "Petty Cash"
            ? "I"
            : element.apptype ==  "Transfer"
            ? "T"
            : element.apptype == "Cancel"
            ? "C"
            : "W",
          // appType:Approval_ListController[i].text=="PO"?"P":Approval_ListController[i].text=="Cash PO"?"H":Approval_ListController[i].text=="Rental WorkOrder"?"O":Approval_ListController[i].text=="Petty Cash"?"I":Approval_ListController[i].text=="Transfer"?"T":Approval_ListController[i].text=="Cancel"?"C":"W",
          transferFrom: element.tranfromprjid.toString(),
          detRemarks: element.remarks.toString(),
          detDescription: element.desc.toString(),
        );
        getsaveDetList.value.add(list);
        i++;
      } else {
        var list = RequestAppDet(
          matId: element.materialid.toString(),
          reqDetId: element.reqDetId.toString(),
          scale: element.scale.toString(),
          qty: element.balqty.toString(),
          appQty: element.appqty.toString(),
          appType: element.apptype.toString(),
          // appType:Approval_ListController[i].text=="PO"?"P":Approval_ListController[i].text=="Cash PO"?"H":Approval_ListController[i].text=="Rental WorkOrder"?"O":Approval_ListController[i].text=="Petty Cash"?"I":Approval_ListController[i].text=="Transfer"?"T":Approval_ListController[i].text=="Cancel"?"C":"W",
          transferFrom: element.tranfromprjid.toString(),
          detRemarks: element.remarks.toString(),
          detDescription: element.desc.toString(),
        );
        getsaveDetList.value.add(list);
        i++;
      }
    });
    return getsaveDetList.value;
  }
}