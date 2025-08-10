import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSeeder {
  static Future<void> seedProducts() async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    final products = [
      {
        "categoryId": "0KbiIu8A9ttk6dLolHjZ",
        "categoryName": "Women",
        "deliveryTime": "7 days",
        "fullPrice": "400",
        "isSale": false,
        "productDescription": "This is the description for the women products",
        "productImages": [
          "https://cdn.pixabay.com/photo/2016/03/12/21/05/boy-1252771_1280.jpg",
          "https://cdn.pixabay.com/photo/2020/06/30/09/22/boy-5355710_1280.jpg"
        ],
        "productName": "Shawls",
        "salePrice": "300",
      },
      {
        "categoryId": "0KbiIu8A9ttk6dLolHjZ",
        "categoryName": "Women",
        "deliveryTime": "5 days",
        "fullPrice": "600",
        "isSale": true,
        "productDescription": "Trendy women handbags",
        "productImages": [
          "https://cdn.pixabay.com/photo/2017/08/07/23/29/bag-2601914_1280.jpg",
          "https://cdn.pixabay.com/photo/2016/03/27/22/16/women-1283802_1280.jpg"
        ],
        "productName": "Handbags",
        "salePrice": "450",
      },
    ];

    for (var product in products) {
      final docRef = firestore.collection('products').doc();
      batch.set(docRef, {
        ...product,
        "productId": docRef.id,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
    print("✅ Products seeded successfully!");
  }
}
