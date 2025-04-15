import 'package:e_comm/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneInputWidget extends StatelessWidget {
  const PhoneInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: Get.width,
      child: TextFormField(
        cursorColor: AppConstants.appSecondaryColor,
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        decoration: InputDecoration(
            hintText: "Phone",
            prefixIcon: const Icon(Icons.phone),
            contentPadding: const EdgeInsets.only(top: 2,left: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
