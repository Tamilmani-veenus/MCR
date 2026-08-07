import 'dart:convert';
import '../apimanager/apimanager.dart';
import '../models/preapproval_entrylist_resmodel.dart';
import '../models/preapproval_typealert_resmodel.dart';
import '../models/preapprovaledit_resmodel.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class PreApprovalProvider{


  static Future<List> getSubcontAttenEntry_List(int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_PREAPPROVALENTRYLIST_API +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("PreApprovalEntryList:" + value);
      data = preAprovalentrylistResmodelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      //BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  static Future<List> getType_List() async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_PREAPPROVALTYPELIST_API)
        .then((value) {
      print("TypeList:" + value);
      data = preapprovalTypeAlertResmodelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      //BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }


  static SaveScreenEntryAPI(String body, int attendId,int aprovedButton) async {
    var ratingRes = null;
    if(attendId!=0){
      if(aprovedButton!=0){
        await ApiManager.putUpdateAPIButton(ApiConstant.PUT_PREAPPROVAL_APPROVE_API, body).then(
                (value) {
              var response = subcontEntryscreenSaveResponseFromJson(value);
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
        await ApiManager.putUpdateAPIButton(ApiConstant.PUT_PREAPPROVAL_UPDATE_API, body).then(
                (value) {
              var response = subcontEntryscreenSaveResponseFromJson(value);
              if (response.RetString != null) {
                ratingRes = response.RetString;
                return ratingRes;
              }
            }, onError: (error) {
          print(error);
          BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
        });
      }

    }
    else{
      await ApiManager.postAPICall(
          ApiConstant.POST_PREAPPROVAL_SAVE_API, body)
          .then((value) {
        var response = subcontEntryscreenSaveResponseFromJson(value);
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


  static Future<List<PreapprovalEditResModel>> entryList_editAPI(
      int preAppID) async {
    var data = null;
    await ApiManager.getAPICall(
        ApiConstant.GET_PREAPPROVAL_EDIT_API +"?PreAppID=$preAppID")
        .then((value) {
      final res = preapprovalEditResModelFromJson(value);
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

  static Future entryList_deleteAPI(
      int PreAppId, String PreAppNo, int userId, String deviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_PREAPPROVAL_ENTRYLIST_API + "?PreAppId=$PreAppId&PreAppNo=$PreAppNo&UserId=$userId&DeviceName=$deviceName")
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