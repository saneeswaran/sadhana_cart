import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/firebase_message_helper.dart';
import 'package:sadhana_cart/features/profile/model/user_model.dart';

class UserService {
  static final String userCollection = "users";
  static final String? userUid = FirebaseAuth.instance.currentUser?.uid;
  static final CollectionReference customerRef = FirebaseFirestore.instance
      .collection(userCollection);

  static Future<UserModel> getCurrentUserProfile({required Ref ref}) async {
    try {
      ref.read(loadingProvider.notifier).state = true;
      final QuerySnapshot querySnapshot = await customerRef
          .where("id", isEqualTo: userUid)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
            .toList()
            .first;
        log(data.toString());
        ref.read(loadingProvider.notifier).state = false;
        return data;
      }
      return UserModel();
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      log(e.toString());
      return UserModel();
    }
  }

  static Future<bool> createUserProfile({
    required String email,
    required String name,
    required int number,
  }) async {
    final fcmToken = await FirebaseMessageHelper.createFcmToken();
    final String referralCode =
        "${name.substring(0, 3).toUpperCase()} ${number.toString().substring(0, 4)}";
    final UserModel userModel = UserModel(
      id: userUid,
      email: email,
      name: name,
      image: null,
      contactNo: number,
      fcmToken: fcmToken,
      referralCode: referralCode,
      referredBy: null,
    );
    await customerRef.doc(userUid).set(userModel.toMap());
    return true;
  }
}
