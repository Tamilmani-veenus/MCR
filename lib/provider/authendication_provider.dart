import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../apimanager/apimanager.dart';
import '../models/authendication_model.dart';
import '../models/changepassword_response_model.dart';
import '../models/getversion_model.dart';
import '../models/punch_in_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';


class AuthendicationProvider {

  static Future<List<User>> getAuthendication(String username, String pass,context) async {
    var data = null;
    await ApiManager.getAPICall("${ApiConstant.AUTHENTICATION}?UserName=$username&Password=$pass").then((value) async{
      final res = authendicationResponseFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      } else {
        Navigator.pop(context);
        BaseUtitiles.showToast("Login Failed");
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      Navigator.pop(context);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<AppVersionResponse>> getVersion() async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETVERSIONAPI).then((value) async{
      final res = appVersionResponseFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error.toString());
      print("Error == ${error.toString()}");
      BaseUtitiles.showToast('Something went wrong.. ${error.toString()}');
    });
    return data;
  }

  /// Get punch in status provider.....

  Future<PunchInSaveRes> getPunchInStatusProvider(String empId) async {
    const String contentType = "application/json; charset=utf-8";
    Uri uri = Uri.parse("${ApiConstant.GET_PUNCHIN_STATUS}?EmpId=$empId");
    print("url...${"${ApiConstant.GET_PUNCHIN_STATUS}?EmpId=$empId"}");
    if (kDebugMode) {
      print(uri.toString());
    }
    String method = "GET";
    http.Request request = http.Request(method, uri);
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    if (kDebugMode) {
      print("Response Data ::  ${response.body}");
    }
    return PunchInSaveRes.fromJson(jsonDecode(response.body.toString()));
  }

  static Future changePassword(String userId, String pass,String deviceName) async {
    var data = null;
    await ApiManager.putAPICall("${ApiConstant.PUTCHANGEPASSWORDAPI}?UserId=$userId&Password=$pass&DeviceName=$deviceName")
        .then((value) {
      final res = changedPasswordResponseFromJson(value);
      if (res.retString != null && res.retString=="Password Changed Successfully...") {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static dynamic getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body.toString();
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

}
