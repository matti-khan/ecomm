import 'package:flutter/cupertino.dart';

class ManageKeyboard{
  static void hideKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);

    if(!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();
    }
  }
}