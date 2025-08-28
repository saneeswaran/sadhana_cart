import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/core/helper/firebase_message_helper.dart';
import 'package:sadhana_cart/features/profile/model/user_model.dart';

class UserService {
  static final String userCollection = "users";
  static final String? userUid = FirebaseAuth.instance.currentUser?.uid;
  static final CollectionReference customerRef = FirebaseFirestore.instance
      .collection(userCollection);

  static Future<UserModel> getCurrentUserProfile() async {
    try {
      final DocumentSnapshot documentSnapshot = await customerRef
          .doc(userUid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>,
        );
      } else {
        return UserModel();
      }
    } catch (e) {
      log(e.toString());
      return UserModel();
    }
  }

  static Future<void> createUserProfile({
    required String email,
    required String name,
  }) async {
    final docRef = customerRef.doc();
    final fcmToken = await FirebaseMessageHelper.createFcmToken();
    final String referralCode = name.substring(0, 6).toUpperCase();
    final UserModel userModel = UserModel(
      id: docRef.id,
      email: email,
      name: name,
      image: null,
      fcmToken: fcmToken,
      referralCode: referralCode,
      referredBy: null,
    );
    await docRef.set(userModel.toMap());
  }
}
