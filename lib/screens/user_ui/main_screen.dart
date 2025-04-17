import 'package:e_comm/screens/auth_ui/auth_screens/welcome_screen.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appMainColor,
        title: Text(AppConstants.appMainName),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: ()async{
              GoogleSignIn googleSignIn = GoogleSignIn();
              FirebaseAuth fireaseAuth = FirebaseAuth.instance;

              await googleSignIn.signOut();
              await fireaseAuth.signOut();

              Get.offAll(() => WelcomeScreen());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}
