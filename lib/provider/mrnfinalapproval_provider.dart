import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/mrn_stockmaterialwiselist_model.dart';
import '../models/project_name_response.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../splash/splash.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcr/utilities/print_logger.dart';
import '../apimanager/apimanager.dart';
import '../home/pending_list/pending_list.dart';
import '../models/mrn_stockmaterialwiselist_model.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import 'package:http/http.dart' as http;

class MrnFinalApprovalProvider{


  static Future<String?> approveApi(String body,context) async {
    String? ratingRes;

    try {
      final value = await ApiManager.putUpdateAPIButton(
        ApiConstant.PUT_MRNFINALAPPROVAL_APPROVE_API,
        body,
      );
      final response = subcontEntryscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        print(ratingRes);
      }
    } catch (error) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      print(error);
    }

    return ratingRes;
  }

  Future<ProjectNameResponse> projectNameProvider(int matId,int proId) async {
    try {
      Uri uri = Uri.parse("${ApiConstant.PROJECT_NAME}?MatId=$matId&Pid=$proId");
      printToLog(uri.toString());
      String method = "GET";
      http.Request request = http.Request(method, uri);
      request.headers['Content-Type'] = 'application/json';
      http.StreamedResponse streamRes = await send(request);
      http.Response response = await http.Response.fromStream(streamRes);
      printToLog("Response Data ::  ${response.body}");
      return ProjectNameResponse.fromJson(jsonDecode(response.body.toString()));
    } catch (e) {
      printToLog('Error sending request: $e');
      rethrow;
    }
  }

  static Future<String?> preapproveApi(String body,context) async {
    String? ratingRes;

    try {
      final value = await ApiManager.postAPICall(
        ApiConstant.POST_MRNPREAPPROVAL_APPROVE_API,
        body,
      );
      final response = subcontEntryscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        print(ratingRes);
      }
    } catch (error) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return null;
    }

    return ratingRes;
  }



//---------------Get Stock Material Wise---------------
  static Future<List<Stockwisematerialwise>> getStockmaterialWise(int? mid) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSTOCkLISTMATERIALWISE + "?MatId=$mid").then((value) {
      print("StockmaterialWise:" + value);
      data = stockwisematerialwiseFromJson(value);
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