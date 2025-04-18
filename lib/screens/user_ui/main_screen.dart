import 'package:e_comm/screens/auth_ui/auth_screens/welcome_screen.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:e_comm/widgets/banner_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../widgets/custom_drawer_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstants.appTextColor),
        backgroundColor: AppConstants.appMainColor,
        title: Text(AppConstants.appMainName,style: const TextStyle(color: AppConstants.appTextColor),),
        centerTitle: true,
      ),
      drawer: const CustomDrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height / 90 ,),
              BannerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
