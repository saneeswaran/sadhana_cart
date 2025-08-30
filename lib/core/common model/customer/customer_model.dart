// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomerModel {
  final String? customerId;
  final String? name;
  final String? email;
  final int? contactNo;
  final String? profileImage;
  final String? referralCode;
  final String? referredBy;
  CustomerModel({
    this.customerId,
    this.name,
    this.email,
    this.contactNo,
    this.profileImage,
    this.referralCode,
    this.referredBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'name': name,
      'email': email,
      'contactNo': contactNo,
      'profileImage': profileImage,
      'referralCode': referralCode,
      'referredBy': referredBy,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      customerId: map['customerId'] != null
          ? map['customerId'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      contactNo: map['contactNo'] != null ? map['contactNo'] as int : null,
      profileImage: map['profileImage'] != null
          ? map['profileImage'] as String
          : null,
      referralCode: map['referralCode'] != null
          ? map['referralCode'] as String
          : null,
      referredBy: map['referredBy'] != null
          ? map['referredBy'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
