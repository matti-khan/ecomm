import 'dart:async';

import 'package:e_comm/res/assets/image_assets.dart';
import 'package:e_comm/screens/auth_ui/auth_screens/welcome_screen.dart';
import 'package:e_comm/screens/user_ui/main_screen.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 1), (){
      Get.offAll(()=> WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {

    // final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppConstants.appSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppConstants.appSecondaryColor,
        elevation: 0,
      ),
      body: Container(
        width: Get.width,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              child: Lottie.asset(ImageAssets.splashImage),
            ),
            Container(
              width: Get.width,
               alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                AppConstants.appPoweredBy,
                style: const TextStyle(
                  color: AppConstants.appTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
