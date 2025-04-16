import 'package:e_comm/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/sign_up_controller.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: Get.width,
      child: TextFormField(
        controller: controller,
        cursorColor: AppConstants.appSecondaryColor,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: "Email",
            prefixIcon: const Icon(Icons.email),
            contentPadding: const EdgeInsets.only(top: 2,left: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
