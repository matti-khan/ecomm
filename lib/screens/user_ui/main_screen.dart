import 'package:e_comm/screens/auth_ui/auth_screens/welcome_screen.dart';
import 'package:e_comm/screens/user_ui/all_categories_screen.dart';
import 'package:e_comm/screens/user_ui/all_flash_sale_products_screen.dart';
import 'package:e_comm/screens/user_ui/all_products_screen.dart';
import 'package:e_comm/screens/user_ui/cart_screen.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:e_comm/widgets/all_products_widget.dart';
import 'package:e_comm/widgets/banner_widget.dart';
import 'package:e_comm/widgets/category_widget.dart';
import 'package:e_comm/widgets/flash_sale_widget.dart';
import 'package:e_comm/widgets/heading_widget.dart';
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
        title: Text(
          AppConstants.appMainName,
          style: const TextStyle(color: AppConstants.appTextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      drawer: const CustomDrawerWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90,
              ),
              const BannerWidget(),
              HeadingWidget(
                title: 'Categories',
                subTitle: 'According to your Budget',
                buttonText: 'See More >',
                onTap: () => Get.to(() => const AllCategoriesScreen()),
              ),
              const CategoryWidget(),
              HeadingWidget(
                title: 'Flash Sale',
                subTitle: 'According to your Budget',
                buttonText: 'See More >',
                onTap: () => Get.to(() => const AllFlashSaleProductsScreen()),
              ),
              const FlashSaleWidget(),
              HeadingWidget(
                title: 'All Products',
                subTitle: 'According to your Budget',
                buttonText: 'See More >',
                onTap: () => Get.to(() => const AllProductsScreen()),
              ),
              const AllProductsWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
