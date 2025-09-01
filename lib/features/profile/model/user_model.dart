// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 9)
class UserModel extends HiveObject {
  final String? id;
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? image;
  @HiveField(2)
  final String? email;
  final String? gender;
  final int? contactNo;
  final String? fcmToken;
  final String? referralCode;
  final String? referredBy;
  UserModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.gender,
    this.contactNo,
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
      'gender': gender,
      'contactNo': contactNo,
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
      gender: map['gender'] != null ? map['gender'] as String : null,
      contactNo: map['contactNo'] != null ? map['contactNo'] as int : null,
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

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, image: $image, email: $email, gender: $gender, contactNo: $contactNo, fcmToken: $fcmToken, referralCode: $referralCode, referredBy: $referredBy)';
  }
}
