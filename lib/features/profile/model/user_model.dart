import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? id;
  final String? name;
  final String? image;
  final String? email;
  final String? fcmToken;
  final String? referralCode;
  final String? referredBy;
  UserModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.fcmToken,
    this.referralCode,
    this.referredBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'email': email,
      'fcmToken': fcmToken,
      'referralCode': referralCode,
      'referredBy': referredBy,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      referralCode: map['referralCode'] != null
          ? map['referralCode'] as String
          : null,
      referredBy: map['referredBy'] != null
          ? map['referredBy'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
