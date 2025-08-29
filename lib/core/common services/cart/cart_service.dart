import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class CartService {
  static const String cart = 'cart';
  static final CollectionReference cartRef = FirebaseFirestore.instance
      .collection(cart);
  static final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  //create
  static Future<bool> addToCart({required ProductModel product}) async {
    try {
      final docRef = cartRef.doc();
      final CartModel cartModel = CartModel(
        cartId: docRef.id,
        customerId: currentUserId,
        productId: product.productId,
      );
      await cartRef.doc(docRef.id).set(cartModel.toMap());
      //store in local
      await HiveHelper.addCart(cart: cartModel);
      return true;
    } catch (e) {
      log("cart service error $e");
      return false;
    }
  }

  //get
  static Future<Set<CartModel>> fetchCart() async {
    try {
      final QuerySnapshot querySnapshot = await cartRef.get();
      final data = querySnapshot.docs
          .map((e) => CartModel.fromMap(e.data() as Map<String, dynamic>))
          .toSet();
      //store in local
      for (final cart in data) {
        await HiveHelper.addCart(cart: cart);
      }
      return data;
    } catch (e) {
      log("cart service error $e");
      return {};
    }
  }

  //delete
  static Future<bool> deleteCart({required CartModel cart}) async {
    try {
      final DocumentSnapshot documentSnapshot = await cartRef
          .doc(cart.cartId)
          .get();
      if (documentSnapshot.exists) {
        await documentSnapshot.reference.delete();
        await HiveHelper.deleteCart(key: cart.productId);
        return true;
      }
    } catch (e) {
      log("cart service error $e");
      return false;
    }
    return false;
  }
}
