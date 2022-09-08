// To parse this JSON data, do
//
//     final categoryDataReponse = categoryDataReponseFromJson(jsonString);

import 'package:app/app/models/ProductList.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

CategoryDataReponse categoryDataReponseFromJson(String str) =>
    CategoryDataReponse.fromJson(json.decode(str));

class CategoryDataReponse {
  CategoryDataReponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Category? data;

  factory CategoryDataReponse.fromJson(Map<String, dynamic> json) =>
      CategoryDataReponse(
        status: json["status"],
        message: json["message"],
        data: Category.fromJson(json["data"]),
      );
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.products,
  });

  final String id;
  final String name;
  final String description;
  final String photo;
  final bool active;
  final String createdAt;
  final String updatedAt;
  final int v;
  final List<Product> products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
        active: json["active"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photo": photo,
        "active": active,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
