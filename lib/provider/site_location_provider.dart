import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mcr/models/set_site_location_payload.dart';
import 'package:mcr/models/site_location_payload.dart';
import '../apimanager/apimanager.dart';
import '../models/set_site_location_response.dart';
import '../models/site_location_response.dart';
import '../utilities/apiconstant.dart';
import '../utilities/print_logger.dart';

class SiteLocationProvider {

  /// Site Location Name Provider.....

  Future<SiteLocationResponse> siteLocationProvider(String empId,punchId,projectName) async {
    const String contentType = "application/json; charset=utf-8";
    Uri uri = Uri.parse("${ApiConstant.GET_SITE_LOCATION}?EmpId=$empId&PunchId=$punchId&ProjectName=$projectName");
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
    return SiteLocationResponse.fromJson(jsonDecode(response.body.toString()));
  }

  /// Set Site Location Provider.....

  Future<SetProjectLocation> setSiteLocationProvider(SetSiteLocationPayload data) async {
    const String contentType = "application/json; charset=utf-8";
    var bodyData = data.toJson();
    if (kDebugMode) {
      print("Request Data :: $bodyData");
    }
    Uri uri = Uri.parse(ApiConstant.SET_SITE_LOCATION);
    if (kDebugMode) {
      print(uri.toString());
    }
    String method = "POST";
    // var bodyData = data.toJson();
    http.Request request = http.Request(method, uri);
    request.body = jsonEncode(bodyData);
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    if (kDebugMode) {
      print("Request Data :: $bodyData");
      print("Response Data ::  ${response.body}");
    }
    return SetProjectLocation.fromJson(jsonDecode(response.body.toString()));
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