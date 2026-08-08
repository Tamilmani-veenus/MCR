import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

String? punchStatus;
bool punchIn = false;

class BaseUtitiles {
  static var deviceName;
  static var deviceVersion;
  static var identifier;
  static RxList dummyListData=[].obs;

  static double getheightofPercentage(BuildContext context, int percentage) {
    double _height = MediaQuery.of(context).size.height;
    return (_height / 100) * percentage;
  }

  static double getWidthtofPercentage(BuildContext context, int percentage) {
    double _width = MediaQuery.of(context).size.width;
    return (_width / 100) * percentage;
  }

  static showToast(String message) => Fluttertoast.showToast(msg: message, timeInSecForIosWeb: 3);

  static Future<List<String>> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.id; //UUID for Android
        // identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return [deviceName!, deviceVersion!, identifier!];
  }

  static String initiateCurrentDateFormat(){
    DateTime dateTime = DateTime.now();
    var month = dateTime.month.toString().padLeft(2, '0');
    var day = dateTime.day.toString().padLeft(2, '0');
    var dateformateTime = '${dateTime.year}-$month-$day ${dateTime.hour}:${dateTime.minute}';
    var dateformate = '${dateTime.year}-$month-$day';
    return dateformate;
  }

  static String selectDateFormat(DateTime selectDate){

    var month = selectDate.month.toString().padLeft(2, '0');
    var day = selectDate.day.toString().padLeft(2, '0');
    var dateformateTime = '${selectDate.year}-$month-$day ${selectDate.hour}:${selectDate.minute}';
    var dateformate = '${selectDate.year}-$month-$day';
    return dateformate;
  }

  static String NMR_After_OneWeekDate(DateTime selectDate){
    var newDate = new DateTime(selectDate.year, selectDate.month, selectDate.day+6);
    var dateformate='$newDate'.substring(0,10);
    return dateformate;
  }

  static MaterialheadNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialHead.toString().toLowerCase().contains(value) ||
            item.materialHead.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static filterSearchResults(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value) ||
            item.reviseDate.toString().toLowerCase().contains(value) ||
            item.reviseDate.toString().toUpperCase().contains(value) ||
            item.reviseNo.toString().toLowerCase().contains(value) ||
            item.reviseNo.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.preparedby.toString().toLowerCase().contains(value) ||
            item.preparedby.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_BOQRevised(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.itemDesc.toString().toLowerCase().contains(value) ||
            item.itemDesc.toString().toUpperCase().contains(value) ||
            item.unit.toString().toLowerCase().contains(value) ||
            item.unit.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_Consumptionitemlist(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.material.toString().toLowerCase().contains(value) ||
            item.material.toString().toUpperCase().contains(value) ||
            item.scale.toString().toLowerCase().contains(value) ||
            item.scale.toString().toUpperCase().contains(value)  ||
            item.stockQty.toString().toLowerCase().contains(value) ||
            item.stockQty.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_dprlist(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.workDate.toString().toLowerCase().contains(value) ||
            item.workDate.toString().toUpperCase().contains(value) ||
            item.workNo.toString().toLowerCase().contains(value) ||
            item.workNo.toString().toUpperCase().contains(value) ||
            item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value) ||
            item.subconName.toString().toLowerCase().contains(value) ||
            item.subconName.toString().toUpperCase().contains(value) ||
            item.preparedbyName.toString().toLowerCase().contains(value) ||
            item.preparedbyName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_billGenerationDirect(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.workDate.toString().toLowerCase().contains(value) ||
            item.workDate.toString().toUpperCase().contains(value) ||
            item.workNo.toString().toLowerCase().contains(value) ||
            item.workNo.toString().toUpperCase().contains(value) ||
            item.subconName.toString().toLowerCase().contains(value) ||
            item.subconName.toString().toUpperCase().contains(value) ||
            item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value) ||
            item.fdate.toString().toLowerCase().contains(value) ||
            item.fdate.toString().toUpperCase().contains(value) ||
            item.tdate.toString().toLowerCase().contains(value) ||
            item.tdate.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_SubcontAttend(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.labrAttnDate.toString().toLowerCase().contains(value) ||
            item.labrAttnDate.toString().toUpperCase().contains(value) ||
            item.labrAttnNo.toString().toLowerCase().contains(value) ||
            item.labrAttnNo.toString().toUpperCase().contains(value) ||
            item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value) ||
            item.totNos.toString().toLowerCase().contains(value) ||
            item.totNos.toString().toUpperCase().contains(value) ||
            item.totAmt.toString().toLowerCase().contains(value) ||
            item.totAmt.toString().toUpperCase().contains(value) ||
            item.workType.toString().toLowerCase().contains(value) ||
            item.workType.toString().toUpperCase().contains(value) ||
            item.workshift.toString().toLowerCase().contains(value) ||
            item.workshift.toString().toUpperCase().contains(value) ||
            item.subconName.toString().toLowerCase().contains(value) ||
            item.subconName.toString().toUpperCase().contains(value) ||
            item.labrAttnDate.toString().toLowerCase().contains(value) ||
            item.labrAttnDate.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }


  static filterSearchResults_MRNRequestIndent(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value)  ||
            item.reqOrdDate.toString().toLowerCase().contains(value) ||
            item.reqOrdDate.toString().toUpperCase().contains(value) ||
            item.reqOrdNo.toString().toLowerCase().contains(value) ||
            item.reqOrdNo.toString().toUpperCase().contains(value) ||
            item.reqDueDate.toString().toLowerCase().contains(value) ||
            item.reqDueDate.toString().toUpperCase().contains(value) ||
            item.Preparedby.toString().toLowerCase().contains(value) ||
            item.Preparedby.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_Inward(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.inwDate.toString().toLowerCase().contains(value) ||
            item.inwDate.toString().toUpperCase().contains(value)  ||
            item.inwardNo.toString().toLowerCase().contains(value) ||
            item.inwardNo.toString().toUpperCase().contains(value) ||
            item.purOrdNo.toString().toLowerCase().contains(value) ||
            item.purOrdNo.toString().toUpperCase().contains(value) ||
            item.supplier.toString().toLowerCase().contains(value) ||
            item.supplier.toString().toUpperCase().contains(value) ||
            item.invoiceno.toString().toLowerCase().contains(value) ||
            item.invoiceno.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }


  static filterSearchResults_InwardPending(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.no.toString().toLowerCase().contains(value) ||
            item.no.toString().toUpperCase().contains(value)  ||
            item.date.toString().toLowerCase().contains(value) ||
            item.date.toString().toUpperCase().contains(value) ||
            item.supplierName.toString().toLowerCase().contains(value) ||
            item.supplierName.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.delaydays.toString().toLowerCase().contains(value) ||
            item.delaydays.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_TransferbetweenProjects(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.exdate.toString().toLowerCase().contains(value) ||
            item.exdate.toString().toUpperCase().contains(value)  ||
            item.transferNo.toString().toLowerCase().contains(value) ||
            item.transferNo.toString().toUpperCase().contains(value) ||
            item.frProject.toString().toLowerCase().contains(value) ||
            item.frProject.toString().toUpperCase().contains(value) ||
            item.toProject.toString().toLowerCase().contains(value) ||
            item.toProject.toString().toUpperCase().contains(value) ||
            item.fromSite.toString().toLowerCase().contains(value) ||
            item.fromSite.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_TransferbetweenSites(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.exdate.toString().toLowerCase().contains(value) ||
            item.exdate.toString().toUpperCase().contains(value)  ||
            item.transferNo.toString().toLowerCase().contains(value) ||
            item.transferNo.toString().toUpperCase().contains(value) ||
            item.frProject.toString().toLowerCase().contains(value) ||
            item.frProject.toString().toUpperCase().contains(value) ||
            item.fromSite.toString().toLowerCase().contains(value) ||
            item.fromSite.toString().toUpperCase().contains(value) ||
            item.toSite.toString().toLowerCase().contains(value) ||
            item.toSite.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_Consumption(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.exdate.toString().toLowerCase().contains(value) ||
            item.exdate.toString().toUpperCase().contains(value)  ||
            item.expenseNo.toString().toLowerCase().contains(value) ||
            item.expenseNo.toString().toUpperCase().contains(value) ||
            item.entryType.toString().toLowerCase().contains(value) ||
            item.entryType.toString().toUpperCase().contains(value) ||
            item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value) ||
            item.site.toString().toLowerCase().contains(value) ||
            item.site.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResults_PendingList(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.no.toString().toLowerCase().contains(value) ||
            item.no.toString().toUpperCase().contains(value) ||
            item.date.toString().toLowerCase().contains(value) ||
            item.date.toString().toUpperCase().contains(value) ||
            item.dueDate.toString().toLowerCase().contains(value) ||
            item.dueDate.toString().toUpperCase().contains(value) ||
            item.projectName.toString().toLowerCase().contains(value) ||
            item.projectName.toString().toUpperCase().contains(value) ||
            item.preparedBy.toString().toLowerCase().contains(value) ||
            item.preparedBy.toString().toUpperCase().contains(value) ||
            item.supplierName.toString().toLowerCase().contains(value) ||
            item.supplierName.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.netAmt.toString().toLowerCase().contains(value) ||
            item.netAmt.toString().toUpperCase().contains(value) ||
            item.potype.toString().toLowerCase().contains(value) ||
            item.potype.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsStaffVouchers(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.vocNo.toString().toLowerCase().contains(value) ||
            item.vocNo.toString().toUpperCase().contains(value) ||
            item.staff.toString().toLowerCase().contains(value) ||
        item.staff.toString().toUpperCase().contains(value) ||
            item.vocDate.toString().toLowerCase().contains(value) ||
        item.vocDate.toString().toUpperCase().contains(value) ||
            item.accName.toString().toLowerCase().contains(value) ||
        item.accName.toString().toUpperCase().contains(value) ||
            item.accType.toString().toLowerCase().contains(value) ||
        item.accType.toString().toUpperCase().contains(value) ||
            item.vocAmt.toString().toLowerCase().contains(value) ||
        item.vocAmt.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultstoProjectName(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.toProjectName.toString().toLowerCase().contains(value) ||
            item.toProjectName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsfrProjectName(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.frProjectName.toString().toLowerCase().contains(value) ||
            item.frProjectName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsStaff(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.staff.toString().toLowerCase().contains(value) ||
            item.staff.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultssupplier(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.supplier.toString().toLowerCase().contains(value) ||
            item.supplier.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsfrProject(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.frProject.toString().toLowerCase().contains(value) ||
            item.frProject.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultsemployee(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.employee.toString().toLowerCase().contains(value) ||
            item.employee.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }

  static filterSearchResultstransfer(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.value.forEach((item) {
        if (item.fromProject.toString().toLowerCase().contains(value) ||
            item.fromProject.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list.value;
    }
  }



  static projectPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static companyPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.company.toString().toLowerCase().contains(value) ||
            item.company.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static sitePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.siteName.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialSubItemPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialSubname.toString().toLowerCase().contains(value) ||
            item.materialSubname.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static materialName_StockAtSitePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item["MaterialName"].toString().toLowerCase().contains(value) ||
            item["MaterialName"].toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static subcontPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.subContName.toString().toLowerCase().contains(value) ||
            item.subContName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static supplierNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.supplierName.toString().toLowerCase().contains(value) ||
            item.supplierName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.material.toString().toLowerCase().contains(value) ||
            item.material.toString().toUpperCase().contains(value)
            // item.balqty.toString().toLowerCase().contains(value) ||
            // item.balqty.toString().toUpperCase().contains(value) ||
            // item.scale.toString().toLowerCase().contains(value) ||
            // item.scale.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialName_DPRNew(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialName.toString().toLowerCase().contains(value) ||
            item.materialName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static cmpNMRLabourNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.labourName.toString().toLowerCase().contains(value) ||
            item.labourName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static materialSubnamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.materialSubname.toString().toLowerCase().contains(value) ||
            item.materialSubname.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static empNameamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.empName.toString().toLowerCase().contains(value) ||
            item.empName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static bankNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.bank.toString().toLowerCase().contains(value) ||
            item.bank.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static typeNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.typeName.toString().toLowerCase().contains(value) ||
            item.typeName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static paymodePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.paymode.toString().toLowerCase().contains(value) ||
            item.paymode.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static acPayForNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.acPayForName.toString().toLowerCase().contains(value) ||
            item.acPayForName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  //--------poapprovalSupplierlist------------
  static searchPoApproval_SupplierList(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.billdate.toString().toLowerCase().contains(value) ||
            item.billdate.toString().toUpperCase().contains(value) ||
            item.rate.toString().toLowerCase().contains(value) ||
            item.rate.toString().toUpperCase().contains(value) ||
            item.supplier.toString().toLowerCase().contains(value) ||
            item.supplier.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static headItemPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.headItem.toString().toLowerCase().contains(value) ||
            item.headItem.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static filterSearchResults_workOrderDirect(
      String value,
      List list,
      ) {
    dummyListData.clear();

    if (value.isNotEmpty) {
      for (var item in list) {
        if (item.entryDate.toString().toLowerCase().contains(value) ||
            item.entryDate.toString().toUpperCase().contains(value) ||
            item.workOrderNo.toString().toLowerCase().contains(value) ||
            item.workOrderNo.toString().toUpperCase().contains(value) ||
            item.subconName.toString().toLowerCase().contains(value) ||
            item.subconName.toString().toUpperCase().contains(value) ||
            item.project.toString().toLowerCase().contains(value) ||
            item.project.toString().toUpperCase().contains(value) ||
            item.netAmt.toString().toLowerCase().contains(value) ||
            item.netAmt.toString().toUpperCase().contains(value) ||
            item.siteName.toString().toLowerCase().contains(value) ||
            item.status.toString().toUpperCase().contains(value) ||
            item.status.toString().toLowerCase().contains(value) ||
            item.siteName.toString().toUpperCase().contains(value) ||
            item.preparedByName.toString().toLowerCase().contains(value) ||
            item.preparedByName.toString().toUpperCase().contains(value) ) {
          dummyListData.add(item);
        }
      }
      return dummyListData;
    } else {
      return list;
    }
  }

  // static companyPopupAlert(String value,list)  {
  //   dummyListData.value.clear();
  //   if (value.isNotEmpty) {
  //     list.forEach((item) {
  //       if (item.company.toString().toLowerCase().contains(value) ||
  //           item.company.toString().toUpperCase().contains(value))
  //       {
  //         dummyListData.value.add(item);
  //       }
  //     });
  //     return  dummyListData.value;
  //   }
  //   else {
  //     return  list;
  //   }
  // }

  static accTypePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.accType.toString().toLowerCase().contains(value) ||
            item.accType.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static accNamePopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.accName.toString().toLowerCase().contains(value) ||
            item.accName.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }


  static materialPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.material.toString().toLowerCase().contains(value) ||
            item.material.toString().toUpperCase().contains(value) ||
            item.scale.toString().toLowerCase().contains(value) ||
            item.scale.toString().toUpperCase().contains(value) ||
            item.stockQty.toString().toLowerCase().contains(value) ||
            item.stockQty.toString().toUpperCase().contains(value)
        )
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static itemDescPopupAlert(String value,list)  {
    dummyListData.value.clear();
    if (value.isNotEmpty) {
      list.forEach((item) {
        if (item.itemDesc.toString().toLowerCase().contains(value) ||
            item.itemDesc.toString().toUpperCase().contains(value))
        {
          dummyListData.value.add(item);
        }
      });
      return  dummyListData.value;
    }
    else {
      return  list;
    }
  }

  static formatDate(DateTime date) => DateFormat.yMd().format(date);

  static String dateformat(String date){
    String data="";
    DateTime format= new DateFormat('yyyy-MM-dd').parse(date);
    var inputDate = DateTime.parse(format.toString());
    var outputFormat = DateFormat('dd / MMM / yyyy');
    var outputDate = outputFormat.format(inputDate);
    data=outputDate.toString();
    return data;
  }

  static String amountFormat(double value) {
    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_IN", // local US
    ).format(value);
    return numberFormatter;
  }

  static Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<bool> checkNetworkAndShowLoader(BuildContext context) async {
    if (await isConnectedToNetwork()) {
      showLoadingDialog(context);
      return true;
    } else {
      Fluttertoast.showToast(msg: "No Internet Connection. Please check your network.");
      return false;
    }
  }

  static  Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    )
                  ]
              ));
        });
  }

}
