import 'dart:convert';
import '../apimanager/apimanager.dart';
import '../models/accountname_model.dart';
import '../models/accounttype_model.dart';
import '../models/companydropdownlist_model.dart';
import '../models/companywiseprojectname_model.dart';
import '../models/materiallist_model.dart';
import '../models/materialsubitem_dropdown_model.dart';
import '../models/materialwise_materialdropdown_model.dart';
import '../models/materialwise_subhead_dropdown_model.dart';
import '../models/nmr_billno_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/payfor_model.dart';
import '../models/paymode_model.dart';
import '../models/project_dropdownlist_model.dart';
import '../models/sitedropdownresponse_model.dart';
import '../models/staffresponse_model.dart';
import '../models/subcont_entrylist_rights_model.dart';
import '../models/subcontract_dropdown_model.dart';
import '../models/supplierdropwon_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class CommonProvider{

  static Future<List> getproject(int userId,String userType) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETPROJECTDROPDOWNLIST+"?UserId=$userId&UserType=$userType").then((value) {
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

  static Future<List> getprojectAll() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETPROJECTDROPDOWNLISTALL).then((value) {
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
  static Future<List> getNMRBillNoList(int pId, int subId) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETNMRBILLNO + "?pid=$pId&subid=$subId")
        .then((value) {
      responseData = nmrBillNoResFromJson(value);
      if (responseData != null && responseData.length > 0) {
        return responseData;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return responseData;
  }



//-----Project Name Companywise list-----------
  static Future<List> getproject_Companywise(int compId) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETPROJECTCOMPANYWISE_DROPDOWNLIST+"?compId=$compId").then((value) {
      responseData = projectnameCompanywiseFromJson(value);
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

  static Future<List> getHeadName(int pId,int sId) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GET_HEAD_DROPDOWNLIST+"?PId=$pId&SId=$sId").then((value) {
      responseData = headNameResFromJson(value);
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



  static Future<List> getSubcontrator(int pid, int sid, checkScreen) async {
    List responseData = [];
    if(checkScreen == 1){
      await ApiManager.getAPICall(ApiConstant.GETSUBCONTRACTLIST+"?pid=$pid").then((value) {
        responseData = subcontractorDropdownListFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    else if(checkScreen == "billdirect"){
      await ApiManager.getAPICall(ApiConstant.GETSUBCONTRACTBILLDIRLIST+"?pid=$pid&sid=$sid").then((value) {
        responseData = subcontractorDropdownListFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    else{
      await ApiManager.getAPICall(ApiConstant.GETSUBCONTRACTDROPDOWNLIST).then((value) {
        responseData = subcontractorDropdownListFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    return responseData;
  }


  static Future<List> getSubcontratorList(int pid, int checkScreen) async {
    List responseData = [];
    if(checkScreen == 1){
      checkScreen = 0;
      await ApiManager.getAPICall(ApiConstant.GETSUBCONTRACTLIST+"?pid=$pid").then((value) {
        responseData = subcontractorDropdownListFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    return responseData;
  }

  static Future<List> getLabour() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETLABOURLIST).then((value) {
      responseData = getLabourDetailsFromJson(value);
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

  static Future<List> getSiteDropdown(int projectId) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.SITEDROPDWONLISTAPI+"?ID=$projectId").then((value) {
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

  static Future<List> getSupplierDropdown() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETSUPPLIERDROPDOWNAPI).then((value) {
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


  static Future MaterialPost(String Material, String Scale,int Head_Id,int MaterialSubID,String Entry_Date) async {
    var data = null;
    await ApiManager.postCall(ApiConstant.POSTMATERIALSAVEAPI + "?Material=$Material&Scale=$Scale&Head_Id=$Head_Id&MaterialSubID=$MaterialSubID&Entry_Date=$Entry_Date")
        .then((value) {
      final res = saveDeduction_SaveResponseFromJson(value);
      if (res.RetString != null) {
        data = res.RetString;
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }



  static Future<List> getCompany(int userId,int i) async {
    List responseData = [];

    if(i==0){
      await ApiManager.getAPICall(ApiConstant.GETCOMPANYDROPDOWNLIST+"?UserId=$userId").then((value) {
        responseData = companyDropdownListResponseFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    else{
      await ApiManager.getAPICall(ApiConstant.GETCOMPANYALL_DROPDOWNLIST).then((value) {
        responseData = companyDropdownListResponseFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    return responseData;
  }






  static Future<List> getmaterialsubDropdown() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETMATERIALSUBDRPDOWNLIST).then((value) {
      responseData = materialSubDropdownResponseFromJson(value);
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

  static Future<List> materialWise_sub_HeadDropdown() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETMATERIAL_SUBHAED_DROPDOWNLIST).then((value) {
      responseData = materialWiseSubHeadResponseFromJson(value);
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

  static Future<List> getMaterialDropdown(int subId) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETMATERIALWISEDROPDOWNLIST+"?MatSubId=$subId").then((value) {
      responseData = materialWiseMaterialDropdownResponseFromJson(value);
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

  static subcontAttendance_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=LabrAttn_No&TableName=Subcont_labour_attend_Mas&FormName=Labour_Attn").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static preapproval_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=PreApproval_No&TableName=Work_PreApproval_Mas&FormName=WorkPreApproval").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static  NMR_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=Work_No&TableName=SubCont_NMR_Bill_Mas&FormName=SubCont_NMR_Bill").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }
  static  DPR_NEW_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=Work_No&TableName=SubCont_dailyWork_Mas&FormName=DPR_New").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static  DPR_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=Work_No&TableName=SubCont_dailyWork_Mas&FormName=dpr").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static  DPR_Labour_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=Work_No&TableName=SubCont_dailyWork_Mas&FormName=DPR_New2").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static  directBill_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=Work_No&TableName=SubCont_WorkQty_Mas&FormName=SubContBillDirect").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static  workOrderdirect_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=WorkOrderNo&TableName=WorkOrder_mas&FormName=WorkOrder_Direct").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static inwardPending_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=inward_no&TableName=Material_Inward_mas&FormName=Inward").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static transfer_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=transfer_no&TableName=Material_transfer_mas&FormName=material_transfer").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static transferSite_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=transfer_no&TableName=Material_s2s_transfer_Mas&FormName=material_site").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static advReqvoucher_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=voc_no&TableName=Ac_advance_req_voucher&FormName=AdvanceRequisitionvoucher").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }


  static Future<List<DailyEntrysubcontRightsEntrylistRes>> getSubControllerRightsEntryList(int? UserId, String FormName) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETCONTROLL_RIGHTS_ENTRYLIST + "?UserId=$UserId&FormName=$FormName").then((value) {
      data = dailyEntrysubcontRightsEntrylistResFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
    //  BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

  static Future<List> getFromproject(int? UserId,String UserType,int? req_mas_id) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETFROMPROJECTDROPDOWNLIST+"?UserId=$UserId&UserType=$UserType&ReqId=$req_mas_id").then((value) {
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




//--------------Consumption-----------
  static  Consum_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=Expense_No&TableName=Material_Expense_mas&FormName=consumption").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }


  //--------------MRN Request(Indent)------------

  static MRNIndent_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=req_ord_No&TableName=material_req_ord_mas&FormName=MaterialRequestOrder").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  //--------------MRN Request(Indent)------------

  static companyNMR_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=NMRLbrAttn_No&TableName=NMRLbr_attend_Mas&FormName=NMR_Labr_Attn").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  //-----------------BOQREVISED-----------------------
  static BoqRevised_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=Revise_No&TableName=BOQ_Revise_Mas&FormName=BOQ").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static Requisitionslip_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=Requestion_No&TableName=Staff_Requestion_Slip&FormName=StaffLeavePermission").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static SiteVoucher_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=voc_no&TableName=Ac_site_voucher&FormName=Site_Voucher").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static StaffVoucher_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETAUTONO_YEAR_WISE+"?FieldName=voc_no&TableName=Ac_staff_voucher&FormName=staff_Voucher").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return datasave;
  }

  static Future<List> getAcoountType(int val) async {
    List responseData = [];
    if(val==1){
      await ApiManager.getAPICall(ApiConstant.GETACCOUNTTYPEDROPDOWNLISTADVREQ).then((value) {
        responseData = accounttypereponseFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    else{
      await ApiManager.getAPICall(ApiConstant.GETACCOUNTTYPEDROPDOWNLIST).then((value) {
        responseData = accounttypereponseFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    return responseData;
  }

  static Future<List> getPaymodetype() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETPAYMODEDROPDOWNLIST).then((value) {
      responseData = payModereponseFromJson(value);
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

  static Future<List> getPayforType() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETPAYFORDROPDOWNLIST).then((value) {
      responseData = payforreponseFromJson(value);
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

  static Savetoken(String body) async {
    var ratingRes = null;
    await ApiManager.postAPICall(ApiConstant.TOKEN_SAVE, body).then((value) {
      var response = saveDeduction_SaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        return ratingRes;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });

    return ratingRes;
  }

  static Future Usertoken_deleteAPI(String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.USERTOKENDELETE_API +"?UserId=$UserId&DeviceID=$DeviceName")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  static Future<List> getAccountnameDropdown(int AccTypeId) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.ACCOUNTNAMEDROPDWONLISTAPI+"?AccTypeId=$AccTypeId").then((value) {
      responseData = accountNamereponseFromJson(value);
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

  //---- staff popup----
  static Future<List> getStaffDropdown(int? EmpId,String UserType,int userId) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.STAFFDROPDWONLISTAPI+"?EmpId=$EmpId&UserType=$UserType&UserId=$userId").then((value) {
      responseData = staffFromJson(value);
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

  static Future<List> getmaterial(String requestType) async {
    List responseData = [];
    if(requestType == "0") {
      await ApiManager.getAPICall("${ApiConstant.GETMATERIALREQUESTTYPE}?ReqType=$requestType").then((value) {
        responseData = materiallistResponseFromJson(value);
        if (responseData != null && responseData.length > 0) {
          return responseData;
        }
      },onError: (error) {
        print(error.toString());
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }else if(requestType == "PO"){
      await ApiManager.getAPICall("${ApiConstant.GETMATERIALREQUESTTYPE}?ReqType=$requestType").then((value) {
        responseData = materiallistResponseFromJson(value);
        if (responseData != null && responseData.length > 0) {
          return responseData;
        }
      }, onError: (error) {
        print(error.toString());
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }else if(requestType == "CP"){
      await ApiManager.getAPICall("${ApiConstant.GETMATERIALREQUESTTYPE}?ReqType=$requestType").then((value) {
        responseData = materiallistResponseFromJson(value);
        if (responseData != null && responseData.length > 0) {
          return responseData;
        }
      }, onError: (error) {
        print(error.toString());
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong.. $error');
      });
    }
    return responseData;
  }


  static SaveAccountnameScreenEntryAPI(String body, int Accnameid) async {
    var ratingRes = null;
    if(Accnameid!=0){
      await ApiManager.putUpdateAPIButton(ApiConstant.PUT_ACCOUNTNAME_UPDATE_API, body).then((value) {
            var response = saveDeduction_SaveResponseFromJson(value);
            if (response.RetString != null) {
              ratingRes = response.RetString;
              return ratingRes;
            }
          }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    }
    else{
      await ApiManager.postAPICall(
          ApiConstant.ACCOUNTNAME_SAVE, body)
          .then((value) {
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          return ratingRes;
        }
      }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    }
    return ratingRes;
  }


  //---Delete API----
  static Future Accountname_deleteAPI(int AccTypeId,int AccNameId) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_ACCOUNTNAME_API + "?AccTypeId=$AccTypeId&AccNameId=$AccNameId")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

}