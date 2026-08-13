import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/billBoqEntryListrespo_model.dart';
import '../models/billDirectDetCalculation_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class BillGenerationBoqProvider{

  static Future<List<BillBoqEntryModel>> getBillBoqEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_BILLBOQ_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate&Type=B")
        .then((value) {
      print("AdvEntryList:" + value);
      data = billBoqEntryModelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future entryList_deleteAPI(int WorkId, int subid, String WorkNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_BILLBOQ_API +
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

}