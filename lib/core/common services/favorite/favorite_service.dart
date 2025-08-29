import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/core/common%20model/favorite/favorite_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class FavoriteService {
  static const String favorites = 'favorites';
  static final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  static final CollectionReference favoriteRef = FirebaseFirestore.instance
      .collection(favorites);

  //add
  Future<bool> addToFavorite({required ProductModel product}) async {
    try {
      final docRef = favoriteRef.doc();
      final FavoruteModel favoruteModel = FavoruteModel(
        favoriteId: docRef.id,
        productId: product.productId,
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
  Future<List<FavoruteModel>> fetchFavorites() async {
    try {
      final QuerySnapshot querySnapshot = await favoriteRef.get();
      final data = querySnapshot.docs
          .map((e) => FavoruteModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      //store in local

      for (final favorite in data) {
        await HiveHelper.addFavorites(favorite: favorite);
      }
      return data;
    } catch (e) {
      log("favorite service error $e");
      return [];
    }
  }

  Future<bool> deleteFavorite({required FavoruteModel favorite}) async {
    try {
      final DocumentSnapshot documentSnapshot = await favoriteRef
          .doc(favorite.favoriteId)
          .get();

      if (documentSnapshot.exists) {
        await documentSnapshot.reference.delete();
        //delete from local
        await HiveHelper.deleteFavorite(key: favorite.productId);
        return true;
      }
    } catch (e) {
      log("favorite service error $e");
      return false;
    }
    return false;
  }
}
