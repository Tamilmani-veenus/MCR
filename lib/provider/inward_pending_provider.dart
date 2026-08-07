import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mcr/models/inwardimageres_model.dart';
import 'package:path/path.dart';
import '../models/getting_image_response.dart';
import '../models/image_delete_response.dart';
import '../models/image_payload.dart';
import '../models/inward_pending_alldatasres_model.dart';
import '../models/inwardpending_editapi_res_model.dart';
import '../models/inwardpending_save_apireq_model.dart';
import '../models/inwardpoamd_model.dart';
import '../models/poamdapproveres_model.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/requestconstant.dart';
import '../apimanager/apimanager.dart';
import '../models/inward_pending_entrylist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

class Inward_Pending_provider {

  static Future<List<InwardAllDatasaRes>> getInward_ALLDatas(int? PoId) async {
    var data = null;
    await ApiManager.getAPICall(
        ApiConstant.GETMATERIALINWARD_ALLDATAS + "?PoId=$PoId")
        .then((value) {
      print("InwardAllDatast:" + value);
      data = inwardAllDatasaResFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<Inwardentrylist>> getInwardEntry_List(int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETINWARD_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("InwardEntryList:" + value);
      data = inwardentrylistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  /// -----Po Amendment List-----------

  static Future<List<PoAmendmentList>> getPoAmendment(int purOrdId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_POAMENDMENT_LIST + "?PurOrdId=$purOrdId").then((value) {
      print("PoAmendment_List:" + value);
      data = poAmendmentListFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      // BaseUtitiles.showToast(error);
    });
    return data;
  }

  /// ----------PoAmendment Approval API-----------

  static Future<String?> inward_PoAmendment_ApprovalAPI(String body,context) async {
    String? ratingRes;

    try {
      final value = await ApiManager.postAPICall(
        ApiConstant.POAMENDMENT_APPROVAL_SAVEAPI,
        body,
      );

      final response = poAmendmentApproveSaveResModelFromJson(value);

      if (response.retString != null) {
        ratingRes = response.retString;
      }
    } catch (error, stackTrace) {
      debugPrint("inward_PoAmendment_ApprovalAPI Error: $error");
      debugPrint("StackTrace: $stackTrace");
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }

    return ratingRes;
  }

  // static inward_Save(String body, int id,  int buttonControl) async {
  //   var ratingRes = null;
  //   if(id!=0){
  //     await ApiManager.putUpdateAPIButton(ApiConstant.PUT_INWARDPENDING_UPDATE_API, body).then(
  //             (value) {
  //           var response = subcontEntryscreenSaveResponseFromJson(value);
  //           if (response.RetString != null) {
  //             ratingRes = response.RetString;
  //             return ratingRes;
  //           }
  //         }, onError: (error) {
  //       print(error);
  //       buttonControl=0;
  //       BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //     });
  //   }
  //   else{
  //     await ApiManager.postAPICall(
  //         ApiConstant.INWARDPENDING_SAVE_API, body)
  //         .then((value) {
  //       var response = subcontEntryscreenSaveResponseFromJson(value);
  //       if (response.RetString != null) {
  //         ratingRes = response.RetString;
  //         return ratingRes;
  //       }
  //     }, onError: (error) {
  //       print(error);
  //       buttonControl=0;
  //       BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //     });
  //   }
  //   return ratingRes;
  // }

  static Future<String?> inward_Save(int id, InwardPendingSaveReq data, List<File> imagesPath,context) async {
    var request;
    String url;
    if (id != 0) {
      url = ApiConstant.PUT_INWARDPENDING_UPDATE_API;
      request = http.MultipartRequest('PUT', Uri.parse(url));
    } else {
      url = ApiConstant.INWARDPENDING_SAVE_API;
      request = http.MultipartRequest('POST', Uri.parse(url));
    }
    if (kDebugMode) {
      print('Calling API: $url');
    }
    Map<String, dynamic> bodyData = data.toJson();
    bodyData.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    if (data.files != null) {
      for (File file in data.files!) {
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

    print("Request Fieldsttt: ${request.fields}");
    // print("Request Filesttt: ${request.files.map((f) => f.filename).toList()}");

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        print('Response: $jsonResponse');
        var res = InwardImageRes.fromJson(jsonResponse);
        print('Response data: ${res.retString}');
        return res.retString;
      } else {
        // dailyEntriesController.buttonControl = 0;
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
        return null;
      }
    }  catch (e) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      print('Exception: $e');
      return null;
    }
  }

  // static Future<List<InwardPendingEditApiRes>> entryList_editAPI(int inwardId,String type) async {
  //   var data = null;
  //   await ApiManager.getAPICall(ApiConstant.EDIT_INWARDPENDING_API + "?InwardId=$inwardId&InwType=$type").then((value) {
  //     final res = inwardPendingEditApiResFromJson(value);
  //     if (res != null) {
  //       data = res;
  //       return data;
  //     }
  //   }, onError: (error) {
  //     print(error);
  //     BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
  //   });
  //   return data;
  // }
  static Future<InwardPendingEditApiRes?> entryListeditAPI(int inwardId, String type) async {
    InwardPendingEditApiRes? data;
    try {
      String url = "${ApiConstant.EDIT_INWARDPENDING_API}?InwardId=$inwardId&InwType=$type";
      String value = await ApiManager.getAPICall(url);

      // Parse the response
      final res = inwardPendingEditApiResFromJson(value);
      if (res != null) {
        data = res;
        if(res.status != "1"){
          BaseUtitiles.showToast("${res.status}");
        }
        print("Result: ${res.result}");
        print("Status: ${res.status}");
      }
    } catch (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG + error.toString());
    }
    return data;
  }


  static Future entryList_deleteAPI(int InwId, String InwNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall("${ApiConstant.DELETE_INWARDPENDINGLIST_API}?InwId=$InwId&InwNo=$InwNo&UserId=$UserId&DeviceName=$DeviceName").then((value) {
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

  // static Future imagePostAPICall(List<File> imagesPath) async {
  //
  //   try {
  //     var request = http.MultipartRequest('POST', Uri.parse(ApiConstant.INWARDIMAGE_SAVEAPI));
  //     print("Calling API: ${ApiConstant.INWARDIMAGE_SAVEAPI}");
  //
  //     for (var image in imagesPath) {
  //       var multipartFile = http.MultipartFile(
  //         'file',
  //         image.openRead(),
  //         image.lengthSync(),
  //         filename: image.path.split('/').last,
  //         contentType: MediaType('image', 'jpeg'),
  //       );
  //       request.files.add(multipartFile);
  //     }
  //
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       // return response.stream.toList();
  //       return response.stream;
  //     } else {
  //       throw Exception('Failed to upload images: ${response.reasonPhrase}');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   }
  //
  // }

  /// Sending multiple image provider.....

  Future<InwardImageRes> sendMultipleImageProvider(ImagePayload data,List<File> imagesPath) async {
    const String contentType = "application/json; charset=utf-8";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(ApiConstant.INWARDIMAGE_SAVEAPI));
      if (kDebugMode) {
        print("Calling API: ${ApiConstant.INWARDIMAGE_SAVEAPI}");
      }
      Map<String, dynamic> bodyData = data.toJson();
      for (var i = 0; i < imagesPath.length; i++) {
        print("Index value :: $i");
        var imageFile = imagesPath[i];
        request.files.add(
          await http.MultipartFile.fromPath(
            'File',
            imageFile.path,
            contentType: MediaType('image', 'jpeg'),
            filename: 'image_$i.jpeg',
          ),
        );
      }
      for (var field in bodyData.keys) {
        var value = bodyData[field];
        if (value is String || value is num) {
          request.fields[field] = value.toString();
        }
      }
      request.headers["content-type"] = contentType;
      var response = await http.Response.fromStream(await request.send());
      if (kDebugMode) {
        print("Request Data :: ${request.fields}");
        print("Request Data :: ${request.files}");
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Status code ::: ${response.statusCode}");
        }
        await getResponse(response);
        return InwardImageRes.fromJson(jsonDecode(response.body.toString()));
      } else if(response.statusCode == 500) {
        if (kDebugMode) {
          print("Status code ::: ${response.statusCode}");
        }
        await getResponse(response);
        throw Exception('Failed to upload images: ${response.reasonPhrase}');
      } else {
        await getResponse(response);
        throw Exception('Failed to upload images: ${response.reasonPhrase}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  /// Getting multiple image provider.....

  Future<GettingImage> gettingImageProvider(int inWardId) async {
    const String contentType = "application/json; charset=utf-8";
    Uri uri = Uri.parse("${ApiConstant.GET_IMAGE_LIST}?Inward_id=$inWardId");
    print(uri.toString());
    String method = "GET";
    http.Request request = http.Request(method, uri);
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    print("Response Data ::  ${response.body}");
    return GettingImage.fromJson(jsonDecode(response.body.toString()));
  }

  /// Delete image provider.....

  Future<ImageDelete> deleteImageProvider(int imageId) async {
    const String contentType = "application/json; charset=utf-8";
    Uri uri = Uri.parse("${ApiConstant.DELETE_IMAGE_API }?ImageId=$imageId");
    print(uri.toString());
    String method = "DELETE";
    http.Request request = http.Request(method, uri);
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    print("Response Data ::  ${response.body}");
    return ImageDelete.fromJson(jsonDecode(response.body.toString()));
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
