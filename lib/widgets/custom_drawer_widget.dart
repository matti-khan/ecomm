import 'package:e_comm/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/auth_ui/auth_screens/welcome_screen.dart';

class CustomDrawerWidget extends StatelessWidget {
  final String? userName;
  final String? userPic;

  const CustomDrawerWidget({super.key, this.userName, this.userPic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: AppConstants.appSecondaryColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  userName ?? "Guest",
                  style: const TextStyle(color: AppConstants.appTextColor),
                ),
                subtitle: const Text(
                  "Version 1.0.0",
                  style: TextStyle(color: AppConstants.appTextColor),
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: AppConstants.appMainColor,
                  foregroundImage: userPic != null && userPic!.isNotEmpty ? NetworkImage(userPic!) : null,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              color: Colors.grey,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
                  style: TextStyle(color: AppConstants.appTextColor),
                ),
                leading: Icon(
                  Icons.home,
                  color: AppConstants.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppConstants.appTextColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Products",
                  style: TextStyle(color: AppConstants.appTextColor),
                ),
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: AppConstants.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppConstants.appTextColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Orders",
                  style: TextStyle(color: AppConstants.appTextColor),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: AppConstants.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppConstants.appTextColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Contact",
                  style: TextStyle(color: AppConstants.appTextColor),
                ),
                leading: Icon(
                  Icons.help,
                  color: AppConstants.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppConstants.appTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth fireaseAuth = FirebaseAuth.instance;

                  await googleSignIn.signOut();
                  await fireaseAuth.signOut();

                  Get.offAll(() => WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "Logout",
                  style: TextStyle(color: AppConstants.appTextColor),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: AppConstants.appTextColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppConstants.appTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
