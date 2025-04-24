import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/cart_model.dart';
import 'package:e_comm/utils/app_constants.dart';
import 'package:e_comm/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/product_model.dart';
import 'product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Cart Screen"),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cart')
              .doc(user!.uid)
              .collection('cartOrders')
              .snapshots(),
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
                child: Text("No Product  Found"),
              );
            }
            if (snapshot.data != null) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    CartModel cartModel = CartModel(
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
                      productQuantity: productData['productQuantity'],
                      productTotalPrice: productData['productTotalPrice'],
                    );
                    return SwipeActionCell(
                      key: ObjectKey(cartModel.productId),
                      trailingActions: [
                        SwipeAction(
                          // title: "Delete",
                          icon: const Icon(Icons.delete,color: Colors.red,
                          size: 30,),
                          color: Colors.transparent,
                          forceAlignmentToBoundary: true,
                          performsFirstActionWithFullSwipe: true,
                          onTap: (CompletionHandler handler) async {
                            if (kDebugMode) print("deleted ${cartModel.productId}");

                            await FirebaseFirestore.instance
                                .collection('cart')
                                .doc(user!.uid)
                                .collection('cartOrders')
                                .doc(cartModel.productId)
                                .delete();
                          },
                        ),
                      ],
                      child: Card(
                        color: AppConstants.appTextColor,
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppConstants.appMainColor,
                            backgroundImage:
                                NetworkImage(cartModel.productImages[0]),
                          ),
                          title: Text(cartModel.productName),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${cartModel.productTotalPrice}"),
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
                      ),
                    );
                  },
                ),
              );

              //   GridView.builder(
              //   itemCount: snapshot.data!.docs.length,
              //   shrinkWrap: true,
              //   physics: const BouncingScrollPhysics(),
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 5,
              //     crossAxisSpacing: 5,
              //     childAspectRatio: 0.80,
              //   ),
              //   itemBuilder: (context, index) {
              //     final productData = snapshot.data!.docs[index];
              //
              //     CartModel productModel = CartModel(
              //       productId: productData['productId'],
              //       categoryId: productData['categoryId'],
              //       productName: productData['productName'],
              //       categoryName: productData['categoryName'],
              //       salePrice: productData['salePrice'],
              //       fullPrice: productData['fullPrice'],
              //       productImages: productData['productImages'],
              //       deliveryTime: productData['deliveryTime'],
              //       isSale: productData['isSale'],
              //       productDescription: productData['productDescription'],
              //       createdAt: productData['createdAt'],
              //       updatedAt: productData['updatedAt'],
              //       productQuantity: productData['productQuantity'],
              //       productTotalPrice: productData['productTotalPrice'],
              //     );
              //     return Row(
              //       children: [
              //         GestureDetector(
              //           // onTap: () => Get.to(() =>
              //           //     ProductDetailScreen(productModel: productModel)),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8),
              //             child: Container(
              //               child: FillImageCard(
              //                 width: Get.width / 2.3,
              //                 heightImage: Get.height / 6,
              //                 borderRadius: 20,
              //                 imageProvider: CachedNetworkImageProvider(
              //                     productModel.productImages[0]),
              //                 title: Center(
              //                   child: Text(
              //                     productModel.productName,
              //                     overflow: TextOverflow.ellipsis,
              //                     maxLines: 1,
              //                     style: const TextStyle(fontSize: 12),
              //                   ),
              //                 ),
              //                 footer: Center(
              //                     child: Text("PKR ${productModel.fullPrice}")),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // );
            }
            return Container();
          }),
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
                  TextSpan(
                    text: "PKR 12,00",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
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
