import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/custom_snackbar.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // for password visibility
  Rx<bool> isPasswordVisible = false.obs;

  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  @override
  void onClose() {
    emailInputController.dispose();
    passwordInputController.dispose();
    super.onClose();
  }

  Future<UserCredential?> signInMethod(
      String userDeviceToken,
      ) async {
    try {
      if (emailInputController.text.isNotEmpty &&
          passwordInputController.text.isNotEmpty) {

        EasyLoading.show(status: "Please wait");

        UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
          email: emailInputController.text.trim(),
          password: passwordInputController.text.trim(),
        );

        EasyLoading.dismiss();

        return userCredential;

      } else {
        customSnackBar("Error", "Please Fill All Fields");
        return null;
      }
    } on FirebaseAuthException catch (e, s) {
      EasyLoading.dismiss();
      if (kDebugMode) print("Error $e\nStack Trace $s");
      customSnackBar("Error", "$e");
      return null;
    }
  }
}
