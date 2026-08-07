import 'package:mcr/controller/reports_controller.dart';

import '../controller/projectcontroller.dart';

import '../commonpopup/companyalert.dart';
import '../controller/logincontroller.dart';
import '../provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController{
  RxList getdropDownvalue=[].obs;
  RxList CompanyDropdownName=[].obs;
  RxList getProjectdropDownvalue=[].obs;
  RxList ProjectdropdownList=[].obs;
  RxList mainlist=[].obs;
  final CompanyName=new TextEditingController();
  final projectname_CompanyWise=new TextEditingController();

  LoginController loginController=Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  ReportsController reportsController = Get.put(ReportsController());

  RxInt selectedCompanyId = 0.obs;
  RxString selectedCompanyName = "".obs;

  RxList getdropDownvalue_Companywise=[].obs;
  RxList ProjectDropdown_CompanyWiseName=[].obs;
  RxInt selectedProjectId_CompanyWise = 0.obs;
  RxString selectedProjectName_ComapnyWise = "".obs;

  Future getCompanyList(BuildContext context,int i) async {
    getdropDownvalue.value= await CommonProvider.getCompany(loginController.user.value.userId!,i);
  }

  setSelectedCompanyID(String value) {
    if (getdropDownvalue.value.length>0) {
      getdropDownvalue.forEach((element) {
        if(value == element.company){
          selectedCompanyId(element.companyid);
        }
      });
    }
    setSelectedCountryListName(selectedCompanyId.value);
  }

  setSelectedCountryListName(int? id) {
    if (getdropDownvalue.value != null) {
      getdropDownvalue.value.forEach((element) {
        if (id == element.companyid) {
          selectedCompanyName(element.company.toString());
        }
      });
    }
    CompanyName.text=selectedCompanyName.value;
  }


  //-----------Project Name Company Wise----------------

  Future getProjectList_CompanyWise(BuildContext context,int check,{type}) async {
    getdropDownvalue_Companywise.value.clear();
    getdropDownvalue_Companywise.value= await CommonProvider.getproject_Companywise(type=="mrnReqTracker"?reportsController.selectedCompanyId.value:selectedCompanyId.value);
  }

setSelectedProjectCompanywiseID(String value) {
  if (getdropDownvalue_Companywise.value.length>0) {
    getdropDownvalue_Companywise.forEach((element) {
      if(value == element.project){
        selectedProjectId_CompanyWise(element.projectId);
      }
    });
  }
  setSelectedProjectList_CompanywiseName(selectedProjectId_CompanyWise.value);
}

setSelectedProjectList_CompanywiseName(int? id) {
  if (getdropDownvalue_Companywise.value != null) {
    getdropDownvalue_Companywise.value.forEach((element) {
      if (id == element.projectId) {
        selectedProjectName_ComapnyWise(element.project.toString());
      }
    });
  }
  projectname_CompanyWise.text=selectedProjectName_ComapnyWise.value;
}



}