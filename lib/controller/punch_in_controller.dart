import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import '../controller/site_location_controller.dart';
import '../constants/storage_constant.dart';
import '../models/punch_filter_response.dart';
import '../models/punch_in_model.dart';
import '../models/punch_in_payload.dart';
import '../models/punch_out_payload.dart';
import '../models/today_punch_in_response.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../provider/punch_in_provider.dart';
import '../utilities/baseutitiles.dart';
import 'logincontroller.dart';


class HomeState {

  PunchFilterResponse? _punchFilterResponse;
  PunchFilterResponse? get punchFilterResponse => _punchFilterResponse;

  TodayPunchInResponse? _todayPunchInResponse;
  TodayPunchInResponse? get todayPunchInResponse => _todayPunchInResponse;

  HomeState();
}

class PunchInController extends GetxController with StateMixin<HomeState> {
  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());

  final Rxn<XFile> imageFile = Rxn<XFile>();
  final Rxn<XFile> punchOutImageFile = Rxn<XFile>();
  RxBool isSelect = false.obs;
  String? currentTime = "";
  String? currentDate = "";
  String? networkTime = "";
  String? dayName = "";
  List<EmployeeTimingTodaywise>? todayPunchInList = [];
  List<EmployeeTiming>? punchFilterList = [];
  RxList<EmployeeTiming> punchFilterRxList = <EmployeeTiming>[].obs;
  TextEditingController todayDate = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController punchInRemarks = TextEditingController();
  TextEditingController tomorrowPlanPunchOut = TextEditingController();
  TextEditingController punchOutRemarks = TextEditingController();
  TextEditingController todayTaskPunchOut = TextEditingController();
  TextEditingController todayRpteditingController = TextEditingController();
  List<PunchInPayload> punchInDetails = [];
  List<PunchOutPayload> punchOutDetails = [];
  RxInt isOnDuty=0.obs;
  RxString resPunchSts="false".obs;
  RxString onDutyStatus="false".obs;
  RxString appStatus="false".obs;
  RxString punchInDate="".obs;
  RxString punchInLat="0".obs;
  RxString punchInLon="0".obs;
  RxString punchNo="0".obs;
  RxString punchInAddress="0".obs;
  RxInt selectedRadio=0.obs;
  List<EmployeeTimingTodaywise>? originalList; // Full list from API
  List<EmployeeTimingTodaywise>? filteredList; // List to display based on search

  @override
  void onInit() async {
    super.onInit();
    change(HomeState(), status: RxStatus.success());
  }

  Future<void> getDateAndTime() async {
    DateTime now = DateTime.now();
    currentTime = DateFormat('hh:mm:ss a').format(now);
    currentDate = DateFormat('yyyy-MM-dd').format(now);
    if (kDebugMode) {
      print("Current time :: $currentTime");
      print("Current date :: $currentDate");
    }
  }

  Future<void> getNetworkTime() async {
    DateTime now = await NTP.now();
    currentTime = DateFormat('hh:mm:ss a').format(now);
    currentDate = DateFormat('yyyy-MM-dd').format(now);
    networkTime = DateFormat('dd-MM-yyyy hh:mm a').format(now);
    dayName = DateFormat('EEEE').format(now);
    print("Current time (via NTP): $currentTime");
    print("Current date (via NTP): $currentDate");
    print("Current date (via NTP): $dayName");
  }

  /// ---------- PunchIn Controller -------------

  getOndutyPunchInSts() async {
    await loginController.getPunchInStatus().then((value){
      resPunchSts.value=value.status.toString();
      siteLocationController.punchInID.value=value.punchInId.toString();
      onDutyStatus.value=value.onDutyModelStatus.toString();
      appStatus.value=value.appStatus.toString();
      punchInDate.value=value.punchInDate.toString();
      punchNo.value=value.punchNo.toString();
      selectedRadio.value=0;

      // if(resPunchSts.value=="true" && onDutyStatus.value=="N"){
      //   isOnDuty.value=0;
      // }
      // else if(resPunchSts.value=="true" && onDutyStatus.value=="Y"){
      //   isOnDuty.value=1;
      // }
      // else{
      //   isOnDuty.value=0;
      // }
    });
  }

  Future punchInSave(context) async {
    if(isOnDuty.value==1){
      siteLocationController.locId="0";
    }
    else{
      siteLocationController.locId=siteLocationController.locId.toString();
    }
    final data = await PunchInProvider.sendSingleImageProvider(
        PunchInSaveModel(
            empId: loginController.EmpId().toString(),
            userId: loginController.user.value.userId.toString(),
            dateIn: currentDate.toString(),
            entryMode: "ADD",
            locId:siteLocationController.locId,
            deviceName: BaseUtitiles.deviceName.toString(),
            punchTimeIn: currentTime.toString(),
            IsDuty:isOnDuty.value==1? "Y":"N",
            OnLon:punchInLon.value,
            OnLat:punchInLat.value,
            Onaddres:punchInAddress.value,
            // TimeIn:currentTime.toString(),
            remarks:punchInRemarks.text.toString()
        ),
        File(imageFile.value!.path),context);

    if (data!.isNotEmpty) {
      // selectedRadio.value = isOnDuty.value == 1 ? 1 : 2;
      isOnDuty.value = 0;
      Get.to(() => DashboardScreen_OtherUser());
      getOndutyPunchInSts();
      punchInRemarks.text = "";
      punchInAddress.value = "";
      punchInLon.value = "";
      punchInLat.value = "";
      imageFile.value = null;
      if(data=="Punch In Saved Successfully..."){
        BaseUtitiles.showToast("Punch In Saved Successfully...");
      }else {
        BaseUtitiles.showToast("Something went wrong...");
      }
      return data;
    }
  }

  /// ----- Offline Punch In Controller -----

  // Future offlinePunchInSave(int index) async {
  //   final data = await PunchInProvider.sendSingleImageProvider(
  //       PunchInSaveModel(
  //           empId: punchInDetails[index].empId.toString(),
  //           dateIn: punchInDetails[index].dateIn.toString(),
  //           entryMode: punchInDetails[index].entryMode.toString(),
  //           locId: punchInDetails[index].locId.toString(),
  //           userId: punchInDetails[index].userId.toString(),
  //           deviceName: punchInDetails[index].deviceName.toString(),
  //           punchTimeIn: punchInDetails[index].punchTimeIn.toString()),
  //       File(punchInDetails[index].imagePath.toString()),context);
  //   if (data!.isNotEmpty) {
  //     print("Successfully upload offline punch in details");
  //   }
  // }

  /// ---------- PunchOut Controller -------------

  Future punchOut(context) async {
    await getNetworkTime();
    if(isOnDuty==1){
      siteLocationController.locId="0";
    }
    else{
      siteLocationController.locId=siteLocationController.locId.toString();
    }
    String? data = await PunchInProvider().punchOutProvider(PunchOutUpdate(
      empId: loginController.EmpId().toString(),
      entryMode: "UPDATE",
      userId: loginController.user.value.userId.toString(),
      deviceName: BaseUtitiles.deviceName,
      date: currentDate.toString(),
      timeOut: currentTime.toString(),
      locId:siteLocationController.locId,
      punchInID: siteLocationController.punchInID.value,
      // Time_Out:currentTime.toString(),
      punchOutAddress: punchInAddress.value,
      outLatitude: punchInLat.value,
      outLongitude: punchInLon.value,
      OnDuty: isOnDuty.value==1? "Y" : "N",
      // appStatus: appStatus.value,
      punchInDate: punchInDate.value,
      todayTask: todayTaskPunchOut.text.trim().toString(),
      tomrrowTask: tomorrowPlanPunchOut.text.trim().toString(),
      punchNo: punchNo.value.toString(),
    ),File(punchOutImageFile.value!.path),context);

    if (data!.isNotEmpty) {
      isOnDuty.value=0;
      selectedRadio.value=0;
      Get.to(() => DashboardScreen_OtherUser());
      getOndutyPunchInSts();
      if(data=="Punch Out Updated Successfully.") {
        BaseUtitiles.showToast("Punch Out Saved Successfully...");
      }else{
        BaseUtitiles.showToast("Something went wrong...");
      }
      return data;
    }
  }

  /// ---------- Offline punchOut controller -------------

  // Future offlinePunchOut(int index) async {
  //   String? data = await PunchInProvider().punchOutProvider(PunchOutUpdate(
  //       empId: punchOutDetails[index].empId.toString(),
  //       entryMode: punchOutDetails[index].entryMode.toString(),
  //       userId: punchOutDetails[index].userId.toString(),
  //       deviceName: punchOutDetails[index].deviceName.toString(),
  //       date: punchOutDetails[index].date.toString(),
  //       timeOut: punchOutDetails[index].timeOut.toString(),
  //       locId: punchOutDetails[index].locId.toString()));
  //   if (data!.isNotEmpty) {
  //     print("Successfully upload offline punch out details");
  //   }
  // }

  /// ---------- Today Punch In Controller -------------

  Future<void> todayPunchInController(String todayDate) async {
    HomeState homeState = state!;
    TodayPunchInResponse todayPunchInResponse = await PunchInProvider().todayPunchInProvider(todayDate.toString(),loginController.EmpId(),loginController.user.value.userType.toString());
    homeState._todayPunchInResponse = todayPunchInResponse;
    if (todayPunchInResponse.employeeTimingTodaywise!.isNotEmpty) {
      originalList = todayPunchInResponse.employeeTimingTodaywise;
      filteredList = List.from(originalList!);
      update();
      // todayPunchInList = todayPunchInResponse.employeeTimingTodaywise;
      // update();
    } else {
      BaseUtitiles.showToast("No record found...");
    }
  }

  void filterSearchTodayReport(String value) {
    if (value.isNotEmpty) {
      filteredList = originalList!
          .where((item) =>
      (item.staffName ?? "").toLowerCase().contains(value.toLowerCase()) ||
          (item.punchDetails?.any((detail) =>
          (detail.punchInProjectName ?? "").toLowerCase().contains(value.toLowerCase()) ||
              (detail.punchInTime ?? "").contains(value) ||
              (detail.punchOutProjectName ?? "").toLowerCase().contains(value) ||
              (detail.punchOutTime ?? "").contains(value)) ?? false)
      )
          .toList();
    } else {
      filteredList = List.from(originalList!);
    }
    update(); // or setState if using StatefulWidget
  }


  /// ---------- Punch filter controller -------------

  Future punchFilterController(String fromDate, String toDate, int empId) async {
    HomeState homeState = state!;
    PunchFilterResponse punchFilterResponse = await PunchInProvider().punchFilterProvider(fromDate.toString(), toDate.toString(), loginController.user.value.userType.toString(), empId);
    homeState._punchFilterResponse = punchFilterResponse;
    if (punchFilterResponse.employeeTiming!.isNotEmpty) {
      punchFilterList = punchFilterResponse.employeeTiming;
      punchFilterRxList.value = punchFilterList!;
    } else {
      punchFilterList=[];
      punchFilterRxList.value=[];
      BaseUtitiles.showToast("No record found...");
    }
    return punchFilterList;
  }

  /// ----- Local DB Handling -----

  // PunchInDbModel punchInInsertData = PunchInDbModel();
  // var punchInServices = PunchInDbService();
  // // var punchOutInsertData = PunchOutDbModel();
  // var punchOutServices = PunchOutDbService();

  // ///  ----- Punch In Details Save Local DB -----
  //
  // punchInSaveTable() async {
  //   punchInInsertData = PunchInDbModel();
  //   punchInInsertData.empId = loginController.loginInsert.empId.toString();
  //   punchInInsertData.dateIn = currentDate.toString();
  //   punchInInsertData.entryMode = "ADD";
  //   punchInInsertData.locId = siteLocationController.locId.toString();
  //   punchInInsertData.userId = loginController.loginInsert.userId.toString();
  //   punchInInsertData.deviceName = BaseUtitiles.deviceName.toString();
  //   punchInInsertData.punchTimeIn = currentTime.toString();
  //   punchInInsertData.imagePath = imageFile!.path;
  //   var savedatas = await punchInServices.punchInTableSave(punchInInsertData);
  //   return savedatas;
  // }
  //
  // /// ----- Punch In Details Get Local DB -----
  //
  // Future punchInGetTables() async {
  //   var getValue  = await punchInServices.punchInReadAll();
  //   if(getValue != null){
  //     getValue.forEach((user) {
  //       punchInInsertData = PunchInDbModel();
  //       punchInInsertData.empId = user['empId'];
  //       punchInInsertData.dateIn = user['dateIn'];
  //       punchInInsertData.entryMode = user['entryMode'];
  //       punchInInsertData.locId = user['locId'];
  //       punchInInsertData.userId = user['userId'];
  //       punchInInsertData.deviceName = user['deviceName'];
  //       punchInInsertData.punchTimeIn = user['punchTimeIn'];
  //       punchInInsertData.imagePath = user['imagePath'];
  //     });
  //     return punchInInsertData;
  //   } else {
  //     null;
  //   }
  // }
  //
  // /// ----- Punch In Table Delete -----
  //
  // punchInDeleteTable() async {
  //   await punchInServices.punchInDelete();
  // }
  //
  // ///  ----- Punch Out Details Save Local DB -----
  //
  // punchOutSaveTable() async {
  //   punchOutInsertData = PunchOutDbModel();
  //   punchOutInsertData.empId = loginController.loginInsert.empId.toString();
  //   punchOutInsertData.date = currentDate.toString();
  //   punchOutInsertData.timeOut = currentTime.toString();
  //   punchOutInsertData.entryMode = "UPDATE";
  //   punchOutInsertData.userId = loginController.loginInsert.userId.toString();
  //   punchOutInsertData.deviceName = BaseUtitiles.deviceName;
  //   punchOutInsertData.locId = siteLocationController.locId.toString();
  //   var savedatas = await punchOutServices.punchOutTableSave(punchOutInsertData);
  //   return savedatas;
  // }
  //
  // /// ----- Punch Out Details Get Local DB -----
  //
  // Future punchOutGetTables() async {
  //   var getValue  = await punchOutServices.punchOutReadAll();
  //   if(getValue != null){
  //     getValue.forEach((user) {
  //       punchOutInsertData = PunchOutDbModel();
  //       punchOutInsertData.empId = user['empId'];
  //       punchOutInsertData.date = user['date'];
  //       punchOutInsertData.timeOut = user['timeOut'];
  //       punchOutInsertData.entryMode = user['entryMode'];
  //       punchOutInsertData.userId = user['userId'];
  //       punchOutInsertData.deviceName = user['deviceName'];
  //       punchOutInsertData.locId = user['locId'];
  //     });
  //     return punchOutInsertData;
  //   } else {
  //     null;
  //   }
  // }
  //
  // /// ----- Punch Out Table Delete -----
  //
  // punchOutDeleteTable() async {
  //   await punchOutServices.punchOutDelete();
  // }

  /// ------ Shared preference ------

  /// ----- Stored punch in details values -----

  Future<void> storePunchInDetails() async {
    List<PunchInPayload> existingPunchIns = await ServiceLocalDatabaseService.getPunchInDetails("punchIn") ?? [];
    existingPunchIns.add(PunchInPayload(
      userId: loginController.loginDetails[0].userId.toString(),
      empId: loginController.loginDetails[0].empId.toString(),
      locId: siteLocationController.locId.toString(),
      deviceName: BaseUtitiles.deviceName.toString(),
      entryMode: "ADD",
      dateIn: currentDate.toString(),
      imagePath: imageFile.value!.path,
      punchTimeIn: currentTime.toString(),
    ));
    await ServiceLocalDatabaseService.savePunchInDetails(existingPunchIns, "punchIn");
  }

  /// ----- Get the stored punch In details values -----

  Future<void> getPunchInDetailsShared() async {
    List<PunchInPayload> punchInDetail = await ServiceLocalDatabaseService.getPunchInDetails("punchIn");
    punchInDetails = punchInDetail;
    if (punchInDetails.isNotEmpty) {
      print("Getting values :: ${punchInDetails[0].userId}");
    } else {
      print("No details found");
    }
  }

  /// ----- Delete the stored punchIn details values -----

  Future<void> deletePunchInDetails() async {
    await ServiceLocalDatabaseService.deletePunchInDetails("punchIn");
  }

  /// ----- Stored punch out details values -----

  Future<void> storePunchOutDetails() async {
    List<PunchOutPayload> existingPunchIns = await ServiceLocalDatabaseService.getPunchOutDetails("punchOut") ?? [];
    existingPunchIns.add(PunchOutPayload(
      userId: loginController.loginDetails[0].userId.toString(),
      empId: loginController.loginDetails[0].empId.toString(),
      locId: siteLocationController.locId.toString(),
      deviceName: BaseUtitiles.deviceName.toString(),
      entryMode: "UPDATE",
      date: currentDate.toString(),
      timeOut: currentTime.toString(),
    ));
    await ServiceLocalDatabaseService.savePunchOutDetails(existingPunchIns, "punchOut");
  }

  /// ----- Get the stored punch Out details values -----

  Future<void> getPunchOutDetailsShared() async {
    List<PunchOutPayload> punchOutDetail = await ServiceLocalDatabaseService.getPunchOutDetails("punchOut");
    punchOutDetails = punchOutDetail;
    if (punchOutDetail.isNotEmpty) {
      print("Getting values :: ${punchOutDetail[0].userId}");
    } else {
      print("No details found");
    }
  }

  /// ----- Delete the stored punch out details values -----

  Future<void> deletePunchOutDetails() async {
    await ServiceLocalDatabaseService.deletePunchOutDetails("punchOut");
  }

}
