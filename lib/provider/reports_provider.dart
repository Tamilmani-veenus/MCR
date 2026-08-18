import 'dart:convert';

import 'package:mcr/models/sitedropdownresponse_model.dart';
import 'package:mcr/models/subcontract_dropdown_model.dart';
import 'package:mcr/models/supplierdropwon_model.dart';

import '../apimanager/apimanager.dart';
import '../models/attendancereportlist_model.dart';
import '../models/dprlistresponse_model.dart';
import '../models/inward_report_list_model.dart';
import '../models/materialwise_showlist_model.dart';
import '../models/mrnlist_reports_model.dart';
import '../models/mrnreq_tracker_reportmodel.dart';
import '../models/onitem_attendance_selct_model.dart';
import '../models/onitem_dpr_select_model.dart';
import '../models/onitem_inward_select_model.dart';
import '../models/onitem_mrn_select_model.dart';
import '../models/project_dropdownlist_model.dart';
import '../models/projectwise_details_list_model.dart';
import '../models/projectwise_showlist_model.dart';
import '../models/wklyreport_response.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';


class ReportsProvider{

  ///------------****************-------Reports DropDown Lists ------------****************-------------------

  //-----------Get Project Reports--------------------

  static Future<List> getprojectReports(int userId,String userType) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETPROJECT_REPORTS+"?UserId=$userId&UserType=$userType").then((value) {
      responseData = projectDropdownListFromJson(value);
      if (responseData!=null&& responseData.length>0) {
        return responseData;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return responseData;
  }


  //-----------Get Site Reports--------------------

  static Future<List> getsiteReports(int pId) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETSITE_REPORTS+"?ID=$pId").then((value) {
      responseData = siteDropdownResponseFromJson(value);
      if (responseData!=null&& responseData.length>0) {
        return responseData;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return responseData;
  }

  static Future getReportMrnMaterial() async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETMATERIALLIST);
      print("response...${response}");
      return jsonDecode(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  //-----------Get Supplier Reports--------------------

  static Future<List> getsupplierReports() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETSUPPLIER_REPORTS).then((value) {
      responseData = supplierDropdownResponseFromJson(value);
      if (responseData!=null&& responseData.length>0) {
        return responseData;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return responseData;
  }

  static Future<MrnReqTrackerListModel?> getMrnReqTrackerRptList(userId,userType,int projectId,int siteId,int materialId,String frdate,String todate) async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETREQTRACKERLISTAPI + "?UID=$userId&Utype=$userType&projectId=$projectId&siteId=$siteId&materialId=$materialId&fromDate=$frdate&toDate=$todate");
      print("response...${response}");
      return mrnReqTrackerListModelFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }


  //-----------Get Subcontractor Reports--------------------

  static Future<List> getsubcontactorReports() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETSUBCONTACTOR_REPORTS).then((value) {
      responseData = subcontractorDropdownListFromJson(value);
      if (responseData!=null&& responseData.length>0) {
        return responseData;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return responseData;
  }


  ///------------****************-------Reports List View------------****************-------------------

  static Future<List<WklyReportResponse>> getNMRreportList(int projectId,int subId,String frdate,String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETNMRREPORT+"?PrjId=$projectId&SubId=$subId&FrDate=$frdate&ToDate=$todate").then((value) {
      print("WklyReportList:"+value);
      data = wklyReportResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<AttendanceReportListResponse>> getAttendancereportList(int userId, String userType,int projectId,int subId,String frdate,String todate,String type) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETATTENDANCEREPORTLIST+"?Userid=$userId&Usertype=$userType&PrjId=$projectId&SubId=$subId&FrDate=$frdate&ToDate=$todate&type=$type").then((value) {
      print("AttendanceReportList:"+value);
      data = attendanceReportListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<OnItemSelectAttendanceList>> onItemSelctAttendanceList(int SelctId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.ATTENDANCEONITEMSELCT+"?AttenId=$SelctId").then((value) {
      print("OnItemSelectAttendanceList:"+value);
      data = onItemSelectAttendanceListFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<OnItemSelectInwardList>> onItemSelctInwardList(int SelctId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.INWARDONITEMSELCT+"?InwId=$SelctId").then((value) {
      print("OnItemSelectInwardList:"+value);
      data = onItemSelectInwardListFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<OnItemSelectMrnList>> onItemSelctMrnList(int SelctId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.MRNONITEMSELCT+"?ReqMasId=$SelctId").then((value) {
      print("OnItemSelectMRNList:"+value);
      data = onItemSelectMrnListFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<OnItemSelectDprList>> onItemSelctDprList(int SelctId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.DPRONITEMSELCT+"?WorkId=$SelctId").then((value) {
      print("OnItemSelectDPRList:"+value);
      data = onItemSelectDprListFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<MrnListReportsResponse>> getMrn_Report_List(int projectId,int subId,String frdate,String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETMRNREPORTSLISTAPI+"?PrjId=$projectId&SiteId=$subId&FrDate=$frdate&ToDate=$todate").then((value) {
      print("AttendanceReportList:"+value);
      data = mrnListReportsResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<InwardReportListResponse>> getInward_Report_List(int projectId,int siteId,int subId,String frdate,String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETINWARDREPORTSLISTAPI+"?PrjId=$projectId&SiteId=$siteId&SupId=$subId&FrDate=$frdate&ToDate=$todate").then((value) {
      print("AttendanceReportList:"+value);
      data = inwardReportListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<DprListResponse>> getDprReport_List(int projectId,int siteId,int subId,String frdate,String todate,String wType) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETDPRLISTAPI+"?PrjId=$projectId&SiteId=$siteId&SubId=$subId&FrDate=$frdate&ToDate=$todate&WorkType=$wType").then((value) {
      print("AttendanceReportList:"+value);
      data = dprListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<ProjectWiseShowListResponse>> getProject_Show_List(int projectId,int siteId,int mId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETMATERIAL_SHOW_LIST+"?PId=$projectId&SId=$siteId&MSId=$mId").then((value) {
      print("AttendanceReportList:"+value);
      data = projectWiseShowListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<ProjectWiseDetailsListResponse>> getProject_Details_List(int projectId,int siteId,int mId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETMATERIAL_DETAILS_LIST+"?PId=$projectId&SId=$siteId&MSId=$mId").then((value) {
      print("AttendanceReportList:"+value);
      data = projectWiseDetailsListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List<MaterialWiseShowListResponse>> getMaterialWise_Show_List(int msId,int mId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETMATERIALWISE_SHOW_LIST+"?MSId=$msId&MId=$mId").then((value) {
      print("AttendanceReportList:"+value);
      data = materialWiseShowListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }
}