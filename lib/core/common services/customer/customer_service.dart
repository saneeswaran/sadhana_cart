import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/customer/customer_model.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/features/profile/model/user_model.dart';

class CustomerService {
  static const String customer = 'customer';
  static final CollectionReference customerRef = FirebaseFirestore.instance
      .collection(customer);
  static final String customerId = FirebaseAuth.instance.currentUser!.uid;

  Future<UserModel?> fetCurrentUserDetails({required Ref ref}) async {
    try {
      ref.read(loadingProvider.notifier).state = true;
      final DocumentSnapshot documentSnapshot = await customerRef
          .doc(customerId)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>,
        );
      } else {
        log("customer service error");
      }
    } catch (e) {
      log("customer service error $e");
      return null;
    }
    return null;
  }

  Future<bool> createUserProfile({
    required String name,
    email,
    required int contactNo,
  }) async {
    try {
      final String referralCode = name.substring(1, 6).toUpperCase();
      final CustomerModel customerModel = CustomerModel(
        customerId: customerId,
        name: name,
        email: email,
        contectNo: contactNo,
        referralCode: referralCode,
        referredBy: null,
      );
      await customerRef.doc(customerId).set(customerModel.toMap());
      return true;
    } catch (e) {
      log("customer service error $e");
      return false;
    }
  }

  Future<bool> referCustomer({required String referralCode}) async {
    try {
      final QuerySnapshot querySnapshot = await customerRef
          .where('referralCode', isEqualTo: referralCode)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot documentSnapshot = await customerRef
            .doc(customerId)
            .get();
        if (documentSnapshot.exists) {
          await documentSnapshot.reference.update({"referredBy": referralCode});
          return true;
        } else {
          log("failed to refer");
          return false;
        }
      }
    } catch (e) {
      log("customer profile service $e");
      return false;
    }
    return false;
  }
}
