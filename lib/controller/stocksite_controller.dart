import 'package:mcr/controller/reports_controller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../home/stock_site/project_details_popup.dart';
import '../provider/common_provider.dart';
import '../provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockSiteController extends GetxController{

  final Materialsubname=new TextEditingController();
  final Subheadername=new TextEditingController();
  RxList projectShowList=[].obs;
  RxList projectDetailsList=[].obs;

  RxList materialWiseShowList=[].obs;

  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  ReportsController reportsController = Get.put(ReportsController());

  RxList getmaterialSubdropDownvalue=[].obs;
  RxList mainlist=[].obs;
  RxList submaterialDropdownName=[].obs;
  RxInt matDropdowntId = 0.obs;
  RxString matdropdownName = "".obs;

  RxList getSubHeaddropDownvalue=[].obs;
  RxList HeadDropdownName=[].obs;
  RxInt subHeadDropdowntId = 0.obs;
  RxString subHeadDropdownName = "".obs;

  RxList getMaterialdropDownvalue=[].obs;
  RxList MaterialNamemainlist=[].obs;
  RxList getMaterialDropdownName=[].obs;
  RxInt materialDropdowntId = 0.obs;
  RxString materiaDropdownName = "".obs;

  //ProjectWise

  Future getProjectWisesubmaterialDropdownList(BuildContext context) async {
    getmaterialSubdropDownvalue.value= await CommonProvider.getmaterialsubDropdown();
    getmaterialSubdropDownvalue.value.forEach((element) {
      return submaterialDropdownName.value.add(element.materialSubname);
    });
  }

  setSelectedSubMatID(String value) {
    if (getmaterialSubdropDownvalue.value.length>0) {
      getmaterialSubdropDownvalue.forEach((element) {
        if(value == element.materialSubname){
          matDropdowntId(element.materialSubId);
        }
      });
    }
    setSelectedSubMatListName(matDropdowntId.value);

  }

  setSelectedSubMatListName(int? id) {
    if (getmaterialSubdropDownvalue.value != null) {
      getmaterialSubdropDownvalue.value.forEach((element) {
        if (id == element.materialSubId) {
          matdropdownName(element.materialSubname);
        }
      });
    }
    Materialsubname.text=matdropdownName.value;
  }

  Future getProjectShowList() async {
    projectShowList.clear();
    await ReportsProvider.getProject_Show_List(reportsController.selectedProjectId.value,reportsController.selectedsiteId.value,matDropdowntId.value).then((value)async{
      if(value!=null&& value.length>0){
        projectShowList.value=value;
        return projectShowList.value;
      }
    });
  }

  Future getProjectDetailisList(BuildContext context, String pName) async {
    projectDetailsList.value.clear();
    await ReportsProvider.getProject_Details_List(reportsController.selectedProjectId.value,reportsController.selectedsiteId.value,matDropdowntId.value).then((value)async{
      if(value!=null&& value.length>0){
        projectDetailsList.value=value;
        return  Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectDetailsPopup(list:projectDetailsList.value,ProjectName: pName)));
      }
    });
  }


  Future getmaterialDropdowntList(BuildContext context) async {
    getMaterialdropDownvalue.value = await CommonProvider.getMaterialDropdown(matDropdowntId.value);
    getMaterialdropDownvalue.value.forEach((element) {
      return getMaterialDropdownName.add(element.materialName);
    });
  }

  selectedMaterialID(String value) {
    if (getMaterialdropDownvalue.value.length>0) {
      getMaterialdropDownvalue.forEach((element) {
        if(value == element.materialName){
          materialDropdowntId(element.materialId);
        }
      });
    }
    selectedMaterialName(materialDropdowntId.value);
  }

  selectedMaterialName(int? id) {
    if (getMaterialdropDownvalue.value != null) {
      getMaterialdropDownvalue.value.forEach((element) {
        if (id == element.materialId) {
          materiaDropdownName(element.materialName);
        }
      });
    }
    Subheadername.text=materiaDropdownName.value;
  }

  Future getMaterialShowList() async {
    materialWiseShowList.value.clear();
    await ReportsProvider.getMaterialWise_Show_List(matDropdowntId.value,materialDropdowntId.value).then((value)async{
      if(value!=null&& value.length>0){
        materialWiseShowList.value=value;
        return materialWiseShowList.value;
      }
    });
  }

}