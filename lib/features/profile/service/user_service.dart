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
      final QuerySnapshot querySnapshot = await customerRef
          .where("id", isEqualTo: userUid)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
            .toList()
            .first;
        log(data.toString());
        return data;
      }
      return UserModel();
    } catch (e) {
      log(e.toString());
      return UserModel();
    }
  }

  static Future<void> createUserProfile({
    required String email,
    required String name,
    required int number,
  }) async {
    final docRef = customerRef.doc();
    final fcmToken = await FirebaseMessageHelper.createFcmToken();
    final String referralCode = name.substring(0, 6).toUpperCase();
    final UserModel userModel = UserModel(
      id: docRef.id,
      email: email,
      name: name,
      image: null,
      contactNo: number,
      fcmToken: fcmToken,
      referralCode: referralCode,
      referredBy: null,
    );
    await docRef.set(userModel.toMap());
  }
}
