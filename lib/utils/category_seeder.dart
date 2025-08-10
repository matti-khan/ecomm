import 'package:cloud_firestore/cloud_firestore.dart';

class CategorySeeder {
  static Future<void> seedCategories() async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    final categories = [
      {
        "categoryName": "Laptops",
        "categoryImg": "https://res.cloudinary.com/dutfu8e0u/image/upload/v1754807395/laptops_category_r9gge6.png",
      },
      {
        "categoryName": "Mobile Phones",
        "categoryImg": "https://res.cloudinary.com/dutfu8e0u/image/upload/v1754807392/smart_phones_category_pirg4t.png",
      },
      {
        "categoryName": "Handbags",
        "categoryImg": "https://res.cloudinary.com/dutfu8e0u/image/upload/v1754807391/handbags_category_vl8ya4.png",
      },
      {
        "categoryName": "Smart Watches",
        "categoryImg": "https://res.cloudinary.com/dutfu8e0u/image/upload/v1754807391/smart_watches_category_u5wc2p.png",
      },
      {
        "categoryName": "Women’s Jewelry",
        "categoryImg": "https://res.cloudinary.com/dutfu8e0u/image/upload/v1754807391/women_jewelry_category_cg8ygm.png",
      },
    ];

    for (var category in categories) {
      final docRef = firestore.collection('categories').doc();
      batch.set(docRef, {
        ...category,
        "categoryId": docRef.id,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
    print("✅ Categories seeded successfully!");
  }
}
