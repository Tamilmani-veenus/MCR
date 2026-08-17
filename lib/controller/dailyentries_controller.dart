import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/logincontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/subcont_attendance_det_model.dart';
import '../db_services/subcont_attendance_det_service.dart';
import '../home/menu/daily_entries/subcontractor_attendance_site/subattendance_site_entry.dart';
import '../home/menu/daily_entries/subcontractor_attendance_site/subattendance_site_entry_list.dart';
import '../home/menu/daily_entries/subcontractor_attendance_site/subcontractor_site_category.dart';
import '../home/pending_list/pending_list.dart';
import '../models/get_atten_image.dart';
import '../models/labr_atten_response.dart';
import '../models/subcon_image_payload.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../provider/subcont_attendance_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyEntriesController extends GetxController {
  ProjectController projectController = Get.put(ProjectController());
  PendingListController pendingListController =
  Get.put(PendingListController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController =
  Get.put(SubcontractorController());
  LoginController loginController = Get.put(LoginController());
  // XFile? imageFile;
  // bool isSelected = false;
  // bool isNetSelected = false;
  // String? gettingNetworkImage;


  final AttendDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final RemarksController = TextEditingController();
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final WorkTypeTextController = TextEditingController();

  List<TextEditingController> NosControllers = [];
  List<TextEditingController> OtHrsController = [];
  List<TextEditingController> EntrySCreenNosControllers = [];
  List<TextEditingController> ExtrasControllers = [];
  List<TextEditingController> EvgOtHrsControllers = [];
  List<TextEditingController> EvgOtAmtControllers = [];
  List<TextEditingController> MrngOtHrsControllers = [];
  List<TextEditingController> MrngOtAmtControllers = [];
  List<TextEditingController> EvgExtraAmtControllers = [];
  List<TextEditingController> NetAmtController = [];
  List<TextEditingController> RemarksControllers = [];

  RxList store_ShowList = [].obs;
  RxList<AttendanceDet> getAttendanceDetailsDto = <AttendanceDet>[].obs;
  RxList AttenEtyList = [].obs;
  RxList Entrylist = [].obs;
  String screenCheck = "";
  int checkColor = 0;
  int buttonControl = 0;
  int checklist = 0;

  RxList EditListResDatas = [].obs;
  RxList readListdata = [].obs;
  List subContDetReadList = <SubContDetModel>[];
  var imageFiles = <File>[].obs;
  var gettingNetworkImages = <String>[].obs;
  List<int> imageIds = [];

  late List<SubContDetModel> deleteModelList = <SubContDetModel>[];
  late List<SubContDetModel> subcontModelList = <SubContDetModel>[];
  late List<SubContDetModel> UpdateModelList = <SubContDetModel>[];
  var subContAttendatanceDetService = SubContAttendatanceDetService();
  var subContDetModel = new SubContDetModel();

  int entrycheck = 0;
  int editcheck = 0;
  int attendId = 0;
  int aprovedButton = 0;
  var total_Amount = 0.0;
  var total_Nos = 0.0;

  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxString Day_Night = RequestConstant.D.obs;
  RxString Nmr_Rate = RequestConstant.N.obs;

  Future getShowClickPopList(BuildContext context, int id) async {
    await SubContAttendanceProvider.getShowPopupList(
        subcontractorController.selectedSubcontId.value,
        projectController.selectedProjectId.value)
        .then((value) async {
      if (value != null && value.length > 0) {
        store_ShowList.value = value;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Subcontractor_Site_Category()));
        // return showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (BuildContext context) {
        //       return SubContEntryShowPopup(list: store_ShowList.value);
        //     });
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  saveSubContDetTableDatas(BuildContext context) async {
    int i = 0;
    int j = 0;
    store_ShowList.forEach((element) {
      print(NosControllers[i].value.text);
      if ((double.parse(NosControllers[i].value.text) == 0 ||
          NosControllers[i].value.text.isEmpty) &&
          (double.parse(OtHrsController[i].value.text) == 0 ||
              OtHrsController[i].value.text.isEmpty)) {
      } else {
        subContDetModel = new SubContDetModel();
        subContDetModel.catId = element.categoryId;
        subContDetModel.catName = element.categoryName;
        subContDetModel.wages = element.wages;
        subContDetModel.nos = NosControllers[i].value.text.toString();
        subContDetModel.remarks = "-";
        subContDetModel.siteId = siteController.selectedsiteId.value;
        subContDetModel.Extra = 0.0;
        subContDetModel.MrgOtHrs = double.parse(OtHrsController[i].value.text);
        subContDetModel.MrgOtAmt = OtHrsController[i].value.text != ""
            ? (element.wages / 8) * subContDetModel.MrgOtHrs!
            : 0.0;
        subContDetModel.EvgOtHrs = 0.0;
        subContDetModel.EvgOtAmt = 0.0;
        subContDetModel.EvgExtrsAmt = 0.0;
        subContDetModel.netAmt = ((element.wages *
            double.parse(NosControllers[i].value.text.toString())) +
            subContDetModel.MrgOtAmt);
        subContDetModel.siteName = siteController.Sitename.text;

        readListdata.value.forEach((element) {
          if (element.siteId == subContDetModel.siteId &&
              element.catId == subContDetModel.catId) {
            j = 1;
          }
        });
        if (j == 0) {
          subcontModelList.add(subContDetModel);
        } else {
          j = 0;
        }
      }
      i++;
    });
    var savedatas =
    await subContAttendatanceDetService.SubContDetSave(subcontModelList);
    return Navigator.pop(context, savedatas);
  }

  deleteSubcontDetTableDatas() async {
    await subContAttendatanceDetService.SubContDetdelete();
  }

  Future getDetTablesDatas() async {
    var subCont = await subContAttendatanceDetService.SubContDet_OrderBy();
    subContDetReadList = <SubContDetModel>[];
    subContDetReadList.clear();
    readListdata.value.clear();
    subCont.forEach((user) {
      var subContDetModel = SubContDetModel();
      subContDetModel.catId = user['catId'];
      subContDetModel.catName = user['catName'];
      subContDetModel.wages = user['wages'];
      subContDetModel.nos = user['nos'];
      subContDetModel.MrgOtHrs = user['MrgOtHrs'];
      subContDetModel.MrgOtAmt = user['MrgOtAmt'];
      subContDetModel.EvgOtHrs = user['EvgOtHrs'];
      subContDetModel.EvgOtAmt = user['EvgOtAmt'];
      subContDetModel.EvgExtrsAmt = user['EvgExtrsAmt'];
      subContDetModel.Extra = user['Extra'];
      subContDetModel.netAmt = user['netAmt'];
      subContDetModel.remarks = user['remarks'];
      subContDetModel.siteId = user['siteId'];
      subContDetModel.siteName = user['siteName'];
      subContDetReadList.add(subContDetModel);
      readListdata.value = subContDetReadList;
    });
    getTotalamntAndTotalNos();
    setTextControllersValue();
  }

  setTextControllersValue() async {
    for (var index = 0; index < readListdata.length; index++) {
      textControllersInitiate();
      EntrySCreenNosControllers[index].text = readListdata[index].nos;
      MrngOtHrsControllers[index].text = readListdata[index].MrgOtHrs.toString();
      MrngOtAmtControllers[index].text = readListdata[index].MrgOtAmt.toString();
      EvgOtHrsControllers[index].text = readListdata[index].EvgOtHrs.toString();
      EvgOtAmtControllers[index].text = readListdata[index].EvgOtAmt.toString();
      EvgExtraAmtControllers[index].text = readListdata[index].EvgExtrsAmt.toString();
      ExtrasControllers[index].text = readListdata[index].Extra.toString();
      NetAmtController[index].text = readListdata[index].netAmt.toString();
      RemarksControllers[index].text = readListdata[index].remarks.toString();
    }
  }

  updateSubcontDetValue() async {
    UpdateModelList.clear();
    for (var n = 0; n < readListdata.length; n++) {
      textControllersInitiate();
      subContDetModel = SubContDetModel();
      subContDetModel.catId = readListdata[n].catId;
      subContDetModel.catName = readListdata[n].catName;
      subContDetModel.wages = readListdata[n].wages;
      subContDetModel.nos = EntrySCreenNosControllers[n].value.text.toString();
      subContDetModel.MrgOtHrs = double.parse(MrngOtHrsControllers[n].value.text != "" ? MrngOtHrsControllers[n].value.text : "0");
      subContDetModel.MrgOtAmt = double.parse(MrngOtAmtControllers[n].value.text != "" ? MrngOtAmtControllers[n].value.text : "0");
      subContDetModel.EvgOtHrs = double.parse(EvgOtHrsControllers[n].value.text != "" ? EvgOtHrsControllers[n].value.text : "0");
      subContDetModel.EvgOtAmt = double.parse(EvgOtAmtControllers[n].value.text != "" ? EvgOtAmtControllers[n].value.text : "0");
      subContDetModel.Extra = double.parse(ExtrasControllers[n].value.text != "" ? ExtrasControllers[n].value.text : "0");
      subContDetModel.netAmt = double.parse(NetAmtController[n].value.text != "" ? NetAmtController[n].value.text : "0");
      subContDetModel.EvgExtrsAmt = double.parse(EvgExtraAmtControllers[n].value.text != "" ? EvgExtraAmtControllers[n].value.text : "0");
      subContDetModel.siteId = readListdata[n].siteId;
      subContDetModel.siteName = readListdata[n].siteName.toString();
      subContDetModel.remarks = RemarksControllers[n].value.text;
      UpdateModelList.add(subContDetModel);
    }
    await subContAttendatanceDetService.SubContDetUpdate(UpdateModelList);
  }

  clickEdit() {
    for (var index = 0; index < readListdata.length; index++) {
      textControllersInitiate();
      MrngOtAmtControllers[index].text = ((readListdata[index].wages / 8) * double.parse(MrngOtHrsControllers[index].value.text != "" ? MrngOtHrsControllers[index].value.text : "0")).toString();
      EvgOtAmtControllers[index].text = ((readListdata[index].wages / 8) * double.parse(EvgOtHrsControllers[index].value.text != "" ? EvgOtHrsControllers[index].value.text : "0")).toString();
      NetAmtController[index].text = (readListdata[index].wages * double.parse(EntrySCreenNosControllers[index].value.text != ""
          ? EntrySCreenNosControllers[index].value.text : "0") + (double.parse(ExtrasControllers[index].text != ""
          ? ExtrasControllers[index].text : "0") * double.parse(EntrySCreenNosControllers[index].value.text != ""
          ? EntrySCreenNosControllers[index].value.text : "0")) + double.parse(EvgExtraAmtControllers[index].text != ""
          ? EvgExtraAmtControllers[index].text : "0") + double.parse(MrngOtAmtControllers[index].text != ""
          ? MrngOtAmtControllers[index].text : "0") + double.parse(EvgOtAmtControllers[index].text != ""
          ? EvgOtAmtControllers[index].text : "0")).toString();
    }
    updateSubcontDetValue();
  }

  clearDatas() {
    entrycheck = 0;
    editcheck = 0;
    deleteSubcontDetTableDatas();
    readListdata.value.clear();
    siteController.selectedsiteId.value = 0;
    subcontractorController.selectedSubcontId.value = 0;
    siteController.selectedsitedropdownName = "--Select--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    saveButton.value = RequestConstant.SAVE;
    attendId = 0;
    projectController.selectedProjectId = 0.obs;
    AttendDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    // autoYearWiseNoController.text=autoYearWiseNoController.SubcontAttendance_autoYrsWise.value;
    RemarksController.text = "";
    projectController.projectname.text = RequestConstant.SELECT;
    subcontractorController.Subcontractorname.text = RequestConstant.SELECT;
    subcontractorController.selectedSubcontId.value = 0;
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    WorkTypeTextController.text = "NMR";
    Nmr_Rate.value = RequestConstant.N;
  }

  Future Save_EntryScreen(BuildContext context, int id, int aprovebutton) async {
    buttonControl = 1;
    getAttendanceDetailsDto.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    SubcontEntryScreenSaveRequest formdata = SubcontEntryScreenSaveRequest(
      attenId: id != 0 ? id.toString() : "0",
      attenNo: autoYearWiseNoController.text,
      attenDate: AttendDateController.text,
      totNos: total_Nos.toString(),
      totAmt: total_Amount.toString(),
      projectId: projectController.selectedProjectId.value.toString(),
      subContId: subcontractorController.selectedSubcontId.value.toString(),
      siteId: siteController.selectedsiteId.toString(),
      workType: Nmr_Rate.value,
      shift: Day_Night.value,
      remarks: RemarksController.text,
      preparedby: loginController.EmpId(),
      approvedby: aprovedButton != 0 ? loginController.EmpId() : "0",
      userId: loginController.UserId(),
      EmpId: loginController.EmpId(),
      EntryMode:
      saveButton.value == RequestConstant.SUBMIT
          ? "ADD"
          : saveButton.value == RequestConstant.RESUBMIT
          ? "UPDATE"
          : saveButton.value == "Verify"
          ? "VERIFY"
          : saveButton.value == "Approve"
          ? "APPROVE"
          : "",
      DeviceName: BaseUtitiles.deviceName,
      attendanceDet: getAttendanceDetails(),);
    final list = await SubContAttendanceProvider.SaveSubContScreenEntryAPI(formdata, id, aprovedButton,context,imageFiles);
      if (list != null) {
        if(id!=0){
          deleteSubcontDetTableDatas();
          readListdata.value.clear();
          BaseUtitiles.showToast(list);
          clearDatas();
          if(saveButton.value == RequestConstant.RESUBMIT){
            await getAttenEntryList();
          }else{
            await pendingListController.getPendingList();
          }
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return;
        }else if(list == "Record Saved Successfully..."){
          deleteSubcontDetTableDatas();
          readListdata.value.clear();
          BaseUtitiles.showToast(list);
          await getAttenEntryList();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return;
        }
        else {
            Navigator.pop(context);
            Navigator.pop(context);
            return BaseUtitiles.showToast(list);
        }
      }
  }

  List<AttendanceDet>? getAttendanceDetails() {
    getAttendanceDetailsDto.value.clear();
    checklist = 0;
    for (int index = 0; index < readListdata.length; index++) {
      if (readListdata[index].netAmt > 0) {
        var list = AttendanceDet(
          siteId: readListdata[index].siteId.toString(),
          lbrCatId: readListdata[index].catId.toString(),
          nos: readListdata[index].nos.toString(),
          wages: readListdata[index].wages.toString(),
          detRemarks: readListdata[index].remarks.toString(),
          MOROTHrs: readListdata[index].MrgOtHrs.toString(),
          MOROTAmt: readListdata[index].MrgOtAmt.toString(),
          EVEOTHrs: readListdata[index].EvgOtHrs.toString(),
          ExtraAmt: readListdata[index].EvgExtrsAmt.toString(),
          EVEOTAmt: readListdata[index].EvgOtAmt.toString(),
          TotAmt: readListdata[index].netAmt.toString(),
          Extra: readListdata[index].Extra.toString(),
        );
        getAttendanceDetailsDto.add(list);
      } else {
        checklist = 1;
      }
    }
    return getAttendanceDetailsDto.value;
  }

  getTotalamntAndTotalNos() {
    total_Amount = 0.0;
    total_Nos = 0.0;
    // readListdata.value.forEach((element) {
    //
    //   total_Amount=total_Amount+element.netAmt;
    //   total_Nos=total_Nos+element.nos;
    //
    //   total_Amount += double.parse(readListdata[val].netAmt!.toString());
    //   total_Nos += double.parse(readListdata[val].nos!);
    // });
    for (int val = 0; val < readListdata.length; val++) {
      total_Amount += double.parse(readListdata[val].netAmt!.toString());
      total_Nos += double.parse(readListdata[val].nos!.toString() != "" ? readListdata[val].nos!.toString(): "0");
    }
    print(total_Amount.toString());
    print(total_Nos.toString());
  }

  String getDayorNight(String value) {
    if (value == RequestConstant.DAY) {
      return Day_Night.value = RequestConstant.D;
    } else {
      return Day_Night.value = RequestConstant.N;
    }
  }

  Future getAttenEntryList() async {
    AttenEtyList.value.clear();
    Entrylist.value.clear();
    await SubContAttendanceProvider.getSubcontAttenEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        FromdateController.text,
        TodateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        AttenEtyList.value = value;
        Entrylist.value = AttenEtyList.value;
        return AttenEtyList.value;
      }
    });
  }

  Future deleteParticularList(SubContDetModel data) async {
    deleteModelList.clear();
    subContDetModel = new SubContDetModel();
    subContDetModel.catId = data.catId;
    subContDetModel.siteId = siteController.selectedsiteId.value;
    deleteModelList.add(subContDetModel);
    await subContAttendatanceDetService.SubContDetdeleteById(deleteModelList);
  }

  Future subContEntryList_DeleteApi(int attendId, String attendNo) async {
    await SubContAttendanceProvider.subcont_entryList_deleteAPI(
        attendId,
        attendNo,
        loginController.user.value.userId!,
        BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  Future subContEntryList_EditApi(
      int attendId, BuildContext context, int check) async {
    check != 0 ? aprovedButton = 1 : aprovedButton = 0;
    await SubContAttendanceProvider.subcont_entryList_editAPI(attendId).then((value) async {
      if (value != null && value.length > 0) {
        editcheck = 1;
        EditListResDatas.value = value;
        editSaveDetTable();
        getDetTablesDatas();
        await gettingImage(attendId,"Subcont Attendance");
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubattendanceSiteEntry()),
        );
      }
    });
  }

  Future editSaveDetTable() async {
    subcontModelList.clear();
    EditListResDatas.forEach((element) {
      element.attendanceDet.forEach((val) {
        subContDetModel = new SubContDetModel();
        subContDetModel.catId = val.lbrCatId;
        subContDetModel.catName = val.categoryName;
        subContDetModel.wages = val.wages;
        subContDetModel.nos = val.nos.toString();
        subContDetModel.MrgOtHrs = val.MOROTHrs!;
        subContDetModel.MrgOtAmt = val.MOROTAmt!;
        subContDetModel.EvgOtHrs = val.EVEOTHrs!;
        subContDetModel.EvgOtAmt = val.EVEOTAmt!;
        subContDetModel.Extra = val.Extra!;
        subContDetModel.netAmt = val.TotAmt!;
        subContDetModel.EvgExtrsAmt = val.ExtraAmt!;
        subContDetModel.remarks = val.detRemarks;
        subContDetModel.siteId = val.siteId;
        subContDetModel.siteName = val.siteName;
        subcontModelList.add(subContDetModel);
      });
    });
    var savedatas =
    await subContAttendatanceDetService.SubContDetSave(subcontModelList);
    return savedatas;
  }

  String ButtonChanges(int id, int aproval) {
    if (id != 0) {
      if (aproval != 0)
        return saveButton.value = RequestConstant.APPROVAL;
      else
        return saveButton.value = RequestConstant.RESUBMIT;
    } else
      return saveButton.value = RequestConstant.SUBMIT;
  }

  textControllersInitiate() {
    EntrySCreenNosControllers.add(TextEditingController());
    NetAmtController.add(TextEditingController());
    NosControllers.add(TextEditingController());
    OtHrsController.add(TextEditingController());
    ExtrasControllers.add(TextEditingController());
    EvgOtHrsControllers.add(TextEditingController());
    EvgOtAmtControllers.add(TextEditingController());
    MrngOtHrsControllers.add(TextEditingController());
    MrngOtAmtControllers.add(TextEditingController());
    EvgExtraAmtControllers.add(TextEditingController());
    RemarksControllers.add(TextEditingController());
  }

  nosAndothrsZerovalueset(List list) {
    int index = 0;
    list.forEach((element) {
      textControllersInitiate();
      NosControllers[index].text = "0";
      OtHrsController[index].text = "0";
      index++;
    });
  }

  Future DeleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          entrycheck = 0;
                          editcheck = 0;
                          deleteSubcontDetTableDatas();
                          readListdata.value.clear();
                          subContEntryList_DeleteApi(
                              Entrylist.value[index].subcontLabrAttnId,
                              Entrylist.value[index].labrAttnNo);
                          Entrylist.removeAt(index);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// --------- Subcontractor image Controller -------------


  bool isSelected = false;
  bool isNetSelected = false;
  String? gettingNetworkImage;
  int? imageId;


  // Future subContractorImageSend() async {
  //   final data = await SubContAttendanceProvider.sendSingleImageProvider(
  //       SubConImagePayload(
  //         entryMode: "ADD",
  //         labrAttnId: attendId.toString(),
  //         labrAttnN0: autoYearWiseNoController.text,
  //       ),
  //       File(imageFile!.path));
  //   if (data.isNotEmpty) {
  //     BaseUtitiles.showToast("Image Saved Successfully...");
  //     if (kDebugMode) {
  //       print("Response Data :: $data");
  //       print(data);
  //     }
  //     return data;
  //   }
  // }
  //
  // Future subContractorUpdateImageSend() async {
  //   final data = await SubContAttendanceProvider.sendSingleImageProvider(
  //       SubConImagePayload(
  //         entryMode: "UPDATE",
  //         labrAttnId: attendId.toString(),
  //         labrAttnN0: autoYearWiseNoController.text,
  //       ),
  //       File(imageFile!.path));
  //   if (data.isNotEmpty) {
  //     BaseUtitiles.showToast("Image Saved Successfully...");
  //     return data;
  //   }
  // }

  /// Getting image.....

  Future<void> gettingImage(int? vocId,from) async {
    try {
      final getAttenImage =
      await SubContAttendanceProvider().gettingImageProvider(vocId,0,from);

      // clear previous images
      gettingNetworkImages.clear();
      imageIds.clear();

      if (getAttenImage.imageView != null && getAttenImage.imageView!.isNotEmpty) {
        for (var img in getAttenImage.imageView!) {
          if (img.imageUrl != null && img.imageUrl!.isNotEmpty) {
            gettingNetworkImages.add(img.imageUrl!);
            imageIds.add(img.imageId!);
          }
        }
      }

      print("✅ Network Images: $gettingNetworkImages");
      print("✅ Image IDs: $imageIds");
    } catch (e) {
      print("❌ Error fetching images: $e");
      gettingNetworkImages.clear();
      imageIds.clear();
    }
  }


  /// Delete image.....

  Future<void> deletingImage(int imageId,from) async {
    await SubContAttendanceProvider().deleteImageProvider(imageId,from);
  }

}
