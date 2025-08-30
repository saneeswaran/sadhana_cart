import 'dart:convert';

class CustomerModel {
  final String customerId;
  final String name;
  final String email;
  final int contectNo;
  final String? referralCode;
  final String? referredBy;
  CustomerModel({
    required this.customerId,
    required this.name,
    required this.email,
    required this.contectNo,
    this.referralCode,
    this.referredBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'name': name,
      'email': email,
      'contectNo': contectNo,
      'referralCode': referralCode,
      'referredBy': referredBy,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      customerId: map['customerId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      contectNo: map['contectNo'] as int,
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
