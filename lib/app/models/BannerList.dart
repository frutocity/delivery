// To parse this JSON data, do
//
//     final bannerListReponse = bannerListReponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BannerListReponse bannerListReponseFromJson(String str) =>
    BannerListReponse.fromJson(json.decode(str));

class BannerListReponse {
  BannerListReponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String? message;
  final List<BannerData>? data;

  factory BannerListReponse.fromJson(Map<String, dynamic> json) =>
      BannerListReponse(
        status: json["status"],
        message: json["message"],
        data: List<BannerData>.from(
            json["data"].map((x) => BannerData.fromJson(x))),
      );
}

class BannerData {
  BannerData({
    required this.id,
    required this.image,
    required this.active,
    required this.type,
    required this.value,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? image;
  final bool? active;
  final String? type;
  final String? value;
  final String? link;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["_id"],
        image: json["image"],
        active: json["active"],
        type: json["type"],
        value: json["value"],
        link: json["link"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "active": active,
        "type": type,
        "value": value,
        "link": link,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
