
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mcr/utilities/requestconstant.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../commonpopup/mrnfinalApprovalfrmproject_alert.dart';
import '../db_model/materialapprlist_model.dart';
import '../db_services/materialapprlist_service.dart';
import '../home/pending_list/mrnpre_aproval/mrnpreapr_entryscreen.dart';
import '../home/pending_list/mrnpre_aproval/mrnpreapr_stockmaterialwiselist_popup.dart';
import '../home/pending_list/pending_list.dart';
import '../models/mrnfinalapproval_aproveapiresmodel.dart';
import '../models/project_name_response.dart';
import '../provider/common_provider.dart';
import '../provider/mrnfinalapproval_provider.dart';
import '../provider/pendinglist_provider.dart';
import '../utilities/baseutitiles.dart';
import 'logincontroller.dart';
import 'mrn_request_indent_controller.dart';

class MrnPreApprovalController extends GetxController{

  final mrnpre_RequestNoText = TextEditingController();
  final mrnpre_RequestDateText = TextEditingController();
  final mrnpre_DueDateText = TextEditingController();
  final mrnpre_ApprovalNoText = TextEditingController();
  final mrnpre_ApprovalDateText = TextEditingController();
  final mrnpre_ReqremarksText = TextEditingController();
  final mrnpre_ApprovalremarksText = TextEditingController();
  final mrnpre_ApprovedbyText = TextEditingController();
  final mrnpre_VerifiedbyText = TextEditingController();
  final mrnpre_PreparedbyText = TextEditingController();
  final searchcontroller = TextEditingController();

  int entrycheck=0;
  int reqId=0;
  int checkColor=0;
  int qtycheck = 0;
  String? approvalType;


  LoginController loginController=Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  PendingListController pendingListController=Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());

  List<TextEditingController> mrnpre_BalQty_ListController = [];
  List<TextEditingController> mrnpre_ReqQty_ListController = [];
  List<TextEditingController> mrnpre_ApprQty_ListController = [];
  List<TextEditingController> mrnpre_Approval_ListController = [];
  List<TextEditingController> mrnpre_Description_ListController = [];
  List<TextEditingController> mrnpre_Remarks_ListController = [];
  List<TextEditingController> mrnpre_projectId = [];
  List<TextEditingController> mrnpre_TransfrProject_ListController = [];

  RxList mrngetdropDownvalue=[].obs;
  RxList mrnProjectDropdownName=[].obs;
  List<ProjectName>? mainlist = [];
  RxList<RequestAppDet> getsaveDetList = <RequestAppDet>[].obs;
  RxList MaterialAppr_itemview_GetDbList = [].obs;
  late List<Materialapprlist> materialApprTableList = <Materialapprlist>[];
  late List<Materialapprlist> updateTableListDatas = <Materialapprlist>[];
  RxList mrnPreAppDetList = [].obs;


  var materialapprlistTableModel = Materialapprlist();
  var materialapprlistService = MaterialapprlistService();

  /// ------------- Itemlist save in DB ----------------

  malerialitemlist_save_DB(BuildContext context){
    materialApprTableList.clear();
    mrnPreAppDetList.forEach((element) {
      itemlist_textControllersInitiate();
      materialapprlistTableModel = new Materialapprlist();
      materialapprlistTableModel.reqDetId = element.reqMasDetId;
      materialapprlistTableModel.materialid = element.materialid;
      materialapprlistTableModel.tranfromprjid = "0";
      materialapprlistTableModel.materialname = element.material.toString();
      materialapprlistTableModel.tranfromprjname = "--Select--";
      materialapprlistTableModel.scale = element.scale.toString();
      materialapprlistTableModel.balqty = element.balQty;
      materialapprlistTableModel.appqty = element.qty;
      materialapprlistTableModel.reqqty = element.reqQty;
      materialapprlistTableModel.apptype = "PO";
      materialapprlistTableModel.remarks = element.remarks;
      materialapprlistTableModel.desc = element.description;
      materialApprTableList.add(materialapprlistTableModel);
    });
    var saveData =  materialapprlistService.MaterialApproval_table_Save(materialApprTableList);
    return Navigator.pop(context, saveData);
  }

  /// --------- Get itemlist from local DB ---------------

  getMaterialsItemlist_TableDatas() async {
    MaterialAppr_itemview_GetDbList.value.clear();
    var MatAppList = await materialapprlistService.Material_ApprovalItemlist_table_readAll();
    MatAppList.forEach((getdatas){
      var materialapprlist = Materialapprlist();
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
      MaterialAppr_itemview_GetDbList.add(materialapprlist);
    });
    setTextControllersValue();
  }


  /// ----- Set Value -----

  setTextControllersValue() async {
      for (var index = 0; index < MaterialAppr_itemview_GetDbList.length; index++) {
        itemlist_textControllersInitiate();
        mrnpre_BalQty_ListController[index].text = MaterialAppr_itemview_GetDbList.value[index].balqty.toString();
        mrnpre_ReqQty_ListController[index].text = MaterialAppr_itemview_GetDbList.value[index].reqqty.toString();
        mrnpre_ApprQty_ListController[index].text = MaterialAppr_itemview_GetDbList.value[index].appqty.toString();
        mrnpre_Approval_ListController[index].text = (MaterialAppr_itemview_GetDbList.value[index].apptype  == "PO"?"PO" : MaterialAppr_itemview_GetDbList.value[index].apptype  == "Rental WorkOrder" ? "Rental WorkOrder" : MaterialAppr_itemview_GetDbList.value[index].apptype  ==  "Transfer" ? "Transfer" : MaterialAppr_itemview_GetDbList.value[index].apptype  == "Cancel" ? "Cancel" : MaterialAppr_itemview_GetDbList.value[index].apptype  == "Pending" ? "Pending" : null)! ;
        // mrnpre_Approval_ListController[index].text = MaterialAppr_itemview_GetDbList.value[index].apptype  == "PO"?"PO" : MaterialAppr_itemview_GetDbList.value[index].apptype  == "Rental WorkOrder" ? "Rental WorkOrder" : MaterialAppr_itemview_GetDbList.value[index].apptype  ==  "Transfer" ? "Transfer" : MaterialAppr_itemview_GetDbList.value[index].apptype  == "Cancel" ? "Cancel" : MaterialAppr_itemview_GetDbList.value[index].apptype  == "Pending" ? "Pending" : "" ;
       mrnpre_TransfrProject_ListController[index].text = MaterialAppr_itemview_GetDbList.value[index].tranfromprjname ==""?"--Select--":"--Select--";
       mrnpre_projectId[index].text=MaterialAppr_itemview_GetDbList.value[index].tranfromprjid.toString();
       mrnpre_Description_ListController[index].text=MaterialAppr_itemview_GetDbList.value[index].desc.toString();
       mrnpre_Remarks_ListController[index].text=MaterialAppr_itemview_GetDbList.value[index].remarks.toString();
      }
  }

  /// --------- appqty dosen't greater than balqty ----------

  Approval_MaterialItemlist_clickEdit() {
    for (var index = 0; index < MaterialAppr_itemview_GetDbList.value.length; index++) {
      Approval_updateConsumTables();
      // double balQty = double.parse(MaterialAppr_itemview_GetDbList.value[index].balqty.toString());
      // double enteredQty = 0;
      // if(mrnpre_ApprQty_ListController[index].value.text == ""){
      //   enteredQty = 0;
      // }
      // else{
      //   enteredQty = double.parse(mrnpre_ApprQty_ListController[index].value.text);
      // }
      // if (balQty < enteredQty) {
      //   BaseUtitiles.showToast("More than Bal Qty, Not Allowed");
      //   enteredQty = 0;
      //   mrnpre_ApprQty_ListController[index].text = "0";
      // }
      // else {
      //   Approval_updateConsumTables();
      // }
    }
  }


  /// --------- Update tableList Datas -----------

  Approval_updateConsumTables() async {
    int i = 0;
    updateTableListDatas.clear();
    MaterialAppr_itemview_GetDbList.forEach((element) {
      if(mrnpre_ApprQty_ListController[i].value.text == ""){
        materialapprlistTableModel = Materialapprlist();
        materialapprlistTableModel.reqDetId = element.reqDetId;
        materialapprlistTableModel.materialid = element.materialid;
        materialapprlistTableModel.tranfromprjid = mrnpre_Approval_ListController[i].text == "Transfer"? mrnpre_projectId[i].text : "0";
        materialapprlistTableModel.materialname = element.materialname.toString();
        materialapprlistTableModel.tranfromprjname = mrnpre_TransfrProject_ListController[i].text;
        materialapprlistTableModel.scale =  element.scale;
        materialapprlistTableModel.balqty = element.balqty;
        materialapprlistTableModel.appqty = 0;
        materialapprlistTableModel.reqqty = element.reqqty;
        materialapprlistTableModel.apptype = mrnpre_Approval_ListController[i].text  == "PO"?"P" : mrnpre_Approval_ListController[i].text  == "Rental WorkOrder" ? "O" : mrnpre_Approval_ListController[i].text ==  "Transfer" ? "T" : mrnpre_Approval_ListController[i].text  == "Cancel" ? "C" : mrnpre_Approval_ListController[i].text  == "Pending" ? "W" : null ;
        materialapprlistTableModel.remarks = mrnpre_Remarks_ListController[i].text;
        materialapprlistTableModel.desc = mrnpre_Description_ListController[i].text;
        updateTableListDatas.add(materialapprlistTableModel);
        i++;
      }
      else{
        materialapprlistTableModel =  Materialapprlist();
        materialapprlistTableModel.reqDetId = element.reqDetId;
        materialapprlistTableModel.materialid = element.materialid;
        materialapprlistTableModel.tranfromprjid = mrnpre_Approval_ListController[i].text == "Transfer"? mrnpre_projectId[i].text : "0";
        materialapprlistTableModel.materialname = element.materialname.toString();
        materialapprlistTableModel.tranfromprjname = mrnpre_TransfrProject_ListController[i].text;
        materialapprlistTableModel.scale =  element.scale;
        materialapprlistTableModel.balqty = element.balqty;
        materialapprlistTableModel.reqqty = element.reqqty;
        materialapprlistTableModel.appqty = double.parse(mrnpre_ApprQty_ListController[i].value.text);
        materialapprlistTableModel.apptype = mrnpre_Approval_ListController[i].text  == "PO"?"P" : mrnpre_Approval_ListController[i].text  == "Rental WorkOrder" ? "O" : mrnpre_Approval_ListController[i].text ==  "Transfer" ? "T" : mrnpre_Approval_ListController[i].text  == "Cancel" ? "C" : mrnpre_Approval_ListController[i].text  == "Pending" ? "W" : null ;
        materialapprlistTableModel.remarks = mrnpre_Remarks_ListController[i].text;
        materialapprlistTableModel.desc = mrnpre_Description_ListController[i].text;
        updateTableListDatas.add(materialapprlistTableModel);
        i++;
      }
    });
    await materialapprlistService.Material_ApprovalItemlist_table_Update(updateTableListDatas);
  }


  /// ----- delete Table data -----

  deleteMaterialApprvalTable() async {
    await materialapprlistService.Material_ApprovalItemlist_table_delete();
  }


  /// --------- MRN PreApproval list ---------------

  Future mrnPreapprovalDetListApi(int ReqMasId, BuildContext context) async {
    mrnPreAppDetList.value.clear();
    await PendingListProvider.getMrnPreApproval(ReqMasId).then((value) async {
      if (value != null && value.length > 0) {
        mrnPreAppDetList.value = value;
        print(mrnPreAppDetList.value.toString());
       malerialitemlist_save_DB(context);
       getMaterialsItemlist_TableDatas();
        Navigator.push(context, MaterialPageRoute(builder: (context) => MrnPreApprovalEntryScreen()));
      }
    });
  }


  /// ------------- MRN PreApproval -----------

  itemlist_textControllersInitiate() {
    mrnpre_BalQty_ListController.add(TextEditingController());
    mrnpre_ReqQty_ListController.add(TextEditingController());
    mrnpre_ApprQty_ListController.add(TextEditingController());
    mrnpre_Approval_ListController.add(TextEditingController());
    mrnpre_TransfrProject_ListController.add(TextEditingController());
    mrnpre_Description_ListController.add(TextEditingController());
    mrnpre_Remarks_ListController.add(TextEditingController());
    mrnpre_projectId.add(TextEditingController());
  }

  RxList StockListMaterialWise = [].obs;

  /// ----------- Get Stockmaterialwise List ---------

  Future getStock_MaterialWise(int mid, String materialname, String scale, BuildContext context) async {
    StockListMaterialWise.value.clear();
    await MrnFinalApprovalProvider.getStockmaterialWise(mid).then((value) async {
      if (value != null && value.length > 0) {
        StockListMaterialWise.value = value;
        print(StockListMaterialWise.value.toString());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Mrnpreapr_Stockmaterialwise_Popup(
                  MaterialName: materialname,
                  MaterialId: mid,
                  Scale: scale
              );});
      }else{
        Fluttertoast.showToast(msg: RequestConstant.NORECORD_FOUND);
      }
    });
  }


  // Future getProjectList(BuildContext context,int id) async {
  //   mrngetdropDownvalue.value.clear();
  //   mainlist.value.clear();
  //   mrngetdropDownvalue.value= await CommonProvider.getproject(loginController.user.value.userId!,loginController.UserType());
  //   mrngetdropDownvalue.value.forEach((element) {
  //     return mrnProjectDropdownName.value.add(element.project);
  //   });
  //   // TranserFromProjectName(context,mrngetdropDownvalue.value);
  //   // showDialog(
  //   //     context: context,
  //   //     builder: (BuildContext context) {
  //   //       return MrnPreaproProjectAlert(list:mrngetdropDownvalue.value,data: id);
  //   //     });
  // }

  // TranserFromProjectName(context, list){
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
  //                   onChanged: (value)  {
  //                     list=BaseUtitiles.projectPopupAlert(value, mrngetdropDownvalue.value);
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
  //                   child: Text("Transfer From Projects", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
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
  //                 itemCount: mainlist.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return InkWell(
  //                     onTap: ()async{
  //                       int i=0;
  //                       pendingListController.mrnPreAppDetList.forEach((element) {
  //                         itemlist_textControllersInitiate();
  //                         if(element.reqMasDetId==list.data){
  //                           mrnpre_TransfrProject_ListController[i].text=mainlist[index].project!;
  //                           mrnpre_projectId[i].text=mainlist[index].projectId.toString();
  //                         }
  //                         i++;
  //                       });
  //                       Navigator.pop(context);
  //                     },
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: <Widget>[
  //                         Column(
  //                           mainAxisAlignment:
  //                           MainAxisAlignment.center,
  //                           children: <Widget>[
  //                             Container(
  //                                 width: BaseUtitiles.getWidthtofPercentage(context, 60),
  //                                 child: Text(mainlist.value[index].project.toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
  //                             Divider(
  //                               color: Theme.of(context).primaryColorLight,
  //                             )
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 }),
  //           )
  //         ],
  //       );
  //     },);
  // }

  Future ApproveAPI(BuildContext context) async {
    await Future.delayed(const Duration(seconds:0));
    String body = mrnfinalapprovalApprovalResmodelToJson(MrnfinalapprovalApprovalResmodel(
      reqId:reqId.toString(),
      reqNo:mrnpre_RequestNoText.text,
      reqDate:mrnpre_RequestDateText.text,
      reqDueDate:mrnpre_DueDateText.text,
      projectId:projectController.selectedProjectId.value.toString(),
      siteId:siteController.selectedsiteId.value.toString(),
      // appNo:pendingListController.mrn_preapproval_autoYrsWise.value,
      appDate:mrnpre_ApprovalDateText.text,
      approvedby:loginController.EmpId(),
      appRemarks:mrnpre_ApprovalremarksText.text,
      reqRemarks:mrnpre_ReqremarksText.text,
      preparedBy:loginController.EmpId(),
      userId:loginController.UserId(),
      entryMode: "PREAPPROVE",
      deviceName:BaseUtitiles.deviceName,
      requestAppDet:attendanceListDet(context),
    ));
    // if (qtycheck > 0) {
      final list = await MrnFinalApprovalProvider.preapproveApi(body,context);
      if (list != null) {
        await pendingListController.getPendingList();
        BaseUtitiles.showToast(list);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => PendingList()));
        // pendingListController.getSubcontractor_ExpensesList(loginController.UserId(), loginController.UserType(), "MRN PRE APPROVAL", context);
        return Navigator.pop(context);
      }
    // }
    // else{
    //   BaseUtitiles.showToast("Please check app qty...");
    // }
  }


  List<RequestAppDet>? attendanceListDet(BuildContext context) {
    getsaveDetList.value.clear();
    int i=0;
    MaterialAppr_itemview_GetDbList.value.forEach((element) {
        itemlist_textControllersInitiate();
        if(element.apptype.toString() == "PO"){
          var list = RequestAppDet(
            reqDetId: element.reqDetId.toString(),
            matId: element.materialid.toString(),
            scale: element.scale.toString(),
            qty:element.balqty.toString(),
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
            transferFrom: element.tranfromprjid.toString(),
            detRemarks: element.remarks.toString(),
            detDescription: element.desc.toString(),
          );
          getsaveDetList.value.add(list);
          i++;
        } else {
          var list = RequestAppDet(
            reqDetId: element.reqDetId.toString(),
            matId: element.materialid.toString(),
            scale: element.scale.toString(),
            qty:element.balqty.toString(),
            appQty: element.appqty.toString(),
            appType: element.apptype.toString(),
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


