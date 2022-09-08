// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.status,
    required this.message,
    this.data,
  });

  bool status;
  String message;
  Data? data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.phone,
    this.address,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.email,
    this.name,
  });

  String? id;
  int? phone;
  List<dynamic>? address;
  String? deviceToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? email;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        phone: json["phone"],
        address: List<dynamic>.from(json["address"].map((x) => x)),
        deviceToken: json["device_token"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "address": List<dynamic>.from(address!.map((x) => x)),
        "device_token": deviceToken,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "email": email,
        "name": name,
      };
}
