import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final String senderId;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.text,
    required this.senderId,
    required this.timestamp,
    this.isRead = false,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'text': text,
    'senderId': senderId,
    'timestamp': timestamp,
    'isRead': isRead,
  };
}
