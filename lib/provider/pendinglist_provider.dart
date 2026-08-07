import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/dailywrk_done_dpr_itemlist_save_model.dart';
import '../models/mrnfinalapproval_detlistmodel.dart';
import '../models/onclick_pendinglist_model.dart';
import '../models/onclickpendingdet_model.dart';
import '../models/pendinglist_model.dart';
import '../models/poapprovalsupplierlist_model.dart';
import '../models/transferackmateriallist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/print_logger.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../models/trans_ackno_editapi_resmodel.dart';
import '../models/transfer_acknowledgment_alldatas_resapi.dart';
import '../models/transferack_entrylist_resapi.dart';

class PendingListProvider {

  static Future<List<PendingListResponse>> getPendingListProvider(
      String userId, String userType) async {
    List<PendingListResponse> data = [];
    await ApiManager.getAPICall("${ApiConstant.PENDINGLISTAPI}?UserId=$userId&UserType=$userType")
        .then((value) {
      final res = pendingListResponseFromJson(value);
      if (res.isNotEmpty) {
        data = res;
        return data;
      } 
    }, onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
      // BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data.isNotEmpty ? data : [];
  }

  static preapproval_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=app_ord_No&TableName=material_req_app_mas&FormName=MaterialRequestApproval").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static Future<List> getMrnFinalApproval(int ReqMasId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETMRNFINALAPROVALAPI + "?ReqMasId=$ReqMasId").then((value) {
      final res = mrnfinalapprovalDetResModelFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
    });
    return data;
  }

  static Future<List> getMrnPreApproval(int ReqMasId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETMRPREAPROVALAPI + "?ReqMasId=$ReqMasId").then((value) {
      final res = mrnfinalapprovalDetResModelFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
    });
    return data;
  }


  static Future<List<OnclickPendingListResponse>> getOnclickPendingListProvider(String userId, String userType,String name) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETONCLICK_PENDINGLISTAPI + "?Userid=$userId&UserType=$userType&Url=$name").then((value) {
      final res = onclickPendingListResponseFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }


  //-----PO APPROVAL SUPPLIER BUILD LIST API----------
  static Future<List<PoapprovalSupplierbuilldlListModel>> getPoapproval_SupplierbuildList_Provider(int matId) async {
    var data = null;
    await ApiManager.getAPICall(
        ApiConstant.GET_POAPPROVAL_SUPPLIERBUILDLIST_API + "?MatId=$matId").then((value) {
      final res = poapprovalSupplierbuilldlListModelFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    }, onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }


  //----------Transfer Ack Pending------------
  static Future<List<TransferAckMatList>> getTransferAckPending_Provider(int transId) async {
    var data = null;
    await ApiManager.getAPICall(
        ApiConstant.GET_TRANSFERACKPENDING_LIST + "?Transfer_id=$transId").then((value) {
      final res = transferAckMatListFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    }, onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }



  static Future subcontNMR_BillAprovalAPI(body,context) async {
    var ratingRes = null;
        await ApiManager.putUpdateAPIButton(ApiConstant.PUT_SUBCONTNMRBILL_APPROVAL_API, body).then(
                (value) {
              var response = dprItemscreenSaveResponseFromJson(value);
              if (response.RetString != null) {
                ratingRes = response.RetString;
                 BaseUtitiles.showToast(ratingRes);
                return  Navigator.pop(context);
              }
            }, onError: (error) {
          printToLog(error);
          BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
        });
      }

  static Future<void> PoAprovalAPI(body, context) async {
    String? ratingRes;

    try {
      final value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_POAPPROVAL_API, body);

      var response = dprItemscreenSaveResponseFromJson(value);

      if (response.RetString != null) {
        ratingRes = response.RetString;
        BaseUtitiles.showToast(ratingRes!);
        Navigator.pop(context);
      }
    }
  catch (error) {
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      Navigator.pop(context);
    }
  }


  static Future BillGenAprovalAPI(body,context) async {
    var ratingRes = null;
    await ApiManager.putUpdateAPIButton(ApiConstant.PUT_BILLGEN_APPROVAL_API, body).then(
            (value) {
          var response = dprItemscreenSaveResponseFromJson(value);
          if (response.RetString != null) {
            ratingRes = response.RetString;
            BaseUtitiles.showToast(ratingRes);
            return  Navigator.pop(context);
          }
        }, onError: (error) {
      printToLog(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
  }

  static Future AdvanceRequesAprovalAPI(body,context) async {
    var ratingRes = null;
    await ApiManager.putUpdateAPIButton(ApiConstant.PUT_ADVANCEREQ_APPROVAL_API, body).then(
            (value) {
          var response = dprItemscreenSaveResponseFromJson(value);
          if (response.RetString != null) {
            ratingRes = response.RetString;
            BaseUtitiles.showToast(ratingRes);
            return  Navigator.pop(context);
          }
        }, onError: (error) {
      printToLog(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
  }


  static Future<List<TransferacknowAlldatasRes>> TransferAcknowPendingAPI(int TransferId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_TRAACK_PENDING_ALLDATAS_API + "?TransferId=$TransferId").then((value) {
      final res = transferacknowAlldatasResFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }
      //else
      //  BaseUtitiles.showToast("Failed");
    }, onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }


  static transferACk_SaveApi(String body, int id,context) async {
    String? ratingRes;
    try {
      if (id != 0) {
        final value = await ApiManager.putUpdateAPIButton(
          ApiConstant.PUT_TRANSFERACKNOW_UPDATE_API,
          body,
        );
        final response = subcontEntryscreenSaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          print(ratingRes);
        }
      } else {
        final value = await ApiManager.postAPICall(
          ApiConstant.TRANSFER_ACKNOW_ENTRYSAVE,
          body,
        );
        final response = subcontEntryscreenSaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          print(ratingRes);
        }
      }
    }  catch (error) {
      print(error);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }
    return ratingRes;
  }

  static Future<List<TransferAckEntryListApi>> gettransferACk_Entry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_TRAACK_ENTYLIST_API +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      printToLog("TransferprojectEntryList:" + value);
      data = transferAckEntryListApiFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      printToLog(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<TransferAckEditApiRes>> entryList_editAPI(int AckId,int TransferId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.EDIT_TRANSFER_ACKNOW_API + "?AckId=$AckId&TransferId=$TransferId").then((value) {
      final res = transferAckEditApiResFromJson(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      printToLog(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  static Future entryList_deleteAPI(int TransferId,String ackNo,String TransferNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_TRANSACKENTRYLIST_API +
        "?TransferId=$TransferId&AckNo=$ackNo&TransferNo=$TransferNo&UserId=$UserId&DeviceName=$DeviceName")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      printToLog(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  //---Det Icon Details--
  static Future<List<OnclickPendingDet>> getOnclickDetProvider(String Url,int Rid) async {
    var data = null;
    await ApiManager.getAPICall(
        ApiConstant.GETONCLICK_PENDINGLISTDetAPI + "?Url=$Url&RID=$Rid").then((value) {
      final res = onclickPendingDetFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }
      //else
       // BaseUtitiles.showToast("Failed");
    }, onError: (error) {
      printToLog(error);
      printToLog("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }



}
