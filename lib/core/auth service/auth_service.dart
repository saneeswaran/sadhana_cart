import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20services/customer/customer_service.dart';
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
    required String name,
    required int contact,
    required WidgetRef ref,
  }) async {
    ref.read(loadingProvider.notifier).state = true;

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await CustomerService.createUserProfile(
        name: name,
        email: email,
        contactNo: contact,
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
      ref.read(loadingProvider.notifier).state = true;

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fcmToken = await FirebaseMessageHelper.createFcmToken();

      if (fcmToken != null && credential.user != null) {
        await userRef.doc(credential.user!.uid).update({'fcmToken': fcmToken});
      }

      ref.read(loadingProvider.notifier).state = false;

      return credential.user;
    } on FirebaseAuthException catch (e) {
      ref.read(loadingProvider.notifier).state = false;

      log("FirebaseAuthException caught: ${e.code} - ${e.message}");

      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(
          code: 'wrong-password',
          message: 'Incorrect password provided.',
        );
      } else if (e.code == 'invalid-email') {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'The email address is not valid.',
        );
      } else {
        throw FirebaseAuthException(
          code: e.code,
          message: e.message ?? 'An error occurred while signing in.',
        );
      }
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;

      log("General exception caught: $e");

      throw Exception('An unexpected error occurred: ${e.toString()}');
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
