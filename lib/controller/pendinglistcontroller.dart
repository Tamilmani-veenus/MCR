import '../commonpopup/pendinglistdet_alert.dart';
import '../commonpopup/po_suppliernamelist_alert.dart';
import '../commonpopup/transferackmateriallist_alert.dart';
import '../controller/logincontroller.dart';
import '../home/pending_list/onclickpending_list.dart';
import '../models/advanceapproval_reqapi_model.dart';
import '../models/onclick_pendinglist_model.dart';
import '../models/onclickpendingdet_model.dart';
import '../models/pendinglist_model.dart';
import '../models/pendingpo_aprovalapi_resmodel.dart';
import '../models/poapprovalsupplierlist_model.dart';
import '../models/subcont_nmrbillaproval_pendinglistres_model.dart';
import '../models/transferackmateriallist_model.dart';
import '../provider/pendinglist_provider.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/requestconstant.dart';

class PendingListController extends GetxController {
  List<OnclickPendingListResponse> onclickPendingListData = [];
  RxList mainlist = [].obs;
  RxList mrnfinalapprovallist = [].obs;
  RxList mrnPreapprovallist = [].obs;
  RxList pendingmainlist = [].obs;
  List<OnclickPendingDet> onclickPendingListDet = [];
  List<PendingListResponse> datas = [];
  LoginController loginController = Get.put(LoginController());
  RxList pendingList_datas = [].obs;

  List<PoapprovalSupplierbuilldlListModel> poapprovalSupplierList = [];
  RxList Searchpoapproval_supplierList = [].obs;

  List<TransferAckMatList> transAckMaterialList = [];
  RxList Search_transAckMaterialList = [].obs;

  int checkColor = 0;

  RxString mrn_preapproval_autoYrsWise = "".obs;

  RxList<OnclickPendingListResponse> addSubcontNmrListvalue =
      <OnclickPendingListResponse>[].obs;
  RxList<OnclickPendingListResponse> addBillGenBOQListvalue =
      <OnclickPendingListResponse>[].obs;
  RxList<OnclickPendingListResponse> addBillGenDirectListvalue =
      <OnclickPendingListResponse>[].obs;
  RxList<OnclickPendingListResponse> add_AdvanceReqListvalue =
      <OnclickPendingListResponse>[].obs;
  RxList<OnclickPendingListResponse> add_PoaprovalListvalue =
      <OnclickPendingListResponse>[].obs;
  RxList<OnclickPendingListResponse> add_MrnFinalaprovalListvalue =
      <OnclickPendingListResponse>[].obs;

  RxList<NmrApprovalDet> getNMRAprovalDetList = <NmrApprovalDet>[].obs;
  RxList<DirectApprovalDet> getbillBOQAprovalDetList =
      <DirectApprovalDet>[].obs;
  RxList<DirectApprovalDet> getbillDirectAprovalDetList =
      <DirectApprovalDet>[].obs;
  RxList<AdvApprovalDet> getAdvanceReqAprovalDetList = <AdvApprovalDet>[].obs;
  RxList<ApprovalDet> getPoAprovalDetList = <ApprovalDet>[].obs;
  RxList<ApprovalDet> getMrnFinalAprovalDetList = <ApprovalDet>[].obs;

  Future getPendingList() async {
    pendingList_datas.value.clear();
    await PendingListProvider.getPendingListProvider(
            loginController.UserId(), loginController.UserType())
        .then((value) async {
      if (value != null && value.length > 0) {
        pendingList_datas.value = value;
        return pendingList_datas.value;
      }
      // else {
      // BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      // }
    });
  }

  Future Mrn_PreApproval_AutoYearWise() async {
    mrn_preapproval_autoYrsWise.value = "";
    await PendingListProvider.preapproval_getAutoYearWise().then((value) {
      if (value != null) {
        mrn_preapproval_autoYrsWise.value = value;
        return mrn_preapproval_autoYrsWise.value;
      }
    });
  }

  // Future MrnFinalAproval_buttonApi(BuildContext context) async {
  //   String body =
  //       pendingPoapprovalApiResmodelToJson(PendingPoapprovalApiResmodel(
  //     urlName: "MRN FINAL APPROVAL",
  //     userId: loginController.EmpId(),
  //     deviceName: BaseUtitiles.deviceName,
  //     approvalDet: getMrnFinalAprovalDetList.value.length == 0
  //         ? getMrnFinalApprovalDet()
  //         : getMrnFinalAprovalDetList.value,
  //   ));
  //   if (add_MrnFinalaprovalListvalue.isNotEmpty) {
  //     await PendingListProvider.PoAprovalAPI(body, context);
  //   } else {
  //     BaseUtitiles.showToast("Please select a list");
  //   }
  // }

  List<ApprovalDet>? getMrnFinalApprovalDet() {
    add_MrnFinalaprovalListvalue.value.forEach((element) {
      var list = new ApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getMrnFinalAprovalDetList.value.add(list);
    });
    return getMrnFinalAprovalDetList.value;
  }

  Future poAproval_buttonApi(BuildContext context, String Urlname) async {
    String body =
        pendingPoapprovalApiResmodelToJson(PendingPoapprovalApiResmodel(
      urlName: Urlname.toString(),
      userId: loginController.EmpId(),
      deviceName: BaseUtitiles.deviceName,
      approvalDet: getPoAprovalDetList.value.length == 0
          ? getPoApprovalDet()
          : getPoAprovalDetList.value,
    ));
    if (add_PoaprovalListvalue.isNotEmpty) {
      if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
        await PendingListProvider.PoAprovalAPI(body, context);
        Navigator.pop(context);
      }
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<ApprovalDet>? getPoApprovalDet() {
    add_PoaprovalListvalue.value.forEach((element) {
      var list = new ApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getPoAprovalDetList.value.add(list);
    });
    return getPoAprovalDetList.value;
  }

  Future subcontNmrAproval_buttonApi(BuildContext context) async {
    String body = subContNmrBillAprovalPendinglistResToJson(
        SubContNmrBillAprovalPendinglistRes(
      urlName: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      nmrApprovalDet: getNMRAprovalDetList.value.length == 0
          ? getnmrApprovalDet()
          : getNMRAprovalDetList.value,
    ));
    if (addSubcontNmrListvalue.isNotEmpty) {
      await PendingListProvider.subcontNMR_BillAprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<NmrApprovalDet>? getnmrApprovalDet() {
    addSubcontNmrListvalue.value.forEach((element) {
      var list = new NmrApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getNMRAprovalDetList.value.add(list);
    });
    return getNMRAprovalDetList.value;
  }

  Future billGenBOQAproval_buttonApi(BuildContext context) async {
    String body = billGenBoqApprovalReqToJson(BillGenBoqApprovalReq(
      urlName: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      directApprovalDet: getbillBOQAprovalDetList.value.length == 0
          ? getBillBOQApprovalDet()
          : getbillBOQAprovalDetList.value,
    ));
    if (addBillGenBOQListvalue.isNotEmpty) {
      await PendingListProvider.BillGenAprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<DirectApprovalDet>? getBillBOQApprovalDet() {
    addBillGenBOQListvalue.value.forEach((element) {
      var list = new DirectApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getbillBOQAprovalDetList.value.add(list);
    });
    return getbillBOQAprovalDetList.value;
  }

  Future billGenDirectAproval_buttonApi(BuildContext context) async {
    String body = billGenBoqApprovalReqToJson(BillGenBoqApprovalReq(
      urlName: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      directApprovalDet: getbillDirectAprovalDetList.value.length == 0
          ? getBillDirectApprovalDet()
          : getbillDirectAprovalDetList.value,
    ));
    if (addBillGenDirectListvalue.isNotEmpty) {
      await PendingListProvider.BillGenAprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<DirectApprovalDet>? getBillDirectApprovalDet() {
    addBillGenDirectListvalue.value.forEach((element) {
      var list = new DirectApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getbillDirectAprovalDetList.value.add(list);
    });
    return getbillDirectAprovalDetList.value;
  }

  Future advanceAproval_buttonApi(BuildContext context) async {
    String body = advanceApprovalApiReqToJson(AdvanceApprovalApiReq(
      urlName: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      advApprovalDet: getAdvanceReqAprovalDetList.value.length == 0
          ? getAdvanceApprovalDet()
          : getAdvanceReqAprovalDetList.value,
    ));
    if (add_AdvanceReqListvalue.isNotEmpty) {
      await PendingListProvider.AdvanceRequesAprovalAPI(body, context);
    } else {
      BaseUtitiles.showToast("Please select a list");
    }
  }

  List<AdvApprovalDet>? getAdvanceApprovalDet() {
    add_AdvanceReqListvalue.value.forEach((element) {
      var list = new AdvApprovalDet(
        id: element.id,
        no: element.no.toString(),
      );
      getAdvanceReqAprovalDetList.value.add(list);
    });
    return getAdvanceReqAprovalDetList.value;
  }

  Future GetDetDetails(String Url, int RID, String Reqno, String Projectname,
      BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingListDet_Popup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname,
                    )));
        // return showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return PendingListDetPopup(
        //           list: onclickPendingListDet, ReqNo: Reqno);
        //     });
      }
    });
  }

  Future GetDetDetails_PreApproval(String Url, int RID, String Reqno,
      String Projectname, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingListDet_PreApproval(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname,
                    )));
      }
    });
  }

  Future GetMrnFinalDetDetails(String Url, int RID, String Reqno,
      String projectName, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingListDet_MRNFinalApproval_Popup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: projectName,
                    )));
        // showDialog(
        //    context: context,
        //    builder: (BuildContext context) {
        //      return PendingListMRnFinalPopup(
        //          list: onclickPendingListDet, ReqNo: Reqno);
        //    });
      }
    });
  }

  Future PendingPoDetDetails(String Url, int RID, String Reqno,
      String Projectname, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingList_PoPopup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                      ProjectName: Projectname,
                    )));
        // return showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return PendingListPOPopup(
        //           list: onclickPendingListDet, ReqNo: Reqno);
        //     });
      }
    });
  }

  //-----------PO VERIFICATION---------------------

  Future PendingPoVerificationDetDetails(
      String Url, int RID, String Reqno, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingPo_Approvel_Popup(
                      heading: Url,
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                    )));
      }
    });
  }

  //----------PO PREAPPROVAL------------------

  Future PendingPoPreApprovalDetDetails(
      String Url, int RID, String Reqno, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingPo_Approvel_Popup(
                      heading: Url,
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                    )));
      }
    });
  }

//--------------PO APPROVAL-------------------
  Future PendingPoApprovalDetDetails(
      String Url, int RID, String Reqno, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingPo_Approvel_Popup(
                      heading: Url,
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                    )));
      }
    });
  }

  Future poapprovalSupplierlist(
      BuildContext context, matId, String materialname, String scale) async {
    poapprovalSupplierList.clear();
    Searchpoapproval_supplierList.clear();
    await PendingListProvider.getPoapproval_SupplierbuildList_Provider(matId)
        .then((value) async {
      if (value != null && value.length > 0) {
        poapprovalSupplierList = value;
        Searchpoapproval_supplierList.value = poapprovalSupplierList;
        print(poapprovalSupplierList.toString());
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return PoApproval_supplierList_Alert(
                  MaterialId: matId, MaterialName: materialname, Scale: scale);
            });
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future PendingInwardDetDetails(
      String Url, int RID, String Reqno, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingList_InwardPopup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                    )));
        // return showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return PendingInwardPopup(
        //           list: onclickPendingListDet, ReqNo: Reqno);
        //     });
      }
    });
  }

  Future PendingTransferPendingDetDetails(
      String Url, int RID, String Reqno, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingList_TransferPending_Popup(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                    )));
        // return showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return TransferPendingPopup(
        //           list: onclickPendingListDet, ReqNo: Reqno);
        //     });
      }
    });
  }

  Future PendingTransferACKDetails(
      String Url, int RID, String Reqno, BuildContext context) async {
    onclickPendingListDet.clear();
    await PendingListProvider.getOnclickDetProvider(Url, RID)
        .then((value) async {
      if (value != null && value.length > 0) {
        onclickPendingListDet = value;
        print(onclickPendingListDet.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransferAckMaterialList(
                      list: onclickPendingListDet,
                      ReqNo: Reqno,
                    )));
        // return showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return TransferAckPopup(
        //           list: onclickPendingListDet, ReqNo: Reqno);
        //     });
      }
    });
  }

  Future getSubcontractor_ExpensesList(
      String userId, String userType, String name, BuildContext context) async {
    onclickPendingListData.clear();
    mainlist.value.clear();
    await PendingListProvider.getOnclickPendingListProvider(
            userId, userType, name)
        .then((value) {
      if (value != null && value.length > 0) {
        onclickPendingListData = value;
        mainlist.value = onclickPendingListData;
        return name == "MRN VERIFICATION"
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MrnVerfication(
                        onclickPendingListData: onclickPendingListData,
                        heading: name)),
              )
            : name == "MRN VERIFICATION - CIVIL"
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MrnVerfication(
                            onclickPendingListData: onclickPendingListData,
                            heading: name)),
                  )
                : name == "MRN VERIFICATION - HSE"
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MrnVerification_HSE(
                                onclickPendingListData: onclickPendingListData,
                                heading: name)),
                      )
                    : name == "MRN VERIFICATION - INTERIOR"
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MrnVerification_Interior(
                                    onclickPendingListData:
                                        onclickPendingListData,
                                    heading: name)),
                          )
                        : name == "MRN VERIFICATION - MEB"
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MrnVerification_MEB(
                                        onclickPendingListData:
                                            onclickPendingListData,
                                        heading: name)),
                              )
                            : name == "MRN VERIFICATION - PEB"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MrnVerification_PEB(
                                                onclickPendingListData:
                                                    onclickPendingListData,
                                                heading: name)),
                                  )
                                : name == "MRN APPROVAL"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MrnApproval(
                                                onclickPendingListData:
                                                    onclickPendingListData,
                                                heading: name)),
                                      )
                                    : name == "MRN PRE APPROVAL" ||
                                            name == "MRN GM APPROVAL"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MrnPreApproval(
                                                        onclickPendingListData:
                                                            onclickPendingListData,
                                                        heading: name)),
                                          )
                                        : name == "PENDING PO"
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => PendingPO(
                                                        onclickPendingListData:
                                                            onclickPendingListData,
                                                        heading: name)),
                                              )
                                            : name == "MRN DECISION PENDING"
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OnclickPendingList(
                                                                onclickPendingListData:
                                                                    onclickPendingListData,
                                                                heading: name)),
                                                  )
                                                : name ==
                                                        "WORK PRE APPROVAL PENDING"
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                WorkPreApproval(
                                                                    onclickPendingListData:
                                                                        onclickPendingListData,
                                                                    heading:
                                                                        name)),
                                                      )
                                                    : name ==
                                                            "MRN FINAL APPROVAL"
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MrnFinalApproval(
                                                                        onclickPendingListData:
                                                                            onclickPendingListData,
                                                                        heading:
                                                                            name)),
                                                          )
                                                        : name ==
                                                                "PO VERIFICATION"
                                                            ? Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => PoVerification(
                                                                        onclickPendingListData:
                                                                            onclickPendingListData,
                                                                        heading:
                                                                            name)),
                                                              )
                                                            : name ==
                                                                    "PO PREAPPROVAL PENDING"
                                                                ? Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => PoPreApproval(
                                                                            onclickPendingListData:
                                                                                onclickPendingListData,
                                                                            heading:
                                                                                name)))
                                                                : name ==
                                                                        "PO APPROVAL"
                                                                    ? Navigator
                                                                        .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                PoApprovalDesign(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                      )
                                                                    : name ==
                                                                            "INWARD PENDING"
                                                                        ? Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => InwardPending(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                          )
                                                                        : name ==
                                                                                "TRANSFER PENDING"
                                                                            ? Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(builder: (context) => TransferPending(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                              )
                                                                            : name == "TRANSFER ACKNOWLEDGMENT PENDING"
                                                                                ? Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(builder: (context) => TransferACKPending(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                                  )
                                                                                : name == "SUBCONTRACTOR ATTENDANCE APPROVAL"
                                                                                    ? Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (context) => SubContractorAttandance(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                                      )
                                                                                    : name == "COMPANY LABOUR ATTENDANCE APPROVAL"
                                                                                        ? Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(builder: (context) => CompanyLbrAtendance(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                                          )
                                                                                        : name == "SUBCONTRACTOR DPR APPROVAL"
                                                                                            ? Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(
                                                                                                    builder: (context) => SubContDPRApproval(
                                                                                                          onclickPendingListData: onclickPendingListData,
                                                                                                          heading: name,
                                                                                                        )),
                                                                                              )
                                                                                            : name == "SUBCONTRACTOR NMR Bill APPROVAL"
                                                                                                ? Navigator.push(
                                                                                                    context,
                                                                                                    MaterialPageRoute(builder: (context) => SubContNMRBillApproval(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                                                  )
                                                                                                : name == "BILL GENERATION-BOQ APPROVAL"
                                                                                                    ? Navigator.push(
                                                                                                        context,
                                                                                                        MaterialPageRoute(builder: (context) => BillGenBOQAproval(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                                                      )
                                                                                                    : name == "BILL GENERATION-DIRECT APPROVAL"
                                                                                                        ? Navigator.push(
                                                                                                            context,
                                                                                                            MaterialPageRoute(builder: (context) => BillGenDirectAproval(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                                                          )
                                                                                                        : name == "ADVANCE REQUISTION APPROVAL"
                                                                                                            ? Navigator.push(
                                                                                                                context,
                                                                                                                MaterialPageRoute(builder: (context) => AdvanceReqAproval(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                                                              )
                                                                                                            : name == "SUBCONTRACTOR BILL VERIFICATION - NMR"
                                                                                                                ? Navigator.push(
                                                                                                                    context,
                                                                                                                    MaterialPageRoute(builder: (context) => NMRBillVerification(onclickPendingListData: onclickPendingListData, heading: name)),
                                                                                                                  )
                                                                                                                : name == "WORK ORDER APPROVAL PENDING"
                                                                                                                    ? Navigator.push(context, MaterialPageRoute(builder: (context) => WorkOrder(onclickPendingListData: onclickPendingListData, heading: name)))
                                                                                                                    : Navigator.push(context, MaterialPageRoute(builder: (context) => OfficeVoucherApproval(onclickPendingListData: onclickPendingListData, heading: name)));
      }
    });
  }
}
