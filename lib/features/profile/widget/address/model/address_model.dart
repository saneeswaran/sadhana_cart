import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 10)
class AddressModel {
  final String id;
  final String name;
  final String streetName;
  final String city;
  final String state;
  final int pinCode;
  final int phoneNumber;
  final Timestamp timestamp;
  final String title;
  final int icon;
  AddressModel({
    required this.id,
    required this.name,
    required this.streetName,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.phoneNumber,
    required this.timestamp,
    required this.title,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'streetName': streetName,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'phoneNumber': phoneNumber,
      'timestamp': timestamp,
      'title': title,
      'icon': icon,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      name: map['name'] as String,
      streetName: map['streetName'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      pinCode: map['pinCode'] as int,
      phoneNumber: map['phoneNumber'] as int,
      timestamp: map['timestamp'] as Timestamp,
      title: map['title'] as String,
      icon: map['icon'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(id: $id, name: $name, streetName: $streetName, city: $city, state: $state, pinCode: $pinCode, phoneNumber: $phoneNumber, timestamp: $timestamp, title: $title, icon: $icon)';
  }
}
