import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/category_model.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class CategoryServices {
  static const colletionName = "category";

  static CollectionReference categoryRef = FirebaseFirestore.instance
      .collection(colletionName);

  static Future<List<CategoryModel>> getAllCategory({required Ref ref}) async {
    try {
      ref.read(loadingProvider.notifier).state = true;
      final QuerySnapshot querySnapshot = await categoryRef.get();
      final List<CategoryModel> data = querySnapshot.docs
          .map((e) => CategoryModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();

      for (final category in data) {
        await HiveHelper.addCategories(category: category);
      }
      ref.read(loadingProvider.notifier).state = false;
      return data;
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      log("category service error $e");
      return [];
    }
  }
}
