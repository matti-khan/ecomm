import 'package:e_comm/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityInputWidget extends StatelessWidget {
  const CityInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: Get.width,
      child: TextFormField(
        cursorColor: AppConstants.appSecondaryColor,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
            hintText: "City",
            prefixIcon: const Icon(Icons.location_pin),
            contentPadding: const EdgeInsets.only(top: 2,left: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
