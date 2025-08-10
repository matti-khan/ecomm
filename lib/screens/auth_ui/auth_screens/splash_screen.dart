import 'dart:async';

import 'package:e_comm/controllers/user_data_controller.dart';
import 'package:e_comm/res/assets/image_assets.dart';
import 'package:e_comm/screens/admin_ui/admin_main_screen.dart';
import 'package:e_comm/screens/auth_ui/auth_screens/welcome_screen.dart';
import 'package:e_comm/screens/user_ui/main_screen.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), (){
      loggedIn(context);
    });
  }

  Future<void> loggedIn(BuildContext context) async{
    if(user != null){
      final UserDataController userDataController = Get.put(UserDataController());
      var userData = await userDataController.getUserData(user!.uid);

      if(userData[0]['isAdmin'] == true){
        Get.offAll(()=> const AdminMainScreen());
      }else{
        Get.offAll(()=> MainScreen(userName: userData[0]['username'],userPic: userData[0]['userImg'],));
      }
    }else{
      Get.offAll(()=> WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {

    // final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppConstants.appSecondaryColor,
      floatingActionButton: Text(
        AppConstants.appPoweredBy,
        style: const TextStyle(
          color: AppConstants.appTextColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        width: Get.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Lottie.asset(ImageAssets.splashImage,repeat: false),
            ),
            Container(
              width: Get.width,
               alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                AppConstants.appTagLine,
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
