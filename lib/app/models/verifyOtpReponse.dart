// To parse this JSON data, do
//
//     final verifyOtpReponse = verifyOtpReponseFromJson(jsonString);

import 'dart:convert';

VerifyOtpReponse verifyOtpReponseFromJson(String str) =>
    VerifyOtpReponse.fromJson(json.decode(str));

String verifyOtpReponseToJson(VerifyOtpReponse data) =>
    json.encode(data.toJson());

class VerifyOtpReponse {
  VerifyOtpReponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory VerifyOtpReponse.fromJson(Map<String, dynamic> json) =>
      VerifyOtpReponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.phone,
    required this.name,
    required this.store,
    required this.role,
    required this.joining,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.token,
  });

  String id;
  String phone;
  String name;
  String store;
  String role;
  DateTime joining;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["_id"],
      phone: json["phone"],
      name: json["name"],
      store: json["store"],
      role: json["role"],
      joining: DateTime.parse(json["joining"]),
      active: json["active"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
      token: json["token"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "name": name,
        "store": store,
        "role": role,
        "joining": joining.toIso8601String(),
        "active": active,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "token": token,
      };
}
