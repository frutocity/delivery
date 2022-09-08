// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryListResponse categoryListResponseFromJson(String str) =>
    CategoryListResponse.fromJson(json.decode(str));

String categoryListResponseToJson(CategoryListResponse data) =>
    json.encode(data.toJson());

class CategoryListResponse {
  CategoryListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<CategoryData>? data;

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      CategoryListResponse(
        status: json["status"],
        message: json["message"],
        data: List<CategoryData>.from(
            json["data"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
      };
}

class CategoryData {
  CategoryData({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? photo;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
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
