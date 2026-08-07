
import '../controller/logincontroller.dart';
import '../provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController{
  final projectname=new TextEditingController();
  final projectnameAll=new TextEditingController();


  RxList getdropDownvalue=[].obs;

  RxList mainlist=[].obs;
  RxList getdropDownvalueAll=[].obs;
  RxList ProjectDropdownName=[].obs;
  RxList ProjectDropdownNameAll=[].obs;


  RxInt selectedProjectId = 0.obs;
  RxInt selectedProjectIdAll = 0.obs;

  RxString selectedProjectName = "".obs;
  RxString selectedProjectNameAll = "".obs;


  LoginController loginController=Get.put(LoginController());


  Future getProjectList(BuildContext context,int check) async {
    getdropDownvalue.value.clear();
    getdropDownvalue.value= await CommonProvider.getproject(loginController.user.value.userId!,loginController.UserType());
      getdropDownvalue.value.forEach((element) {
        return ProjectDropdownName.value.add(element.project);
      });

    // else{
    //   getdropDownvalue.value.forEach((element) {
    //     return ProjectDropdownName.value.add(element.project);
    //   });
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return ProjectShowPopup(list:getdropDownvalue.value);
    //       });
    // }

  }

  setSelectedProjectID(String value) {
    if (getdropDownvalue.value.length>0) {
      getdropDownvalue.forEach((element) {
        if(value == element.project){
          selectedProjectId(element.projectId);
        }
      });
    }
    setSelectedProjectListName(selectedProjectId.value);
  }

  setSelectedProjectListName(int? id) {
    if (getdropDownvalue.value != null) {
      getdropDownvalue.value.forEach((element) {
        if (id == element.projectId) {
          selectedProjectName(element.project.toString());
        }
      });
    }
    projectname.text=selectedProjectName.value;
  }


  //-----------

  Future getProjectListAll(BuildContext context,int check) async {
    getdropDownvalueAll.value= await CommonProvider.getprojectAll();
    if(check==1){
      getdropDownvalueAll.value.forEach((element) {
        return ProjectDropdownNameAll.value.add(element.project);
      });
    }
    else{
      getdropDownvalueAll.value.forEach((element) {
        return ProjectDropdownNameAll.value.add(element.project);
      });
    }
  }

  setSelectedProjectIDAll(String value) {
    if (getdropDownvalueAll.value.length>0) {
      getdropDownvalueAll.forEach((element) {
        if(value == element.project){
          selectedProjectIdAll(element.projectId);
        }
      });
    }
    setSelectedProjectListNameAll(selectedProjectIdAll.value);
  }

  setSelectedProjectListNameAll(int? id) {
    if (getdropDownvalueAll.value != null) {
      getdropDownvalueAll.value.forEach((element) {
        if (id == element.projectId) {
          selectedProjectNameAll(element.project.toString());
        }
      });
    }
    projectnameAll.text=selectedProjectNameAll.value;
  }



}