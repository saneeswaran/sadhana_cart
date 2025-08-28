import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //current user id
  static String? get currentUser => _auth.currentUser?.uid;

  // Method to create an account
  static Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.sendEmailVerification();
    } catch (e) {
      throw FirebaseAuthException(
        code: 'create-account-failed',
        message: e.toString(),
      );
    }
  }

  //sign in with email and password
  static Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
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
