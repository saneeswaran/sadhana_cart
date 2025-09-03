import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/enums/card_enums.dart';

final loadingProvider = StateProvider.autoDispose<bool>((ref) => false);

final productDataProvider = FutureProvider.family
    .autoDispose<ProductModel, String>((ref, id) async {
      ref.read(loadingProvider.notifier).state = true;
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("id", isEqualTo: id)
          .get();
      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList()
          .first;
      ref.read(loadingProvider.notifier).state = false;
      return data;
    });
final genderProvider = StateProvider.autoDispose<String?>((ref) => null);

final profileImageProvider = StateProvider.autoDispose<File?>((ref) => null);

final passEyeProvider = StateProvider.autoDispose<bool>((ref) => false);
final confirmPassEyeProvider = StateProvider.autoDispose<bool>((ref) => false);

final userAdderssIconProvider = StateProvider.autoDispose<IconData>(
  (ref) => Icons.home,
);
final userAddressTitleProvider = StateProvider.autoDispose<String>(
  (ref) => "Home",
);

final addressDeleteLoader = StateProvider.autoDispose<bool>((ref) => false);

final showNotificationProvider = StateProvider<bool>((ref) => false);

final showLockedScreennotificationProvider = StateProvider<bool>(
  (ref) => false,
);

final addressRadioButtonProvider = StateProvider<int>((ref) => 0);

final addressFillingProvider = StateProvider<bool>((ref) => false);

//credit card

final creditCardTypeProvider = StateProvider<CardType>((ref) {
  final link = ref.keepAlive();
  Future.delayed(const Duration(minutes: 3), () => link.close());
  return CardType.mastercard;
});

final creditCardImageProvider = StateProvider<CardEnums>((ref) {
  final link = ref.keepAlive();
  Future.delayed(const Duration(minutes: 3), () => link.close());
  return CardEnums.masterCard;
});
