import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/cart_model.dart';
import 'package:e_comm/models/categories_model.dart';
import 'package:e_comm/models/product_model.dart';
import 'package:e_comm/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Product Details",
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
      body: Container(
        child: Column(
          children: [
            SizedBox(height: Get.height / 60),
            //product images
            CarouselSlider(
              items: productModel.productImages
                  .map(
                    (imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context, url) => const ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
                // enlargeCenterPage: true
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              productModel.productName,
                            ),
                          ),
                          const Icon(Icons.favorite_outline)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Text(
                              productModel.isSale == true &&
                                      productModel.salePrice.isNotEmpty
                                  ? "PKR ${productModel.salePrice}"
                                  : "PKR ${productModel.fullPrice}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Category: ${productModel.categoryName}",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          productModel.productDescription,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Get.width / 3,
                            height: Get.height / 18,
                            decoration: BoxDecoration(
                              color: AppConstants.appSecondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton.icon(
                              onPressed: () async {
                                checkProductExistence(uId: user!.uid);
                              },
                              label: const Text(
                                "Add to Cart",
                                style:
                                    TextStyle(color: AppConstants.appTextColor),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Get.width / 3,
                            height: Get.height / 18,
                            decoration: BoxDecoration(
                              color: AppConstants.appSecondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton.icon(
                              onPressed: () {},
                              label: const Text(
                                "WhatsApp",
                                style:
                                    TextStyle(color: AppConstants.appTextColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(productModel.productId.toString());
    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(productModel.isSale
              ? productModel.salePrice
              : productModel.fullPrice) *
          updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice,
      });
      if (kDebugMode) print("product exists");
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId': uId,
        'createdAt': DateTime.now(),
      });
    }
    CartModel cartModel = CartModel(
      productId: productModel.productId,
      categoryId: productModel.categoryId,
      productName: productModel.productName,
      categoryName: productModel.categoryName,
      salePrice: productModel.salePrice,
      fullPrice: productModel.fullPrice,
      productImages: productModel.productImages,
      deliveryTime: productModel.deliveryTime,
      isSale: productModel.isSale,
      productDescription: productModel.productDescription,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      productQuantity: 1,
      productTotalPrice: double.parse(productModel.isSale
          ? productModel.salePrice
          : productModel.fullPrice),
    );
    await documentReference.set(cartModel.toMap());
    if (kDebugMode) print("product added successfully");
  }
}
