import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/category_seeder.dart';
import '../../utils/product_seeder.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await CategorySeeder.seedCategories();
              },
              child: const Text("Seed Categories"),
            ),
            TextButton(
              onPressed: () async {
                await ProductSeeder.seedProducts();
              },
              child: const Text("Seed Products"),
            ),
            TextButton(
              onPressed: () async {
                await addIphone16Product();
              },
              child: const Text("Seed iphone 16"),
            ),
            TextButton(
              onPressed: () async {
                await addSampleProducts();
              },
              child: const Text("Add product"),
            ),
            TextButton(
              onPressed: () async {
                await addMoreMobileProducts();
              },
              child: const Text("Add multiple products"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addIphone16Product() async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('products').doc();

    await docRef.set({
      "categoryId": "MOBILE_CATEGORY_ID", // replace with your actual mobile phones categoryId
      "categoryName": "Mobile Phones",
      "createdAt": FieldValue.serverTimestamp(),
      "deliveryTime": "3-5 days",
      "fullPrice": "1200",
      "isSale": true,
      "productDescription": "Latest iPhone 16 with cutting-edge features, A17 chip, and advanced camera system.",
      "productId": docRef.id,
      "productImages": [
        "https://images.unsplash.com/photo-1726587912121-ea21fcc57ff8?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      ],
      "productName": "iPhone 16",
      "salePrice": "1100",
      "updatedAt": FieldValue.serverTimestamp(),
    });

    print("✅ iPhone 16 product added successfully!");
  }

  Future<void> addProduct({
    required String categoryId,
    required String categoryName,
    required String productName,
    required List<String> productImages,
    required String productDescription,
    required String fullPrice,
    required String salePrice,
    required bool isSale,
    required String deliveryTime,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('products').doc();

    await docRef.set({
      "categoryId": categoryId,
      "categoryName": categoryName,
      "productId": docRef.id,
      "productName": productName,
      "productImages": productImages,
      "productDescription": productDescription,
      "fullPrice": fullPrice,
      "salePrice": salePrice,
      "isSale": isSale,
      "deliveryTime": deliveryTime,
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });

    print("✅ Product '$productName' added successfully!");
  }

  Future<void> addSampleProducts() async {
    const categoryId = "TeUCKgy3n5gfnjyEmLSX";

    await addProduct(
      categoryId: categoryId,
      categoryName: "Mobile Phones",
      productName: "Samsung Galaxy S23",
      productImages: [
        "https://images.unsplash.com/photo-1709744722656-9b850470293f?q=80&w=327&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
      productDescription: "Experience the power of the Snapdragon 8 Gen 2 processor with the Samsung Galaxy S23. Capture stunning photos with its 50MP main camera and enjoy a smooth 6.1-inch Dynamic AMOLED display.",
      fullPrice: "799",
      salePrice: "749",
      isSale: true,
      deliveryTime: "3-5 days",
    );
  }

  Future<void> addMoreMobileProducts() async {
    const categoryId = "TeUCKgy3n5gfnjyEmLSX";
    const categoryName = "Mobile Phones";

    final List<Map<String, dynamic>> products = [
      {
        "productName": "iPhone 14 Pro",
        "productImages": [
          "https://images.unsplash.com/photo-1609945557891-8c7aa12de1d3?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ],
        "productDescription": "Apple iPhone 14 Pro with A16 Bionic chip, ProMotion display, and triple-camera system.",
        "fullPrice": "999",
        "salePrice": "899",
        "isSale": true,
        "deliveryTime": "3-5 days",
      },
      {
        "productName": "OnePlus 11",
        "productImages": [
          "https://images.unsplash.com/photo-1527747471697-174c755627dd?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ],
        "productDescription": "OnePlus 11 with Snapdragon 8 Gen 2, 120Hz AMOLED display, and Hasselblad cameras.",
        "fullPrice": "799",
        "salePrice": "749",
        "isSale": true,
        "deliveryTime": "3-5 days",
      },
      {
        "productName": "Google Pixel 7",
        "productImages": [
          "https://images.unsplash.com/photo-1669888940542-bf597f76ef39?q=80&w=869&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ],
        "productDescription": "Google Pixel 7 with Google Tensor G2 chip, excellent camera, and clean Android experience.",
        "fullPrice": "699",
        "salePrice": "649",
        "isSale": true,
        "deliveryTime": "3-5 days",
      },
      {
        "productName": "Huawei P50 Pro",
        "productImages": [
          "https://images.unsplash.com/photo-1591884539376-42f1f0dc65c2?q=80&w=585&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ],
        "productDescription": "Huawei P50 Pro with powerful camera system and sleek design.",
        "fullPrice": "899",
        "salePrice": "849",
        "isSale": true,
        "deliveryTime": "5-7 days",
      },
      {
        "productName": "Oppo Find X5",
        "productImages": [
          "https://images.unsplash.com/photo-1741061964313-f990e7cb9f38?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ],
        "productDescription": "Oppo Find X5 with flagship specs and sleek design.",
        "fullPrice": "799",
        "salePrice": "759",
        "isSale": true,
        "deliveryTime": "3-5 days",
      },
    ];

    for (Map<String, dynamic> product in products) {
      await addProduct(
        categoryId: categoryId,
        categoryName: categoryName,
        productName: product["productName"] as String,
        productImages: List<String>.from(product["productImages"] as List),
        productDescription: product["productDescription"] as String,
        fullPrice: product["fullPrice"] as String,
        salePrice: product["salePrice"] as String,
        isSale: product["isSale"] as bool,
        deliveryTime: product["deliveryTime"] as String,
      );
    }
  }


}
