import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../apimanager/apimanager.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../models/tansferbet_getitemlist_resapi_model.dart';
import '../models/transbet_site_entrylistmodel.dart';
import '../models/transferbet_site_editapi_resmodel.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class TransferBetSiteProvider{

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

  static transferbet_Site_SaveApi(String body, int id,context) async {
    String? ratingRes;

    try {
      if (id != 0) {
        final value = await ApiManager.putUpdateAPIButton(
          ApiConstant.PUT_TRANSFERBET_SITE_UPDATE_API,
          body,
        );
        final response = subcontEntryscreenSaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        } else{
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
        }
      } else {
        final value = await ApiManager.postAPICall(
          ApiConstant.TRANSFERBET_SITE_SAVE_API,
          body,
        );
        final response = subcontEntryscreenSaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }
        else{
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
        }
      }
    } catch (error) {
      print(error);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }
    return ratingRes;
  }


  static Future<List<TransferBetSiteEntrylistResapi>> get_Entry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_TRANSBETSITE_ENTRYLIST + "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("TransferSiteEntryList:" + value);
      data = transferBetSiteEntrylistResapiFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }



  static Future<List<TransferbetSiteEditApiResmodel>> entryList_editAPI(int TransferId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.EDIT_TRANSFERBET_SITE_API + "?TransferId=$TransferId").then((value) {
      final res = transferbetSiteEditApiResmodelFromJson(value);
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
    await ApiManager.deleteAPICall(ApiConstant.DELETE_TRANSFERBET_SITE_API +
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