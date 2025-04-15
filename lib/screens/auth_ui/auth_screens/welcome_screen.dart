import 'package:e_comm/res/assets/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstants.appSecondaryColor,
        title: const Text(
          "Welcome Back",
          style: TextStyle(color: AppConstants.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: AppConstants.appSecondaryColor,
              alignment: Alignment.center,
              child: Lottie.asset(ImageAssets.splashImage),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Happy Shopping",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12 ,
                decoration: BoxDecoration(
                  color: AppConstants.appSecondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  label: const Text("Sign in with Google",style: TextStyle(color: AppConstants.appTextColor),),
                  icon: Image.asset(ImageAssets.googleIcon),
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 50,
            ),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12 ,
                decoration: BoxDecoration(
                  color: AppConstants.appSecondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  label: const Text("Sign in with Email",style: TextStyle(color: AppConstants.appTextColor),),
                  icon: const Icon(Icons.email,color: AppConstants.appTextColor,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
