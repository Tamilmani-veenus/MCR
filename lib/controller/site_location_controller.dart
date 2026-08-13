import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mcr/controller/punch_in_controller.dart';
import '../../controller/logincontroller.dart';
import '../../models/set_site_location_response.dart';
import '../../models/site_location_payload.dart';
import '../../utilities/baseutitiles.dart';
import '../constants/storage_constant.dart';
import '../db_model/siteLocation_DB_Model.dart';
import '../db_services/sitelocation_db_services.dart';
import '../models/set_site_location_payload.dart';
import '../models/site_location_response.dart';
import '../newhome/maindashboard/dashboard.dart';
import '../provider/site_location_provider.dart';

class SiteLocationController extends GetxController {
  TextEditingController radius = TextEditingController();
  // TextEditingController siteNameSearch = TextEditingController();
  TextEditingController projectNameSearch = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  // List<SiteLocation>? siteNameList = [];
  List<SiteLocation>? projectNameList = [];

  String? siteName;
  String? punchInAddress = "";
  String? latitude = "";
  String? longitude = "";
  // String? siteId = "";
  String? projectId = "";
  String? locId = "";
  RxString punchInID="0".obs;

  /// Get Site Name.....

  Future<void> getProjectName() async {
    // DateTime current = DateTime.now();
    // String currentDate = DateFormat('yyyy-MM-dd').format(current);
    SiteLocationResponse siteLocationResponse = await SiteLocationProvider().siteLocationProvider(
        loginController.user.value.empId.toString(),
        punchInID.value,
        projectNameSearch.text
      // SiteLocationPayload(
      // projectName: projectNameSearch.text,
      // empId: loginController.user.value.empId.toString(),
      // punchDate:currentDate.toString())
    );
    projectNameList = siteLocationResponse.siteLocation;
    await deleteSiteLocationDetails();
    await saveSiteLocationDetails(siteLocationResponse);
    await getSiteLocationDetails();
  }

  /// Set Site Location .....

  Future<void> setSiteLocation(String pId, String latitude, String longitude) async {
    SetProjectLocation setProjectLocation = await SiteLocationProvider().setSiteLocationProvider(SetSiteLocationPayload(
      entryMode: "ADD",
      projectid: pId.toString(),
      address: punchInAddress,
      deviceName: BaseUtitiles.deviceName,
      latitude: latitude,
      longitude: longitude,
      radius: "0",
      userId: loginController.user.value.userId.toString(),
    ));
    Fluttertoast.showToast(msg: setProjectLocation.retString.toString());
    Get.to(() => const Dashboard_screen());
  }

  /// ----- Local DB handling -----

  var siteLocationInsertData = SiteLocationDBModel();
  var siteLocationservices = SiteLocationService();
  List<SiteLocationDBModel> siteLocationvalues = <SiteLocationDBModel>[];
  SiteLocationResponse siteLocationResponse = SiteLocationResponse();

  /// ----- Local DB Save -----

  saveTable() async {
    siteLocationvalues.clear();
    for (var element in projectNameList!) {
      siteLocationInsertData = SiteLocationDBModel();
      siteLocationInsertData.projectId = element.projectId!.toInt();
      siteLocationInsertData.projectName = element.projectName;
      siteLocationInsertData.pinStatus = element.pinStatus;
      siteLocationInsertData.locid = element.locid!.toInt();
      siteLocationInsertData.radius = element.radius!.toInt();
      siteLocationInsertData.longitude = element.longitude;
      siteLocationInsertData.latitude = element.latitude;
      siteLocationvalues.add(siteLocationInsertData);
    }
    var savedatas = await siteLocationservices.siteLocationTableSave(siteLocationvalues);
    return savedatas;
  }

  /// ----- Login Table Delete -----

  deleteTable() async {
    await siteLocationservices.siteLocationDelete();
  }

  /// ----- Save the site location details -----

  Future<void> saveSiteLocationDetails(SiteLocationResponse siteLocationResponse) async {
    await ServiceLocalDatabaseService.saveSiteLocation(siteLocationResponse, "site");
  }

  /// ----- Get the site location details -----

  Future<void> getSiteLocationDetails() async {
    SiteLocationResponse siteLocationResponse = await ServiceLocalDatabaseService.getSiteLocation("site");
    if (siteLocationResponse.siteLocation != null && siteLocationResponse.siteLocation!.isNotEmpty) {
      if (kDebugMode) {
        print("Site location details :: ${siteLocationResponse.siteLocation![0].projectName}");
      }
      projectNameList = siteLocationResponse.siteLocation;
    }
  }

  /// ----- deleteSiteLocationDetails -----

  Future<void> deleteSiteLocationDetails() async {
    await ServiceLocalDatabaseService.deleteSiteLocationDetails("site");
  }
}
