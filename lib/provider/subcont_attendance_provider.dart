import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mcr/models/get_atten_image.dart';
import 'package:mcr/models/labr_atten_response.dart';
import 'package:mcr/models/subcon_image_payload.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../apimanager/apimanager.dart';
import '../models/punch_in_model.dart';
import '../models/subcont_attendance_etrylistresponse_model.dart';
import '../models/subcont_attendentrylist_editresponse.dart';
import '../models/subcont_entry_showclick_model.dart';

import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class SubContAttendanceProvider {
  static Future<List<SubContEntryShowResponse>> getShowPopupList(
      int subId, int projectId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONT_ENTRY_SHOW_CLICK +
            "?id=$subId&PID=$projectId")
        .then((value) {
      print("SubContEntryShowClick:" + value);
      data = subContEntryShowFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
    return data;
  }

  static Future<dynamic> SaveSubContScreenEntryAPI(
      SubcontEntryScreenSaveRequest data, int attendId, int aprovedButton,context,imagesPath) async {
    String url;
    var request;

    // Determine the URL and HTTP method based on attendId and approvedButton
    if (attendId != 0) {
      if(aprovedButton != 0){
        url = ApiConstant.PUT_UPPDATE_API;
        request = http.MultipartRequest('PUT', Uri.parse(url));
      }else{
        url = ApiConstant.PUT_UPPDATE_API;
        request = http.MultipartRequest('PUT', Uri.parse(url));
      }
    }
    else {
      url = ApiConstant.SUBCONTLABATTAENDANCE_SAVE_API;
      request = http.MultipartRequest('POST', Uri.parse(url));
    }

    if (kDebugMode) {
      print('Calling API: $url');
    }

    // Adding fields to the request
    Map<String, dynamic> bodyData = data.toJson();
    bodyData.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    // Convert attendanceDet to JSON and add to request fields
    if (data.attendanceDet != null && data.attendanceDet!.isNotEmpty) {
      request.fields['AttendanceDet'] = json.encode(data.attendanceDet!.map((item) => item.toJson()).toList());
    }

    // Add image files if not null
      if (imagesPath.isNotEmpty) {
        for (File file in imagesPath) {
          var stream = http.ByteStream(file.openRead());
          var length = await file.length();
          var multipartFile = http.MultipartFile(
            'Files',
            stream,
            length,
            filename: basename(file.path),
            contentType: MediaType('image', 'jpeg'),
          );
          request.files.add(multipartFile);
        }
      }

    if (kDebugMode) {
      print("Request Fields: ${request.fields}");
      // print("AttendanceDet Request Field: ${request.fields['AttendanceDet']}");
      print("Request Files: ${request.files.map((f) => f.filename).toList()}");
    }

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      if (kDebugMode) {
        print('ResponseData: $jsonResponse');
      }
      if (response.statusCode == 200) {
        var res = SubcontEntryscreenSaveResponse.fromJson(jsonResponse);
        if (kDebugMode) {
          print('Response data: ${res.RetString}');
        }
        return res.RetString;
      } else {
        // dailyEntriesController.buttonControl = 0;
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
        return null;
      }

    }
    catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return null;
    }
  }
  static Future<List<SubContAttendanceEntrylistRes>> getSubcontAttenEntry_List(int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONT_ATTEN_ENTRY_LIST +
            "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("AttendanceEntryList:" + value);
      data = subContattendanceEntrylistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      // BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  static Future subcont_entryList_deleteAPI(
      int attendId, String attendNo, int userId, String deviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_SUBCONT_ENTRYLIST_API + "?AttenId=$attendId&AttenNo=$attendNo&UserId=$userId&DeviceName=$deviceName").then((value) {
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

  static Future<List<SubContAttendEntryListEditRes>> subcont_entryList_editAPI(
      int attendId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.EDIT_SUBCONT_ENTRYLIST_API + "?AttenId=$attendId").then((value) {
      final res = subContAttendEntryListEditResFromJson(value);
      if (res != null && res.length > 0) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      // BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  /// SubContractor Image provider.....

  // static Future<String> sendSingleImageProvider(SubConImagePayload data, File imageFile) async {
  //   try {
  //     Uri uri = Uri.parse(ApiConstant.SUBIMAGE_SAVEAPI);
  //     var request = http.MultipartRequest("POST", uri);
  //     dynamic bodyData = data.toJson();
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'File',
  //         imageFile.path,
  //         contentType: MediaType('image', 'jpeg'),
  //         filename: 'image.jpeg',
  //       ),
  //     );
  //     for (var field in bodyData.keys) {
  //       var value = bodyData[field];
  //       if (value is String) {
  //         request.fields[field] = value;
  //       }
  //     }
  //     request.headers["content-type"] = "application/json; charset=utf-8";
  //     final response = await http.Response.fromStream(await request.send());
  //     print("Request Data :: ${request.fields}");
  //     print("Request Data :: ${request.files}");
  //     print("Response Data :: ${response.body}");
  //     if (response.statusCode == 200){
  //       var punchInSaveRes = PunchInSaveRes(retString: response.body.toString());
  //       String ratingRes = punchInSaveRes.toString();
  //       await getResponse(response);
  //       return ratingRes;
  //     }
  //     else {
  //       await getResponse(response);
  //       throw Exception('Request failed with status code ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error sending request: $e');
  //     }
  //     rethrow;
  //   }
  // }

  /// Getting multiple image provider.....

  Future<GetAttenImage> gettingImageProvider(labId,dprId,from) async {
    const String contentType = "application/json; charset=utf-8";
    String url;
    if(from=="Subcont Attendance"){
      url = "${ApiConstant.GET_ATTEN_IMAGE_LIST}?LabrAttn_Id=$labId";
    }
    else{
      url = "${ApiConstant.GET_DPR_IMAGE_LIST}?DprId=$dprId";
    }
    print(url.toString());
    String method = "GET";
    http.Request request = http.Request(method, Uri.parse(url));
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    print("Response Data ::  ${response.body}");
    return GetAttenImage.fromJson(jsonDecode(response.body.toString()));
  }


  /// Delete image provider.....

  Future<LabrAttenResponse> deleteImageProvider(int imageId,from) async {
    const String contentType = "application/json; charset=utf-8";
    String url;
    if(from=="Subcont Attendance"){
      url="${ApiConstant.LABR_ATTEN_IMAGE_DELETE}?ImageId=$imageId";
    }
    else{
      url="${ApiConstant.DPR_IMAGE_DELETE}?ImageId=$imageId";
    }
    print(url.toString());
    String method = "DELETE";
    http.Request request = http.Request(method, Uri.parse(url));
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    if (response.statusCode == 200) {
      // ✅ Show success toast here
      BaseUtitiles.showToast("Image deleted successfully");
    }
    print("Response Data ::  ${response.body}");
    return LabrAttenResponse.fromJson(jsonDecode(response.body.toString()));
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
