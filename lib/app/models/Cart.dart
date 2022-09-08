// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Map<String, Cart> cartFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Cart>(k, Cart.fromJson(v)));

String cartToJson(Map<String, Cart> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Cart {
  Cart({
    required this.quantity,
  });

  final int quantity;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
      };
}
