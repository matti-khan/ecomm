import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/custom_snackbar.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<bool> isPasswordVisible = false.obs;

  TextEditingController emailInputController = TextEditingController();

  @override
  void onClose() {
    emailInputController.dispose();
    super.onClose();
  }

  Future<bool> forgetPasswordMethod() async {
    try {
      if (emailInputController.text.isNotEmpty) {

        EasyLoading.show(status: "Please wait");

        await _auth.sendPasswordResetEmail(email: emailInputController.text.trim());

        customSnackBar("Reset Email Sent", "Password reset Email sent to ${emailInputController.text}");

        EasyLoading.dismiss();

        return true;

      } else {
        customSnackBar("Error", "Please Enter Email");
        return false;
      }
    } on FirebaseAuthException catch (e, s) {
      EasyLoading.dismiss();
      if (kDebugMode) print("Error $e\nStack Trace $s");
      customSnackBar("Error", "$e");
      return false;
    }
  }
}
