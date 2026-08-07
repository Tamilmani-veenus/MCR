import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mcr/apimanager/apimanager.dart';
import '../models/punch_filter_response.dart';
import '../models/punch_in_model.dart';
import '../models/today_punch_in_response.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../utilities/apiconstant.dart';
import 'package:http/http.dart' as http;
import '../utilities/baseutitiles.dart';
import '../utilities/print_logger.dart';
import '../utilities/requestconstant.dart';

class PunchInProvider {

  final http.Client _httpClient = http.Client();

  /// Send Request.....

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return _httpClient.send(request);
  }

  /// Punch In provider.....

  static Future<String?> sendSingleImageProvider(PunchInSaveModel data, File imageFile,context) async {
    try {
      Uri uri = Uri.parse(ApiConstant.PUNCH_IN);
      print("Image Sending Uri ::::: $uri");

      var request = http.MultipartRequest("POST", uri);
      dynamic bodyData = data.toJson();
      request.files.add(
        await http.MultipartFile.fromPath(
          'File',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
          filename: 'image.jpeg',
        ),
      );
      for (var field in bodyData.keys) {
        var value = bodyData[field];
        if (value is String) {
          request.fields[field] = value;
        }
      }
      request.headers["content-type"] = "application/json; charset=utf-8";
      final response = await http.Response.fromStream(await request.send());
      print("Request Data :: ${request.fields}");
      print("Request Data :: ${request.files}");
      print("Response Data :: ${response.body}");

      final punchOutRes = PunchOutSaveRes.fromJson(json.decode(response.body));
      return punchOutRes.retString;

    } catch (e) {
      if (kDebugMode) {
        print('Error sending request: $e');
      }
      Navigator.pop(context);
      Get.to(() => DashboardScreen_OtherUser());
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      rethrow;
    }
  }

  /// Punch Out Provider.....

  Future<String?> punchOutProvider(PunchOutUpdate data, File imageFile, context) async {
    try {
      Uri uri = Uri.parse(ApiConstant.PUNCH_OUT);
      print("Image Sending Uri ::::: $uri");

      var request = http.MultipartRequest("PUT", uri);
      dynamic bodyData = data.toJson();
      request.files.add(
        await http.MultipartFile.fromPath(
          'Files',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
          filename: 'image.jpeg',
        ),
      );
      for (var field in bodyData.keys) {
        var value = bodyData[field];
        if (value is String) {
          request.fields[field] = value;
        }
      }
      request.headers["content-type"] = "application/json; charset=utf-8";
      final response = await http.Response.fromStream(await request.send());
      print("Request Data :: ${request.fields}");
      print("Request Data :: ${request.files}");
      print("Response Data :: ${response.body}");

      final punchOutRes = PunchOutSaveRes.fromJson(json.decode(response.body));
      return punchOutRes.retString;

    }
    catch (e) {
      if (kDebugMode) {
        print('Error sending request: $e');
      }
      Navigator.pop(context);
      Get.to(() => DashboardScreen_OtherUser());
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      rethrow;
    }
  }

  /// Today Punch In Provider.....

  Future<TodayPunchInResponse> todayPunchInProvider(String todayDate,String EmpId, String userType) async {
    try {
      Uri uri = Uri.parse("${ApiConstant.TODAY_PUNCHIN_STATUS}?Todate=$todayDate&EmpId=$EmpId&UserType=$userType");
      if (kDebugMode) {
        print(uri.toString());
      }
      String method = "GET";
      http.Request request = http.Request(method, uri);
      request.headers['Content-Type'] = 'application/json';
      http.StreamedResponse streamRes = await send(request);
      http.Response response = await http.Response.fromStream(streamRes);
      await getResponse(response);
      print("Response Data ::  ${uri}");
      if (response.statusCode == 200){
        return TodayPunchInResponse.fromJson(jsonDecode(response.body.toString()));
      }
      else {
        throw Exception('Request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending request: $e');
      }
      rethrow;
    }
  }

  /// Punch in punch out filter Provider.....

  Future<PunchFilterResponse> punchFilterProvider(String fromDate,String toDate,String userType,int empId) async {
    try {
      Uri uri = Uri.parse("${ApiConstant.PUNCH_FILTER_STATUS}?Frdate=$fromDate&Todate=$toDate&UserType=$userType&EmpId=$empId");
      printToLog(uri.toString());
      String method = "GET";
      http.Request request = http.Request(method, uri);
      request.headers['Content-Type'] = 'application/json';
      http.StreamedResponse streamRes = await send(request);
      http.Response response = await http.Response.fromStream(streamRes);
      printToLog("Response Data ::  ${response.body}");
      await getResponse(response);
      if (response.statusCode == 200){
        return PunchFilterResponse.fromJson(jsonDecode(response.body.toString()));
      }
      else {
        throw Exception('Request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      printToLog('Error sending request: $e');
      rethrow;
    }
  }



  static Future getPunchFilterList(String fromDate,String toDate,String userType,int empId) async {
    var data = null;
    await ApiManager.getAPICall("${ApiConstant.PUNCH_FILTER_STATUS}?Frdate=$fromDate&Todate=$toDate&UserType=$userType&EmpId=$empId").then((value) {
      printToLog("PunchResponse: $value");
      data = punchFilterResponseFromJson(value);
      if (data != null) {
        return data;
      }
    }, onError: (error) {
      printToLog(error);
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
            'Error occurred while communication with server with statusCode: ${response.statusCode}');
    }
  }

}