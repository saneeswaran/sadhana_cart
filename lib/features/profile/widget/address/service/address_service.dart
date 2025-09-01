import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';

class AddressService {
  static const String addressCollection = "address";
  static const String userCollection = "users";
  static final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  static final CollectionReference addressRef = FirebaseFirestore.instance
      .collection(userCollection)
      .doc(currentUserId)
      .collection(addressCollection);

  static Future<bool> addAddress({
    required String name,
    required String streetName,
    required String city,
    required String state,
    required String title,
    required int pinCode,
    required int phoneNumber,
    required IconData icon,
  }) async {
    try {
      final docRef = addressRef.doc();
      final iconCode = icon.codePoint;
      final AddressModel addressModel = AddressModel(
        title: title,
        icon: iconCode,
        id: docRef.id,
        name: name,
        streetName: streetName,
        city: city,
        state: state,
        pinCode: pinCode,
        phoneNumber: phoneNumber,
        timestamp: Timestamp.now(),
      );
      await docRef.set(addressModel.toMap());
      return true;
    } catch (e) {
      log("address service error $e");
      return false;
    }
  }

  static Future<List<AddressModel>> fetchAllAddress() async {
    try {
      final QuerySnapshot querySnapshot = await addressRef
          .doc(currentUserId)
          .collection(addressCollection)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => AddressModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        for (final address in data) {
          await HiveHelper.addAddress(address: address);
        }
        return data;
      }
    } catch (e) {
      log("address service error $e");
    }
    return [];
  }

  static Future<bool> deleteAddress({required String id}) async {
    try {
      final DocumentSnapshot documentSnapshot = await addressRef.doc(id).get();

      if (documentSnapshot.exists) {
        await documentSnapshot.reference.delete();
        return true;
      }
    } catch (e) {
      log("address service error $e");
      return false;
    }
    return false;
  }
}
