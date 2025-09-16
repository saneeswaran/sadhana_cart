import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/core/common%20model/chat/chat_model.dart';

class ChatService {
  static final chatsRef = FirebaseFirestore.instance.collection('chats');

  // Get existing chat or create a new one
  static Future<String> getOrCreateChatForUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Check if a chat already exists
    final query = await chatsRef
        .where('members', arrayContains: user.uid)
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.id; // return existing chatId
    }

    // If first time, create a new chat
    final docRef = await chatsRef.add({
      'members': [user.uid, 'support'],
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  // Send a message
  static Future<void> sendMessage(
    String chatId,
    String userId,
    String text,
  ) async {
    final message = {
      'text': text,
      'senderId': userId,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    };
    await chatsRef.doc(chatId).collection('messages').add(message);
  }

  // Stream messages
  static Stream<List<Message>> getMessages(String chatId) {
    return chatsRef
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }
}
