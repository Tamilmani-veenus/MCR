import 'package:get_storage/get_storage.dart';

import '../controller/logincontroller.dart';
import '../controller/menu_controller.dart';
import '../provider/common_provider.dart';
import 'package:get/get.dart';


class CommanController extends GetxController {

  RxInt deleteMode=0.obs;
  RxInt editMode=0.obs;
  RxInt addMode=0.obs;

  LoginController loginController = Get.put(LoginController());
  Menu_Controller menuController = Get.put(Menu_Controller());

  Future getControllEntryListRights() async {
    deleteMode.value=0;
    editMode.value=0;
    await CommonProvider.getSubControllerRightsEntryList(loginController.user.value.userId, menuController.formName.value).then((value) async {
      if (value != null && value.length > 0) {
        value.forEach((element) {
          deleteMode.value=element.deleteMode!;
          editMode.value=element.editMode!;
          addMode.value=element.addMode!;
        });
        return value;
      }
    });
  }
}


