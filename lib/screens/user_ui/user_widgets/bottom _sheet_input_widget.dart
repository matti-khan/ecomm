import 'package:flutter/material.dart';

class BottomSheetInputWidget extends StatelessWidget {
  const BottomSheetInputWidget({super.key, this.keyboardType = TextInputType.text,});

  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20,),
      height: 55,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: "Name",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          hintStyle: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
