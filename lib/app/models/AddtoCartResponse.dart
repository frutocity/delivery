// To parse this JSON data, do
//
//     final AddtoCartResponse = AddtoCartResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddtoCartResponse AddtoCartResponseFromJson(String str) =>
    AddtoCartResponse.fromJson(json.decode(str));

String AddtoCartResponseToJson(AddtoCartResponse data) =>
    json.encode(data.toJson());

class AddtoCartResponse {
  AddtoCartResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data? data;

  factory AddtoCartResponse.fromJson(Map<String, dynamic> json) =>
      AddtoCartResponse(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
