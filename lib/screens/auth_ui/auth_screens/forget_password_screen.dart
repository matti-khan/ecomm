import 'package:e_comm/controllers/forget_password_controller.dart';
import 'package:e_comm/res/assets/image_assets.dart';
import 'package:e_comm/screens/auth_ui/auth_screens/signin_screen.dart';
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

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());

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
                EmailInputWidget(controller: forgetPasswordController.emailInputController,),
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
                        forgetPasswordController.forgetPasswordMethod().then((success) {
                          if(success){
                            Get.off(() => const SigninScreen());
                          }
                        });
                      },
                      label: const Text(
                        "FORGET",
                        style: TextStyle(color: AppConstants.appTextColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
