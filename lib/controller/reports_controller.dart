import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../provider/reports_provider.dart';
import '../utilities/baseutitiles.dart';
import 'logincontroller.dart';

class ReportsController extends GetxController{


  LoginController loginController=Get.put(LoginController());

  final projectname = TextEditingController();
  final sitename = TextEditingController();
  final Subheadername = TextEditingController();
  final suppliername = TextEditingController();
  final subcontractorname = TextEditingController();
  final companyName = TextEditingController();

  //---Projects--
  RxList getProjectdropDownvalue=[].obs;
  RxList projectDropdownName=[].obs;
  RxString selectedProjectName = "".obs;
  RxInt selectedProjectId = 0.obs;

  //---Sites--
  RxList getSiteDropdownvalue = [].obs;
  RxList siteDropdownName = [].obs;
  RxString selectedsitedropdownName = "".obs;
  RxInt selectedsiteId = 0.obs;

  //---Supplier--
  RxList supplierListDropdown = [].obs;
  RxList supplierDropdownName = [].obs;
  RxString selectedSupplierName = "".obs;
  RxInt selectedsuppliertId = 0.obs;


  //---Subcontractor--
  RxList getdropDownvalue=[].obs;
  RxList getSuncontDropdownvalue=[].obs;
  RxList SubcontDropdownName = [].obs;
  RxString selectedSubconttName = "".obs;
  RxInt selectedSubcontId = 0.obs;

  //---Material--
  RxList getMaterialdropDownvalue = [].obs;
  RxInt materialDropdowntId = 0.obs;
  RxBool validateProject = false.obs;

  //---Company--
  RxList getCompanyDropDownvalue=[].obs;
  RxInt selectedCompanyId = 0.obs;


  //-------------Get Projects Reports---------------

  Future getProjectReportList(BuildContext context) async {
    getProjectdropDownvalue.clear();
    getProjectdropDownvalue.value= await ReportsProvider.getprojectReports(loginController.user.value.userId!,loginController.UserType());
    for (var element in getProjectdropDownvalue) {
      continue;
    }
  }

  setSelectedProjectID(String value) {
    if (getProjectdropDownvalue.isNotEmpty) {
      for (var element in getProjectdropDownvalue) {
        if(value == element.project){
          selectedProjectId(element.projectId);
        }
      }
    }
    setSelectedProjectListName(selectedProjectId.value);
  }

  setSelectedProjectListName(int? id) {
    if (getProjectdropDownvalue.isNotEmpty) {
      for (var element in getProjectdropDownvalue) {
        if (id == element.projectId) {
          selectedProjectName(element.project.toString());
        }
      }
    }
    projectname.text=selectedProjectName.value;
  }

  //---------------Get Sites Reports-------------

  Future getSiteReportList(BuildContext context,int pId) async {
    getSiteDropdownvalue.value.clear();
    getSiteDropdownvalue.value = await ReportsProvider.getsiteReports(pId);
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
    sitename.text=selectedsitedropdownName.value;
  }

  Future getReportMaterialList() async {
    getMaterialdropDownvalue.value=[];
    final value = await ReportsProvider.getReportMrnMaterial();
    if (value != null ) {
        getMaterialdropDownvalue.value = value!;
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  //------------Get Supplier Reports----------

  Future getSupplierReportList(BuildContext context) async {
    supplierListDropdown.value = await ReportsProvider.getsupplierReports();
    supplierListDropdown.value.forEach((element) {
      return supplierDropdownName.value.add(element.supplierName);
    });
  }

  setSelectSupplierID(String value) {
    if (supplierListDropdown.value.length > 0) {
      supplierListDropdown.forEach((element) {
        if (value == element.supplierName) {
          selectedsuppliertId(element.supplierId);
        }
      });
    }
    setSelectSupplierName(selectedsuppliertId.value);
  }

  setSelectSupplierName(int? id) {
    if (supplierListDropdown.value != null) {
      supplierListDropdown.value.forEach((element) {
        if (id == element.supplierId) {
          selectedSupplierName(element.supplierName.toString());
        }
      });
    }
    suppliername.text=selectedSupplierName.value;
  }


 //------------Get Supplier Reports----------

  Future getSubcontactorReportList(BuildContext context) async {
    getdropDownvalue.value = await ReportsProvider.getsubcontactorReports();
    getdropDownvalue.value.forEach((element) {
      return SubcontDropdownName.value.add(element.subContName);
    });
  }

  setSelectedSubcontID(String value) {
    if (getdropDownvalue.value.length>0) {
      getdropDownvalue.forEach((element) {
        if (value == element.subContName) {
          selectedSubcontId(element.subContId);
        }
      });
    }
    setSelectedsubcontListName(selectedSubcontId.value);
  }

  setSelectedsubcontListName(int? id) {
    if (getdropDownvalue.value != null) {
      getdropDownvalue.value.forEach((element) {
        if (id == element.subContId) {
          selectedSubconttName(element.subContName.toString());
        }
      });
    }
    subcontractorname.text=selectedSubconttName.value;
  }




}