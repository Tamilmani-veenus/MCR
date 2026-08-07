import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/materialeditresponse_model.dart';
import '../apimanager/apimanager.dart';
import '../models/mrn_request_indent_model.dart';
import '../models/mrnrq_addmat_resmodel.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class Mrn_Req_provider{

  static Future<List<MrNentrylist>> getmrnreqEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETMRNREQUEST_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("MrnReq:" + value);
      data = mrNentrylistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  // -----------Save API------------

  static SaveMaterialScreenEntryAPI(String body, saveButton,context) async {
    String? ratingRes;

    dynamic value;

    try {
      if (saveButton == "Submit") {
        value = await ApiManager.postAPICall(
          ApiConstant.MATERIALREQUEST_SAVE,
          body,
        );
      }
      else if (saveButton == "PreApprove" || saveButton == "GM Approve") {
        value = await ApiManager.putUpdateAPIButton(
          ApiConstant.PUT_MATERIALREQUEST_PREAPPR_API,
          body,
        );
      }
      else {
        value = await ApiManager.putUpdateAPIButton(
          ApiConstant.PUT_MATERIALREQUEST_UPDATE_API,
          body,
        );
      }
      var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }else{
          Navigator.pop(context);
          Navigator.pop(context);
          BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
        }
    }
    catch (error, stackTrace) {
      print("Error in SaveMaterialScreenEntryAPI: $error");
      print(stackTrace);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }

    return ratingRes;
  }

//---Save API---

//----Edit---
  static Future<List<MaterialeditResponse>> Material_IntentList_editAPI(int reqId, int pId, int sId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_MATERIAL_EDIT_API + "?ReqId=$reqId&Pid=$pId&Sid=$sId").then((value) {
      final res = materialeditResponseFromJson(value);
      if (res != null && res.length > 0) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      // BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  //---Delete API----
  static Future Material_entryList_deleteAPI(int reqId, String reqNo,String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_MATERIAL_ENTRYLIST_API + "?ReqId=$reqId&ReqNo=$reqNo&UserId=$UserId&DeviceName=$DeviceName")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        print("$data");
        if(data=="Deleted"){
          Fluttertoast.showToast(msg: "Deleted Successfully");
        }else{
          Fluttertoast.showToast(msg: "$data");
        }
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }


  static Future<List<MrnReqAddMaterialResmodel>> addmatGetQtyApi() async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_MRNREQ_ADD_QTY).then((value) {
      final res = mrnReqAddMaterialResmodelFromJson(value);
      if (res != null && res.length > 0) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

}