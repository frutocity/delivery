// To parse this JSON data, do
//
//     final NewOrderReponse = NewOrderReponseFromJson(jsonString);

import 'package:app/app/models/ProductList.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

NewOrderReponse NewOrderReponseFromJson(String str) =>
    NewOrderReponse.fromJson(json.decode(str));

class NewOrderReponse {
  NewOrderReponse({
    required this.order,
  });

  final Order order;

  factory NewOrderReponse.fromJson(Map<String, dynamic> json) =>
      NewOrderReponse(
        order: json["order"],
      );
}

class Order {
  Order({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}

class Data {
  String user;
  int number;
  List<dynamic> items;
  String status;
  String address;
  String id;
  String createdAt;
  String updatedAt;
  int v;

  Data({
    required this.user,
    required this.number,
    required this.items,
    required this.status,
    required this.address,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"],
        number: json["number"],
        items: json["items"],
        status: json["status"],
        address: json["address"],
        id: json["_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["_v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "number": number,
        "items": items,
        "status": status,
        "address": address,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "_v": v,
      };
}
