import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/chat/chat_model.dart';
import 'package:sadhana_cart/core/common%20services/chat_support/chat_service.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, List<Message>>(
  (ref) => ChatNotifier(ref),
);

class ChatNotifier extends StateNotifier<List<Message>> {
  final Ref ref;
  ChatNotifier(this.ref) : super([]);

  Stream<List<Message>> listenMessages(String chatId) {
    final stream = ChatService.getMessages(chatId);
    stream.listen((messages) {
      state = messages; // update state whenever Firestore changes
    });
    return stream;
  }

  Future<void> sendMessage(String chatId, String userId, String text) async {
    final message = Message(
      text: text,
      senderId: userId,
      timestamp: DateTime.now(),
    );

    // Optimistically update UI
    state = [...state, message];

    try {
      await ChatService.sendMessage(chatId, userId, text);
    } catch (e) {
      state = state.where((m) => m != message).toList(); // remove if failed
      rethrow;
    }
  }
}
