import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/favorite/favorite_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/favorite/favorite_notifier.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class FavoriteService {
  static const String favorites = 'favorites';
  static const String user = 'users';
  static const String product = 'products';
  static final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  static final CollectionReference favoriteRef = FirebaseFirestore.instance
      .collection(user)
      .doc(currentUserId)
      .collection(favorites);
  static final CollectionReference productRef = FirebaseFirestore.instance
      .collection(product);

  //add
  static Future<bool> addToFavorite({required ProductModel product}) async {
    try {
      final docRef = favoriteRef.doc();
      final FavoriteModel favoruteModel = FavoriteModel(
        favoriteId: docRef.id,
        productId: product.productId!,
        customerId: currentUserId,
      );
      await favoriteRef.doc(docRef.id).set(favoruteModel.toMap());
      //store in local also
      await HiveHelper.addFavorites(favorite: favoruteModel);
      return true;
    } catch (e) {
      log("favorite service error $e");
      return false;
    }
  }

  //get

  static Future<Set<FavoriteModel>> fetchFavorites() async {
    try {
      final QuerySnapshot querySnapshot = await favoriteRef.get();
      final data = querySnapshot.docs
          .map((e) => FavoriteModel.fromMap(e.data() as Map<String, dynamic>))
          .toSet();
      //store in local

      for (final favorite in data) {
        await HiveHelper.addFavorites(favorite: favorite);
      }
      return data;
    } catch (e) {
      log("favorite service error $e");
      return {};
    }
  }

  static Future<bool> deleteFavorite({
    required String favoriteId,
    required WidgetRef ref,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await favoriteRef
          .where('favoriteId', isEqualTo: favoriteId)
          .where('customerId', isEqualTo: currentUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        //delete from local
        await HiveHelper.deleteFavorite(key: favoriteId);
        ref
            .read(favoriteProvider.notifier)
            .removeFromFavorite(favProductId: favoriteId);
        return true;
      }
    } catch (e) {
      log("favorite service error $e");
      return false;
    }
    return false;
  }

  static Future<Set<ProductModel>> fetchUserFavoriteProducts() async {
    try {
      final List<ProductModel> favData = [];
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(user)
          .doc(currentUserId)
          .collection(favorites)
          .get();
      for (final doc in querySnapshot.docs) {
        final productId = doc["productId"] as String;
        final product = await productRef
            .where("productId", isEqualTo: productId)
            .get();
        if (product.docs.isNotEmpty) {
          final data = product.docs
              .map(
                (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>),
              )
              .toList();
          favData.addAll(data);
          return favData.toSet();
        } else {
          return {};
        }
      }
    } catch (e) {
      log("favorite service error $e");
      return {};
    }
    return {};
  }
}
