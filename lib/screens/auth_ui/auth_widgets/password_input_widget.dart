import 'package:e_comm/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/sign_up_controller.dart';

class PasswordInputWidget extends StatelessWidget {
  PasswordInputWidget({super.key});

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: Get.width,
      child: Obx(() => TextFormField(
            controller: signUpController.passwordInputController,
            obscureText: signUpController.isPasswordVisible.value,
            cursorColor: AppConstants.appSecondaryColor,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.password),
                suffixIcon: GestureDetector(
                  onTap: () {
                    signUpController.isPasswordVisible.toggle();
                  },
                  child: signUpController.isPasswordVisible.value
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                contentPadding: const EdgeInsets.only(top: 2, left: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          )),
    );
  }
}
