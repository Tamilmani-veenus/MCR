import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/subcont_entryscreen_save_model.dart';
import '../models/tansferbet_getitemlist_resapi_model.dart';
import '../models/transferbet_editapires_model.dart';
import '../models/transferbet_getalldatas_resapi_model.dart';
import '../utilities/requestconstant.dart';

import '../apimanager/apimanager.dart';
import '../models/transferbetweenproject_entrylist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

class TransferBetweenProject_provider{



  static Future<List<TransferbetAlldatasApiRes>> getTransferProj_ALLDatas(int? reqId) async {
    var data = null;
    await ApiManager.getAPICall(
        ApiConstant.GETTRANSALLDATASLIST + "?ReqId=$reqId")
        .then((value) {
      print("TransferAllDatast:" + value);
      data = transferbetAlldatasApiResFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<TransferBProjectentrylist>> getTransprojectEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETTRANSPROJECT_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("TransferprojectEntryList:" + value);
      data = transferBProjectentrylistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<TransferbetItemListApiRes>> getItemList(int? proId, int siteId, int reqId, String type) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETTRANSITEMLIST +
        "?ProjectId=$proId&SiteId=$siteId&ReqId=$reqId&Type=$type")
        .then((value) {
      print("TransferprojectEntryList:" + value);
      data = transferbetItemListApiResFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<String?> transferbet_SaveApi(String body, int id,context) async {
    String? ratingRes;

    try {
      if (id != 0) {
        // UPDATE
        final value = await ApiManager.putUpdateAPIButton(
          ApiConstant.PUT_TRANSFERBET_UPDATE_API,
          body,
        );

        final response = subcontEntryscreenSaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }
      } else {
        // SAVE
        final value = await ApiManager.postAPICall(
          ApiConstant.TRANSFERBET_SAVE_API,
          body,
        );

        final response = subcontEntryscreenSaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }
      }
    } catch (error, stackTrace) {
      debugPrint("transferbet_SaveApi Error: $error");
      debugPrint("StackTrace: $stackTrace");
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }

    return ratingRes;
  }

  static Future<List<TransferbetEditApiRes>> entryList_editAPI(int TransferId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.EDIT_TRANSFERBET_API + "?TransferId=$TransferId").then((value) {
      final res = transferbetEditApiResFromJson(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  static Future entryList_deleteAPI(int TransferId, String TransferNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_TRANSFERBET_API +
        "?TransferId=$TransferId&TransferNo=$TransferNo&UserId=$UserId&DeviceName=$DeviceName")
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


}