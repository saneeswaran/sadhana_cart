import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressService {
  static const String addressCollection = "address";
  static const String userCollection = "users";
  static final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  static final CollectionReference addressRef = FirebaseFirestore.instance
      .collection(userCollection)
      .doc(currentUserId)
      .collection(addressCollection);
}
