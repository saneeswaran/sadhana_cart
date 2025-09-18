import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/firebase_message_helper.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //current user id
  static String? get currentUser => _auth.currentUser?.uid;

  static final CollectionReference userRef = FirebaseFirestore.instance
      .collection("users");

  // Method to create an account
  static Future<bool> createAccount({
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    ref.read(loadingProvider.notifier).state = true;

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.sendEmailVerification();

      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      throw Exception('Account creation failed: ${e.toString()}');
    } finally {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  //sign in with email and password
  static Future<User?> signIn({
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    try {
      //update fcm token
      final token = await FirebaseMessageHelper.createFcmToken();
      final userDoc = await userRef.doc(currentUser).get();
      if (userDoc.exists) {
        await userRef.doc(currentUser).update({"fcmToken": token});
        final credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        ref.read(loadingProvider.notifier).state = false;
        return credential.user;
      } else {
        log("User document not found");
      }
      return null;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'sign-in-failed',
        message: e.toString(),
      );
    }
  }

  //sign out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // reset password
  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw FirebaseAuthException(
        code: 'password-reset-failed',
        message: e.toString(),
      );
    }
  }
}
