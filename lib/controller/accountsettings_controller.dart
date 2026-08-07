import '../constants/storage_constant.dart';
import '../controller/logincontroller.dart';
import '../login/animation_signinpage/welcomepage.dart';
import '../provider/authendication_provider.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSetingController  extends GetxController{

  LoginController loginController=Get.put(LoginController());
  final repassword_controller = TextEditingController();
  final password_controller = TextEditingController();


  changePasswordDetails(BuildContext context) async {
    await AuthendicationProvider.changePassword(loginController.UserId(),password_controller.text,BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null) {
        BaseUtitiles.showToast("Password Changed Successfully");
        SessionStorage.removeUser();
        Navigator.pushAndRemoveUntil(
          context,
          // MaterialPageRoute(builder: (context) => LoginScreen()),
          MaterialPageRoute(builder: (context) => const WelcomePage()),
              (Route<dynamic> route) => false,
        );
      } else {
        BaseUtitiles.showToast("Updated Failed");
      }
    });
  }
}