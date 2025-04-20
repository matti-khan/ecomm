import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/categories_model.dart';
import 'package:e_comm/screens/user_ui/single_category_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('categories').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Category Found"),
            );
          }
          if (snapshot.data != null) {
            return Container(
              height: Get.height / 5.5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CategoriesModel categoriesModel = CategoriesModel(
                      categoryId: snapshot.data!.docs[index]['categoryId'],
                      categoryImg: snapshot.data!.docs[index]['categoryImg'],
                      categoryName: snapshot.data!.docs[index]['categoryName'],
                      createdAt: snapshot.data!.docs[index]['createdAt'],
                      updatedAt: snapshot.data!.docs[index]['updatedAt'],
                    );
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => SingleCategoryProductScreen(categoryId: categoriesModel.categoryId)),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              child: FillImageCard(
                                width: Get.width / 4,
                                heightImage: Get.height / 10,
                                borderRadius: 20,
                                imageProvider: CachedNetworkImageProvider(categoriesModel.categoryImg),
                                title: Center(child: Text(categoriesModel.categoryName,style: TextStyle(fontSize: 12),)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }
          return Container();
        });
  }
}
