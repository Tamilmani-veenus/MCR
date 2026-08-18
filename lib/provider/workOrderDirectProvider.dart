import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../apimanager/apimanager.dart';
import '../models/billDirectDetCalculation_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/workOrdDirectEntrylist_model.dart';
import '../models/workOrderDirectEdit_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class WorkOrderDirectProvider{

  static Future<List<WorkOrdDirectModel>> getWorkOrdDirectEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_WORKORD_DIRECT_ENTRY_LIST +
        "?Userid=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("AdvEntryList:" + value);
      data = workOrdDirectModelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<BillDirectDetCalculations>> getWorkOrderCalculation_List(
      int subContId,WorkId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DIRECTBILL_CALCULATION_LIST + "?Subcontid=$subContId&WorkId=$WorkId")
        .then((value) {
      print("AddLessCals:" + value);
      data = billDirectDetCalculationsFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<String?> SaveSubContScreenEntryAPI(String body, int workId,context) async {
    String? ratingRes;

    try {
      if (workId != 0) {
        // PUT request
        final value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_WORKORDER_UPDATE_API, body);
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }
      } else {
        // POST request
        final value = await ApiManager.postAPICall(ApiConstant.WORKORD_DIRECT_SAVE_API, body);
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }
        print("Work Order Direct...${response}");
        print("Work Order Direct...${value}");
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

  static Future<WorkOrdDirectEditModel?> workOrder_entryList_editAPI(int workId) async {
    try{
      final value = await ApiManager.getAPICall("${ApiConstant.EDIT_WORKORD_DIRECT_API}?workOrderId=$workId");
      print("AdvEntryList:" + value);
      return workOrdDirectEditModelFromJson(value);
    }
    catch(e,F){
      print("ERROR.....$e");
      print("ERROR.....$F");
      return null;
    }
  }


  static Future entryList_deleteAPI(int WorkId, String WorkNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_WORKORDER_DIRECT_API +
        "?WorkOrderId=$WorkId&WorkOrderNo=$WorkNo&UserId=$UserId&DeviceName=$DeviceName")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        if(data=="Deleted"){
          Fluttertoast.showToast(msg: "Deleted Successfully");
        }else{
          Fluttertoast.showToast(msg: "$data");
        }
        return data;
      }
      print(res);
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

}