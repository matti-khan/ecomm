import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key,required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppConstants.appTextColor),
      backgroundColor: AppConstants.appMainColor,
      title: Text(
        title,
        style: const TextStyle(color: AppConstants.appTextColor),
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
