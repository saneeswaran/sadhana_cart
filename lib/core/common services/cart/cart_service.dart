import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_with_product.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';

class CartService {
  static const String user = 'users';
  static const String cart = 'cart';
  static final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  static final CollectionReference cartRef = FirebaseFirestore.instance
      .collection(user)
      .doc(currentUserId)
      .collection(cart);
  static final CollectionReference productRef = FirebaseFirestore.instance
      .collection("products");

  static Future<bool> addToCart(
    SizeVariant? sizeVariant, {
    required ProductModel product,
  }) async {
    try {
      Query query = cartRef.where("productid", isEqualTo: product.productid);

      if (sizeVariant!.size.trim().isNotEmpty) {
        query = query.where("size", isEqualTo: sizeVariant.size);
      }

      final querySnapshot = await query.limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final existing = CartModel.fromMap(
          querySnapshot.docs.first.data() as Map<String, dynamic>,
        );

        final updated = existing.copyWith(quantity: existing.quantity + 1);

        await cartRef.doc(existing.cartId).update(updated.toMap());
      } else {
        final docRef = cartRef.doc();

        final CartModel cartModel = CartModel(
          cartId: docRef.id,
          customerId: currentUserId,
          productid: product.productid!,
          quantity: 1,
          sizeVariant: sizeVariant,
        );

        await cartRef.doc(docRef.id).set(cartModel.toMap());
      }

      return true;
    } catch (e) {
      log("cart service add error: $e");
      return false;
    }
  }

  static Future<Set<CartModel>> fetchCart() async {
    try {
      final QuerySnapshot querySnapshot = await cartRef.get();

      final data = querySnapshot.docs
          .map((e) => CartModel.fromMap(e.data() as Map<String, dynamic>))
          .toSet();
      return data;
    } catch (e) {
      log("cart service fetch error: $e");
      return {};
    }
  }

  static Future<List<CartWithProduct>> fetchCartItemsWithProducts() async {
    List<CartWithProduct> items = [];
    try {
      final cartSnapshot = await cartRef.get();
      log(
        "fetchCartItemsWithProducts: cart documents count = ${cartSnapshot.docs.length}",
      );
      if (cartSnapshot.docs.isEmpty) return [];
      for (final cartDoc in cartSnapshot.docs) {
        final map = cartDoc.data() as Map<String, dynamic>;
        final cartItem = CartModel.fromMap(map);
        final prodId = cartItem.productid;
        if (prodId.trim().isEmpty) {
          log(
            "Skipping cartItem with empty productid. cartId: ${cartItem.cartId}",
          );
          continue;
        }
        final prodQuery = await productRef
            .where('productid', isEqualTo: prodId)
            .limit(1)
            .get();
        log("product query for id $prodId returned ${prodQuery.docs.length}");
        if (prodQuery.docs.isNotEmpty) {
          final prodMap = prodQuery.docs.first.data() as Map<String, dynamic>;
          final productModel = ProductModel.fromMap(prodMap);
          items.add(CartWithProduct(cart: cartItem, product: productModel));
        } else {
          log("No product document found for productid $prodId");
        }
      }
    } catch (e) {
      log("Error in fetchCartItemsWithProducts: $e");
    }
    return items;
  }

  static Future<bool> deleteCart({required String cartId}) async {
    try {
      if (cartId.trim().isEmpty) {
        log("deleteCart failed: cartId is empty");
        return false;
      }

      final DocumentSnapshot documentSnapshot = await cartRef.doc(cartId).get();

      if (documentSnapshot.exists) {
        await documentSnapshot.reference.delete();
        log("Cart deleted successfully: $cartId");
        return true;
      } else {
        log("Cart not found: $cartId");
      }
    } catch (e) {
      log("cart service delete error: $e");
    }

    return false;
  }

  static Future<bool> removeAllPaidCartItems({
    required List<CartModel> cart,
  }) async {
    for (final prod in cart) {
      final productId = prod.cartId;

      final DocumentSnapshot documentSnapshot = await cartRef
          .doc(productId)
          .get();

      if (documentSnapshot.exists) {
        await documentSnapshot.reference.delete();
        log("product deleted successfully: $productId");
        return true;
      } else {
        log("product not found: $productId");
        return false;
      }
    }
    return false;
  }
}
