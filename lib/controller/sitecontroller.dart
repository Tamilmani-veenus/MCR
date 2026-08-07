

import 'package:mcr/controller/reports_controller.dart';

import '../controller/projectcontroller.dart';
import '../home/mrn_report/mrn_popup.dart';
import '../home/pdf_generate/pdf_model/pdfmodel.dart';
import '../models/mrnreq_tracker_reportmodel.dart';
import '../provider/common_provider.dart';
import '../provider/reports_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';

class SiteController extends GetxController{
  final Sitename=new TextEditingController();
  RxList getSiteDropdownvalue = [].obs;
  RxList mainlist=[].obs;
  RxList siteDropdownName = [].obs;
  RxInt selectedsiteId = 0.obs;
  RxString selectedsitedropdownName = "".obs;
  ProjectController projectController=Get.put(ProjectController());
  ReportsController reportsController = Get.put(ReportsController());
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  RxList mrnListValue=[].obs;
  RxList<ReqTrackResult> mrnReqTrackerListValue = <ReqTrackResult>[].obs;
  List <PdfListModel> getMNRList_Pdf = <PdfListModel>[];
  RxList selctListDatas = [].obs;
  int checkColor = 0;

  Future getMrnReqTrackerList() async {
    mrnReqTrackerListValue.value=[];
    final value = await ReportsProvider.getMrnReqTrackerRptList(
        reportsController.selectedProjectId.value,
        reportsController.selectedsiteId.value,
        reportsController.materialDropdowntId.value,
        FromdateController.text,
        TodateController.text);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          mrnReqTrackerListValue.value = value.result!;
        } else {
          BaseUtitiles.showToast(value.message ?? "No Data Found");
        }
      } else {
        BaseUtitiles.showToast(value.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future subcontEntry_siteDropdowntList(BuildContext context,int editvalue) async {
    getSiteDropdownvalue.value.clear();
    getSiteDropdownvalue.value = await CommonProvider.getSiteDropdown(projectController.selectedProjectId.value);

      getSiteDropdownvalue.value.forEach((element) {
        return siteDropdownName.add(element.siteName);
      });


  }

  Future subcont_SiteEntry_SiteDropdowntList(BuildContext context,int editvalue) async {
    getSiteDropdownvalue.value = await CommonProvider.getSiteDropdown(projectController.selectedProjectId.value);
    if(editvalue==1){
      getSiteDropdownvalue.value.forEach((element) {
        return siteDropdownName.add(element.siteName);
      });
    }
    else{
      getSiteDropdownvalue.value.forEach((element) {
        return siteDropdownName.add(element.siteName);
      });
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return SiteShowPopup(list:getSiteDropdownvalue.value,value: 1,);
      //     });
    }
  }


  setSelectedSiteID(String value) {
    if (getSiteDropdownvalue.value.length>0) {
      getSiteDropdownvalue.forEach((element) {
        if(value == element.siteName){
          selectedsiteId(element.siteId);
        }
      });
    }
    setSelectedMRNListName(selectedsiteId.value);
  }

  setSelectedMRNListName(int? id) {
    if (getSiteDropdownvalue.value != null) {
      getSiteDropdownvalue.value.forEach((element) {
        if (id == element.siteId) {
          selectedsitedropdownName(element.siteName.toString());
        }
      });
    }
    Sitename.text=selectedsitedropdownName.value;
  }


  Future getMrnReporttList() async {
    mrnListValue.value.clear();
    await ReportsProvider.getMrn_Report_List(reportsController.selectedProjectId.value,reportsController.selectedsiteId.value,FromdateController.text,TodateController.text).then((value)async{
      if(value!=null&& value.length>0){
        mrnListValue.value=value;
        return mrnListValue.value;
      }
    });
  }

  Future OnItemsSelected(int slectid,String MrnReqNo,BuildContext context)async{
    await ReportsProvider.onItemSelctMrnList(slectid).then((value)async{
      if(value!=null&&value.length>0){
        selctListDatas.value=value;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return mrnPopup(list:selctListDatas.value, MrnReqNo:MrnReqNo);
            });
      }
    });
  }

}