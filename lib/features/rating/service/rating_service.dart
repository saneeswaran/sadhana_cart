import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/core/helper/avoid_null_values.dart';
import 'package:sadhana_cart/features/rating/model/rating_model.dart';

class RatingService {
  static const String rating = "rating";
  static final CollectionReference ratingRef = FirebaseFirestore.instance
      .collection(rating);

  static final currentUser = FirebaseAuth.instance.currentUser!.uid;

  static Future<bool> addRating({
    required String userName,
    required String productId,
    required double rating,
    required String comment,
  }) async {
    try {
      final docRef = ratingRef.doc();

      final RatingModel ratingModel = RatingModel(
        ratingId: docRef.id,
        userId: currentUser,
        userName: userName,
        productId: productId,
        rating: rating,
        comment: comment,
        createdAt: Timestamp.now(),
      );

      await docRef.set(ratingModel.toMap());
      return true;
    } catch (e) {
      log("rating service error $e");
      return false;
    }
  }

  static Future<List<RatingModel>> fetchRating({
    required String productId,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await ratingRef
          .where("productId", isEqualTo: productId)
          .get();
      return querySnapshot.docs
          .map((e) => RatingModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("rating service error $e");
      return [];
    }
  }

  static Future<bool> deleteUserOwnRating({required String productId}) async {
    try {
      final QuerySnapshot querySnapshot = await ratingRef
          .where("productId", isEqualTo: productId)
          .where("userId", isEqualTo: currentUser)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        return true;
      }
      return false;
    } catch (e) {
      log("rating service error $e");
      return false;
    }
  }

  static Future<bool> updateOwnRating({
    required String productId,
    required String userName,
    required double rating,
    required String comment,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await ratingRef
          .where("productId", isEqualTo: productId)
          .where("userId", isEqualTo: currentUser)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final RatingModel ratingModel = RatingModel(
          ratingId: querySnapshot.docs.first.id,
          userId: currentUser,
          userName: userName,
          productId: productId,
          rating: rating,
          comment: comment,
          createdAt: Timestamp.now(),
        );

        final Map<String, dynamic> newdata =
            AvoidNullValues.removeNullValuesDeep(ratingModel.toMap());

        await querySnapshot.docs.first.reference.update(newdata);
        return true;
      }
      return false;
    } catch (e) {
      log("rating service error $e");
      return false;
    }
  }
}
