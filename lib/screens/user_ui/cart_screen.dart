import 'package:e_comm/utils/app_constants.dart';
import 'package:e_comm/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Cart Screen"),
      body: Container(
        child: ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              color: AppConstants.appTextColor,
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppConstants.appMainColor,
                  child: Text(
                    "M",
                    style: TextStyle(color: AppConstants.appTextColor),
                  ),
                ),
                title: Text("New Dress for men"),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("2200"),
                    SizedBox(
                      width: Get.width / 20,
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppConstants.appMainColor,
                      child: Text("-"),
                    ),
                    SizedBox(
                      width: Get.width / 20,
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppConstants.appMainColor,
                      child: Text("+"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Total: ",
                  ),
                  TextSpan(text: "PKR 12,00",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstants.appSecondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Checkout",
                      style: TextStyle(color: AppConstants.appTextColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
