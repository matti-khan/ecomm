import 'package:e_comm/res/assets/image_assets.dart';
import 'package:e_comm/screens/auth_ui/auth_screens/signup_screen.dart';
import 'package:e_comm/screens/auth_ui/auth_widgets/email_input_widget.dart';
import 'package:e_comm/screens/user_ui/main_screen.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:e_comm/utils/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/sign_in_controller.dart';
import '../../../controllers/sign_up_controller.dart';
import '../auth_widgets/password_input_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.appSecondaryColor,
          title: const Text(
            "Sign In",
            style: TextStyle(color: AppConstants.appTextColor),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                isKeyboardVisible
                    ? const SizedBox.shrink()
                    : Container(
                        width: Get.width,
                        height: Get.height / 2.5,
                        color: AppConstants.appSecondaryColor,
                        child: Lottie.asset(ImageAssets.splashImage)),
                SizedBox(
                  height: Get.height / 20,
                ),
                EmailInputWidget(controller: signInController.emailInputController,),
                SizedBox(
                  height: Get.height / 40,
                ),
                PasswordInputWidget(getxController: signInController,),
                SizedBox(
                  height: Get.height / 60,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: AppConstants.appSecondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Material(
                  child: Container(
                    width: Get.width / 2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: AppConstants.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton.icon(
                      onPressed: () async {
                        UserCredential? userCredential= await signInController.signInMethod('');
                        if(userCredential != null){
                          if(userCredential.user!.emailVerified){
                            customSnackBar("Success", "Login Successfully!");
                            Get.offAll(() => const MainScreen());
                          }else{
                            customSnackBar("Error", "Please verify your email before login.");
                          }
                        }
                      },
                      label: const Text(
                        "SIGN IN",
                        style: TextStyle(color: AppConstants.appTextColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: AppConstants.appSecondaryColor),
                    ),
                    GestureDetector(
                        onTap: () => Get.off(() => const SignUpScreen()),
                        child: const Text(
                          " Sign Up",
                          style: TextStyle(
                              color: AppConstants.appSecondaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
