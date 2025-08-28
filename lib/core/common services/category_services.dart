import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/core/common%20model/category_model.dart';

class CategoryServices {
  static const colletionName = "category";

  static CollectionReference categoryRef = FirebaseFirestore.instance
      .collection(colletionName);

  static Future<List<CategoryModel>> getAllCategory() async {
    try {
      final QuerySnapshot querySnapshot = await categoryRef.get();
      final data = querySnapshot.docs
          .map((e) => CategoryModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      return data;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
