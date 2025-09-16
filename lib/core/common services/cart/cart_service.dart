import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';

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
    String? size, {
    required ProductModel product,
  }) async {
    try {
      final query = await cartRef
          .where("productid", isEqualTo: product.productid)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        // update quantity if already exists
        final existing = CartModel.fromMap(
          query.docs.first.data() as Map<String, dynamic>,
        );

        final updated = existing.copyWith(quantity: existing.quantity + 1);

        await cartRef.doc(existing.cartId).update(updated.toMap());
        //  await HiveHelper.addCart(cart: updated);
      } else {
        // create new cart
        final docRef = cartRef.doc();
        final CartModel cartModel = CartModel(
          cartId: docRef.id,
          customerId: currentUserId,
          productid: product.productid!,
          quantity: 1,
          size: size,
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

  static Future<bool> deleteCart({required String cartId}) async {
    try {
      final DocumentSnapshot documentSnapshot = await cartRef.doc(cartId).get();
      log("Fetched cart document for id: $cartId");

      if (documentSnapshot.exists) {
        await documentSnapshot.reference.delete();
        log("Deleted cart document: $cartId");
        return true;
      } else {
        log("Cart document does not exist: $cartId");
      }
    } catch (e) {
      log("cart service delete error: $e");
      return false;
    }
    return false;
  }

  //here we used stream to get realtime update's because we are not using riverpod to fetch again and again
  //check which is have same products.. blaa.. blaa.. blaa... so we simple used stream to get realtime update
  //also we are comparing the details here because of while fetching we are getting only product model instead of cart model
  //but we are stored the size's into cart model so we are comparing the product id then displaying what are the size's customer added to database
  static Stream<List<ProductModel>> getCurrentUserCartProducts() async* {
    try {
      await for (final cartSnapshot in cartRef.snapshots()) {
        if (cartSnapshot.docs.isEmpty) {
          yield [];
          continue;
        }

        final seenProductKeys = <String>{};
        List<ProductModel> products = [];

        for (final doc in cartSnapshot.docs) {
          final cartItem = CartModel.fromMap(
            doc.data() as Map<String, dynamic>,
          );
          final productid = cartItem.productid;
          final sizeKey = cartItem.size ?? '';

          final uniqueKey = "$productid|$sizeKey";

          if (seenProductKeys.contains(uniqueKey)) {
            continue; // skip duplicate
          }
          seenProductKeys.add(uniqueKey);

          final productSnapshot = await productRef
              .where('productid', isEqualTo: productid)
              .get();

          if (productSnapshot.docs.isNotEmpty) {
            final productData = productSnapshot.docs.map((e) {
              return ProductModel.fromMap(e.data() as Map<String, dynamic>);
            }).toList();

            products.addAll(productData);
          }
        }

        yield products;
      }
    } catch (e) {
      log("cart service fetch error stream: $e");
      yield [];
    }
  }
}
