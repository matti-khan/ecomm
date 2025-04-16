import 'package:e_comm/controllers/sign_up_controller.dart';
import 'package:e_comm/screens/auth_ui/auth_screens/signin_screen.dart';
import 'package:e_comm/screens/auth_ui/auth_widgets/city_input_field.dart';
import 'package:e_comm/screens/auth_ui/auth_widgets/email_input_widget.dart';
import 'package:e_comm/screens/auth_ui/auth_widgets/name_input_widget.dart';
import 'package:e_comm/screens/auth_ui/auth_widgets/phone_input_field.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:e_comm/utils/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../auth_widgets/password_input_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.appSecondaryColor,
          title: const Text(
            "Sign Up",
            style: TextStyle(color: AppConstants.appTextColor),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 20,
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text("Welcome to ${AppConstants.appMainName}",
                        style: const TextStyle(
                        color: AppConstants.appSecondaryColor,
                        fontWeight: FontWeight.bold,fontSize: 16),
                    )),
                SizedBox(
                  height: Get.height / 20,
                ),
                EmailInputWidget(),
                SizedBox(
                  height: Get.height / 40,
                ),
                NameInputWidget(),
                SizedBox(
                  height: Get.height / 40,
                ),
                PhoneInputWidget(),
                SizedBox(
                  height: Get.height / 40,
                ),
                CityInputWidget(),
                SizedBox(
                  height: Get.height / 40,
                ),
                PasswordInputWidget(),
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
                        UserCredential? userCredential = await signUpController.signUpMethod('');

                        if(userCredential != null){
                          customSnackBar("Verification Email Sent.", "Check your Email.");

                          FirebaseAuth.instance.signOut();
                          Get.offAll(() => const SigninScreen());

                        }
                      },
                      label: const Text(
                        "SIGN UP",
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
                      "Already have an account?",
                      style: TextStyle(color: AppConstants.appSecondaryColor),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(() => const SigninScreen()),
                      child: const Text(
                        " Sign In",
                        style: TextStyle(
                            color: AppConstants.appSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
