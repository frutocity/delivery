// To parse this JSON data, do
//
//     final addressList = addressListFromJson(jsonString);

import 'dart:convert';

AddressList addressListFromJson(String str) =>
    AddressList.fromJson(json.decode(str));

String addressListToJson(AddressList data) => json.encode(data.toJson());

class AddressList {
  AddressList({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum>? data;

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.user,
    this.type,
    this.address,
    this.apartment,
    this.howToReach,
    this.city,
    this.state,
    this.pinCode,
    this.primary,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? user;
  String? type;
  String? address;
  String? apartment;
  String? howToReach;
  String? city;
  String? state;
  int? pinCode;
  bool? primary;
  String? createdAt;
  String? updatedAt;
  int? v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
        type: json["type"] == null ? null : json["type"],
        address: json["address"] == null ? null : json["address"],
        apartment: json["apartment"] == null ? null : json["apartment"],
        howToReach: json["how_to_reach"] == null ? null : json["how_to_reach"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        pinCode: json["pin_code"] == null ? null : json["pin_code"],
        primary: json["primary"] == null ? null : json["primary"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user,
        "type": type == null ? null : type,
        "address": address == null ? null : address,
        "apartment": apartment == null ? null : apartment,
        "how_to_reach": howToReach == null ? null : howToReach,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "pin_code": pinCode == null ? null : pinCode,
        "primary": primary == null ? null : primary,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
      };
}
