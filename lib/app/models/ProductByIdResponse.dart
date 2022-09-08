// To parse this JSON data, do
//
//     final ProductByIdResponse = ProductByIdResponseFromJson(jsonString);

import 'package:app/app/models/ProductList.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ProductByIdResponse ProductByIdResponseFromJson(String str) =>
    ProductByIdResponse.fromJson(json.decode(str));

class ProductByIdResponse {
  ProductByIdResponse({
    required this.status,
    required this.message,
    this.data,
  });

  final bool status;
  final String message;
  final Product? data;

  factory ProductByIdResponse.fromJson(Map<String, dynamic> json) =>
      ProductByIdResponse(
        status: json["status"],
        message: json["message"],
        data: Product.fromJson(json['data']),
      );
}
