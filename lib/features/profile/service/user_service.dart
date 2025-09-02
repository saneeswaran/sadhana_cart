import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/core/common%20model/customer/customer_model.dart';
import 'package:sadhana_cart/core/helper/firebase_message_helper.dart';

class UserService {
  static final String userCollection = "users";
  static final String? userUid = FirebaseAuth.instance.currentUser?.uid;
  static final CollectionReference customerRef = FirebaseFirestore.instance
      .collection(userCollection);

  static Future<CustomerModel?> getCurrentUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final querySnapshot = await customerRef
          .where("id", isEqualTo: userUid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        return CustomerModel.fromMap(data);
      }

      return null;
    } catch (e) {
      log('Error fetching user profile: $e');
      return null;
    } finally {}
  }

  static Future<bool> createUserProfile({
    required String email,
    required String name,
    required int number,
  }) async {
    final fcmToken = await FirebaseMessageHelper.createFcmToken();
    final safeName = name.padRight(6, 'X').substring(0, 6).toUpperCase();
    final numberStr = number.toString().padLeft(4, '0').substring(0, 4);
    final String referralCode = "$safeName$numberStr";
    final CustomerModel userModel = CustomerModel(
      customerId: userUid,
      email: email,
      name: name,
      profileImage: null,
      contactNo: number,
      fcmToken: fcmToken,
      referralCode: referralCode,
      referredBy: null,
    );
    await customerRef.doc(userUid).set(userModel.toMap());
    return true;
  }
}
