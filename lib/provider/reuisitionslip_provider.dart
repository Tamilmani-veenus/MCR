import 'dart:convert';
import '../apimanager/apimanager.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/requisitionslipeditlist_model.dart';
import '../models/requisitionslipentrylist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class RequisitionslipProvider{

  static Future<List<RequisitonSlipEntrylistResponse>> getReqSlipEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETREQUISITIONSLIP_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("ReqSlip:" + value);
      data = requisitonSlipEntrylistResponseFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }
  static SaveReqslipScreenEntryAPI(String body, int reqId) async {
    var ratingRes = null;
    if(reqId!=0){
      await ApiManager.putUpdateAPIButton(ApiConstant.PUT_REQUISITIONSLIP_UPDATE_API, body).then(
              (value) {
            var response = saveDeduction_SaveResponseFromJson(value);
            if (response.RetString != null) {

              ratingRes = response.RetString;
              return ratingRes;
            }
          }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    }
    else{
      await ApiManager.postAPICall(
          ApiConstant.REQUISITION_SAVE, body)
          .then((value) {
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          return ratingRes;
        }
      }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    }
    return ratingRes;
  }




//----Edit---
  static Future<List<RequisitonSlipeditlist>> Requisitionslip_editAPI(int reqId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_REQUISITION_EDIT_API + "?ReqId=$reqId").then((value) {
      final res = requisitonSlipeditlistFromJson(value);
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
  static Future Requisitionslip_entryList_deleteAPI(int reqId, String reqNo,String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_REQUISITION_ENTRYLIST_API + "?ReqId=$reqId&ReqNo=$reqNo&UserId=$UserId&DeviceName=$DeviceName")
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