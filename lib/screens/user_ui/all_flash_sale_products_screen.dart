import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:e_comm/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/categories_model.dart';
import '../../models/product_model.dart';
import 'single_category_product_screen.dart';

class AllFlashSaleProductsScreen extends StatefulWidget {
  const AllFlashSaleProductsScreen({super.key});

  @override
  State<AllFlashSaleProductsScreen> createState() =>
      _AllFlashSaleProductsScreenState();
}

class _AllFlashSaleProductsScreenState
    extends State<AllFlashSaleProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Flash Sale"),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('products')
              .where('isSale', isEqualTo: true)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: Get.height / 5,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Products Found"),
              );
            }
            if (snapshot.data != null) {
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1.19,
                ),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];

                  ProductModel productModel = ProductModel(
                    productId: productData['productId'],
                    categoryId: productData['categoryId'],
                    productName: productData['productName'],
                    categoryName: productData['categoryName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt'],
                  );
                  return Row(
                    children: [
                      GestureDetector(
                        // onTap: () => Get.to(() => SingleCategoryProductScreen(categoryId:categoriesModel.categoryId)),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            child: FillImageCard(
                              width: Get.width / 2.3,
                              heightImage: Get.height / 10,
                              borderRadius: 20,
                              imageProvider: CachedNetworkImageProvider(
                                  productModel.productImages[0]),
                              title: Center(
                                  child: Text(
                                productModel.productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 12),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}
