import 'package:get/get.dart';

import 'app_constants.dart';

void customSnackBar(String title,String subtitle){
  Get.snackbar(
    title,
    subtitle,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppConstants.appSecondaryColor,
    colorText: AppConstants.appTextColor,
  );
}