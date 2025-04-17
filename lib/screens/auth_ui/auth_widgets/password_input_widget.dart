import 'package:e_comm/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordInputWidget extends StatelessWidget {
  final GetxController getxController;

  const PasswordInputWidget({super.key, required this.getxController});

  @override
  Widget build(BuildContext context) {

    final controller = getxController as dynamic;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      child: Obx(() => TextFormField(
        controller: controller.passwordInputController,
        obscureText: !(controller.isPasswordVisible as RxBool).value,
        cursorColor: AppConstants.appSecondaryColor,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: GestureDetector(
            onTap: () {
              (controller.isPasswordVisible as RxBool).toggle();
            },
            child: Icon(
              (controller.isPasswordVisible as RxBool).value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 2, left: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      )),
    );
  }
}
