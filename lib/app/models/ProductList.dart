// To parse this JSON data, do
//
//     final ProductList = ProductListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductList ProductListFromJson(String str) =>
    ProductList.fromJson(json.decode(str));

String ProductListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  ProductList({
    required this.status,
    required this.message,
    this.data,
  });

  final bool status;
  final String message;
  final List<Product>? data;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        status: json["status"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
      };
}

class Product {
  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.photo,
      required this.price,
      required this.unit,
      required this.unitValue,
      required this.weight,
      required this.category,
      required this.quantity,
      required this.details,
      required this.discount,
      required this.store,
      required this.active,
      this.meta,
      required this.createdAt,
      required this.updatedAt,
      required this.v,
      this.options});

  final String id;
  final String name;
  final String description;
  final List<String> photo;
  final int price;
  final Unit unit;
  final int unitValue;
  final String weight;
  final Category category;
  final int quantity;
  final List<Detail> details;
  final int discount;
  final Store store;
  final bool active;
  final dynamic meta;
  final String createdAt;
  final String updatedAt;
  final int v;
  final List<Options>? options;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: List<String>.from(json["photo"].map((x) => x)),
        price: json["price"],
        unit: Unit.fromJson(json["unit"]),
        unitValue: json["unit_value"],
        weight: json["weight"],
        category: Category.fromJson(json["category"]),
        quantity: json["quantity"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        discount: json["discount"],
        store: Store.fromJson(json["store"]),
        active: json["active"],
        meta: json["meta"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        options:
            List<Options>.from(json["options"].map((x) => Options.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photo": List<dynamic>.from(photo.map((x) => x)),
        "price": price,
        "unit": unit.toJson(),
        "unit_value": unitValue,
        "weight": weight,
        "category": category.toJson(),
        "quantity": quantity,
        // "details": List<dynamic>.from((details ?? []).map((x) => x.toJson())),
        "discount": discount,
        "store": store.toJson(),
        "active": active,
        "meta": meta,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "options": options
      };
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
  });

  final String id;
  final String name;
  final String description;
  final String photo;
  final bool active;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
        active: json["active"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
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
      };
}

class Detail {
  Detail({
    required this.title,
    required this.description,
  });

  final String? title;
  final String? description;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class Options {
  Options({
    required this.title,
    required this.price,
  });

  final String? title;
  final String? price;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        title: json["title"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
      };
}

class Store {
  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.apartment,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.employeeCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String address;
  final String apartment;
  final String city;
  final String state;
  final int pinCode;
  final int employeeCount;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        apartment: json["apartment"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pin_code"],
        employeeCount: json["employee_count"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address,
        "apartment": apartment,
        "city": city,
        "state": state,
        "pin_code": pinCode,
        "employee_count": employeeCount,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class Unit {
  Unit({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["_id"],
        name: json["name"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
