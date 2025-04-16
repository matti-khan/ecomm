import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/custom_snackbar.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // for password visibility
  Rx<bool> isPasswordVisible = false.obs;

  TextEditingController nameInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();
  TextEditingController cityInputController = TextEditingController();

  @override
  void onClose() {
    nameInputController.dispose();
    emailInputController.dispose();
    passwordInputController.dispose();
    phoneInputController.dispose();
    cityInputController.dispose();
    super.onClose();
  }

  Future<UserCredential?> signUpMethod(
    String userDeviceToken,
  ) async {
    try {
      if (nameInputController.text.isNotEmpty &&
          emailInputController.text.isNotEmpty &&
          passwordInputController.text.isNotEmpty &&
          phoneInputController.text.isNotEmpty &&
          cityInputController.text.isNotEmpty) {

        EasyLoading.show(status: "Please wait");

        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailInputController.text.trim(),
          password: passwordInputController.text.trim(),
        );

        await userCredential.user!.sendEmailVerification();

        UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          username: nameInputController.text,
          email: emailInputController.text,
          phone: phoneInputController.text,
          userImg: '',
          userDeviceToken: userDeviceToken,
          country: '',
          userAddress: '',
          street: '',
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now(),
          city: cityInputController.text,
        );

        firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toMap());

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
