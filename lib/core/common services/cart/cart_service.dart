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

  static Future<bool> addToCart({
    required ProductModel product,
    required String size,
  }) async {
    try {
      final query = await cartRef
          .where("productId", isEqualTo: product.productId)
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
          productId: product.productId!,
          quantity: 1,
          size: size,
        );

        await cartRef.doc(docRef.id).set(cartModel.toMap());
        // await HiveHelper.addCart(cart: cartModel);
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

      // sync with Hive
      // for (final cart in data) {
      //   await HiveHelper.deleteCart(key: cart.cartId);
      // }
      // for (final cart in data) {
      //   await HiveHelper.addCart(cart: cart);
      // }

      return data;
    } catch (e) {
      log("cart service fetch error: $e");
      return {};
    }
  }

  static Future<bool> deleteCart({required CartModel cart}) async {
    try {
      final DocumentSnapshot documentSnapshot = await cartRef
          .doc(cart.cartId)
          .get();

      if (documentSnapshot.exists) {
        await documentSnapshot.reference.delete();
        // await HiveHelper.deleteCart(key: cart.cartId);

        // update state
        // ref.read(cartProvider.notifier).removeFromCart(cart: cart);

        return true;
      }
    } catch (e) {
      log("cart service delete error: $e");
      return false;
    }
    return false;
  }

  static Stream<List<ProductModel>> getCurrentUserCartProducts() async* {
    try {
      await for (final cartSnapshot in cartRef.snapshots()) {
        if (cartSnapshot.docs.isEmpty) {
          yield [];
          continue;
        }

        List<ProductModel> products = [];

        for (final doc in cartSnapshot.docs) {
          final cartItem = CartModel.fromMap(
            doc.data() as Map<String, dynamic>,
          );
          final productId = cartItem.productId;

          final productSnapshot = await productRef
              .where('productId', isEqualTo: productId)
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
