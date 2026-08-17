import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/bill_genration_direct_entrylist_model.dart';

import '../models/directbill_editapi_res_model.dart';
import '../models/directbill_itemlistdet_resmodel.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class DirectBillGenerateProvider {

  static Future<List<BillDirectentrylist>> getBillDirectEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DIRECTBILL_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate&Type=D")
        .then((value) {
      print("AdvEntryList:" + value);
      data = billDirectentrylistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future getWorkOrderList(
      int pId, int siteId, int subId, int workOrderNo,fromDate,toDate,type) async {
    try {
      final response = await ApiManager.getAPICall(
        "${ApiConstant.GET_WORKORDER_ENTRY_LIST}?PID=$pId&SID=$siteId&SUBID=$subId&WorkOrderId=$workOrderNo&Type=$type&WorkFromdate=$fromDate&WorkTodate=$toDate",
      );

      final data = billDirectWorkOrdDetFromJson(response);

      if (data.isNotEmpty) {
        return data;
      }
      return null;
    } catch (error,e) {
      print(error);
      print(e);
      BaseUtitiles.showToast("${RequestConstant.SOMETHINGWENT_WRONG} $error");
      return null;
    }
  }


  static Future billadv_balance(int pId,int subId, siteId,type,WorkorderId) async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GET_DIRECTBILL_ADVANCE_BALANCE+"?PID=$pId&SubID=$subId&SID=$siteId&Type=$type&WorkorderId=$WorkorderId").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static Future<String?> SaveBillDirectAPI(String body, saveButton,context,entryType) async {
    String? ratingRes;

    try {
      String value;

      if (saveButton == RequestConstant.SUBMIT) {
        value = await ApiManager.postAPICall(
          entryType=="D"?ApiConstant.DIRECTBILL_SAVE_API:ApiConstant.BOQBILL_SAVE_API,
          body,
        );
      } else {
        value = await ApiManager.putUpdateAPIButton(
          entryType=="D"?ApiConstant.PUT_DIRECTBILL_UPDATE_API:ApiConstant.PUT_BOQBILL_UPDATE_API,
          body,
        );
      }

      final response = saveDeduction_SaveResponseFromJson(value);

      if (response.RetString != null) {
        ratingRes = response.RetString;
      }

    } catch (error) {
      print('❌ Error in SaveSubContScreenEntryAPI: $error');
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return null;
    }

    return ratingRes;
  }

  static Future<List<DirectbillEditApiResModel>> directBill_entryList_editAPI(int workId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.EDIT_DIRECTBILL_API + "?WorkId=$workId").then((value) {
      final res = directbillEditApiResModelFromJson(value);
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

  static Future entryList_deleteAPI(int WorkId, int subid, String WorkNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_DIRECTBILL_API +
        "?WorkId=$WorkId&subid=$subid&WorkNo=$WorkNo&UserId=$UserId&DeviceName=$DeviceName")
        .then((value) {
      final res = json.decode(value);
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
}