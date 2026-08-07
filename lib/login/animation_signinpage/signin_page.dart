import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mcr/utilities/baseutitiles.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:upgrader/upgrader.dart';
import '../../controller/logincontroller.dart';
import 'Animations/FadeAnimation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static Future<void> checkVersion(BuildContext context) async {
    final newVersion = NewVersionPlus(
      androidId: 'com.veenus.mcr',
    );

    final status = await newVersion.getVersionStatus();

    if (status != null && status.canUpdate) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: false,
        dialogTitle: "Update App?",
        dialogText:
        "A new version of MCR Construction is available!\n\n"
            "Version ${status.storeVersion} is now available!",
        updateButtonText: "UPDATE NOW",
      );
    }
  }

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  LoginController loginController = Get.put(LoginController());

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(colors: [Colors.black, Colors.redAccent,]),
    borderRadius: BorderRadius.circular(32),
  );

  bool _isObscure = true;


  final _Formkey = GlobalKey<FormState>();

  @override
  void initState() {
    loginController.password_controller.clear();
    loginController.username_controller.clear();
    SignInPage.checkVersion(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _Formkey,
          child: Container(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 15/100),
                FadeAnimation(
                  1.2,
                  Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.rotationZ(
                      3.1415926535897932 / 4,
                    ),
                    child: Container(
                      height: 210,
                      width: 210,
                      decoration: kGradientBoxDecoration,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: kInnerDecoration,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationZ(
                              -3.1415926535897932 / 4,
                            ),
                            child: FractionallySizedBox(
                              widthFactor: 1,  // 50% of parent width
                              heightFactor: 0.6, // 50% of parent height
                              child: Image.asset(
                                "assets/images/resizelogo_new.jpg",
                                fit: BoxFit.contain,
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeAnimation(1.2, const Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )),
                const SizedBox(height: 30),
                FadeAnimation(
                  1.5, Column(
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.black,
                      controller: loginController.username_controller,
                      validator: (validater) {
                        if (validater!.isEmpty) {
                          return '\u26A0 Enter UserName';
                        } else {
                          return null;
                        }
                        // return value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: "User Name",
                        labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.account_circle,
                          color: Colors.indigo,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.indigo,
                              // color: Color(0xFFEC407A),
                            )),
                        filled: null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: _isObscure,
                      cursorColor: Colors.black,
                      controller: loginController.password_controller,
                      validator: (validater) {
                        if (validater!.isEmpty) {
                          return "\u26A0 Enter Password";
                        } else {
                          return null;
                        }
                        // return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: "Password",
                        labelStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
                        prefixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.indigo,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              // color: Color(0xFFEC407A),
                              color: Colors.indigo,
                            )),
                      ),
                    ),
                  ],
                ),
                ),
                //---Need for Next Updation--------
                // FadeAnimation(1.8, Container(
                //   margin: EdgeInsets.only(top: 20),
                //   alignment: Alignment.bottomRight,
                //   width: 350,
                //   child: Text("Forgot Password", style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
                // )),
                const SizedBox(height: 20),
                FadeAnimation(
                    1.8,
                    InkWell(
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.indigo.shade50),
                        child: Center(
                            child: Text("Sign In",
                              style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                            )),
                      ),
                      onTap: () async {
                        if(_Formkey.currentState!.validate()){
                          _Formkey.currentState!.save();
                          if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                         loginController.getLoginDetails(context);
                        }
                        }},
                    )),
                SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
                FadeAnimation(
                  1.8,
                  const Column(
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                      //   child: const Text(
                      //     "New User? Create an account.",
                      //     style: TextStyle(color: Colors.indigo),
                      //   ),
                      // ),
                      Text("POWERED BY VEENUS SOFTWARE TECHNOLOGY",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
