import '../commonpopup/fromprojectalert.dart';
import '../controller/logincontroller.dart';
import '../provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FromProjectController extends GetxController{

  final fromprojectname= TextEditingController();
  RxInt selectedProjectId = 0.obs;
  RxString selectedProjectName = "".obs;
  RxList FrProjectDropdownName=[].obs;
  RxList getdropDownvalue=[].obs;
  RxList mainlist=[].obs;
  LoginController loginController = Get.put(LoginController());

  Future getProjectList(BuildContext context,int check,reqid) async {
    getdropDownvalue.value = await CommonProvider.getFromproject(loginController.user.value.userId, loginController.UserType(),reqid);


    if(check==1){
      getdropDownvalue.value.forEach((element) {
        return FrProjectDropdownName.value.add(element.project);
      });
    }
    else{
      getdropDownvalue.value.forEach((element) {
        return FrProjectDropdownName.value.add(element.project);
      });
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return FrProjectShowPopup(list:getdropDownvalue.value);
      //     });
    }

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
    fromprojectname.text=selectedProjectName.value;
  }
}