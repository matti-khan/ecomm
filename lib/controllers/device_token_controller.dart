import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../utils/custom_snackbar.dart';

class DeviceTokenController extends GetxController{
  String? deviceToken;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async{
    try{
      String? token = await FirebaseMessaging.instance.getToken();

      if(token != null){
        deviceToken = token;
        update();
      }

    }catch (e,s){
      if (kDebugMode) print("Error $e\nStack Trace $s");
      customSnackBar("Error", "$e");
    }
  }
}