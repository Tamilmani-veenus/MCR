import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../apimanager/apimanager.dart';
import '../models/consumption_edit_model.dart';
import '../models/consumption_entrylisy_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/stock_material_model.dart';

import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class Consumption_provider{

  static Future<List<Consumptionentrylist>> getConsumption_Entry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETCONSUMPTION_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("ConsumptionEntryList:" + value);
      data = consumptionentrylistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }
  //--------StockMaterial-------
  static Future<List<Stockmaterial>> getStockmaterial(
      int? pid, int? sid) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSTOCKMATERIALLIST +
        "?ProjectId=$pid&SiteId=$sid")
        .then((value) {
      print("Stockmaterial:" + value);
      data = stockmaterialFromJson(value);
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

  static SaveConumScreenEntryAPI(String body, int UsageId,context) async {
    String? ratingRes;

    try {
      dynamic value;

      if (UsageId != 0) {
        // Update API
        value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_Conum_UPDATE_API, body);
      } else {
        // Save API
        value = await ApiManager.postAPICall(ApiConstant.CONSUM_SAVE, body);
      }

      var response = saveDeduction_SaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
      }

    }  catch (error) {
      print('❌ Error in SaveConumScreenEntryAPI: $error');
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }
    return ratingRes;
  }

  //---Save API---

  static Future<List<ConumEditResponse>> Consum_entryList_editAPI(int UsageId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_CONSUM_EDIT_API + "?UsageId=$UsageId").then((value) {
      final res = conumEditResponseFromJson(value);
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



  //---Delete API----
  static Future Consum_entryList_deleteAPI(int UsageId, String UsageNo,String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_CONSUM_ENTRYLIST_API + "?UsageId=$UsageId&UsageNo=$UsageNo&UserId=$UserId&DeviceName=$DeviceName")
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