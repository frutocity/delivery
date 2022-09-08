// To parse this JSON data, do
//
//     final addAddressResponse = addAddressResponseFromJson(jsonString);

import 'dart:convert';

addAddressResponse addAddressResponseFromJson(String str) =>
    addAddressResponse.fromJson(json.decode(str));

String addAddressResponseToJson(addAddressResponse data) =>
    json.encode(data.toJson());

class addAddressResponse {
  bool status;
  String message;
  Data data;
  addAddressResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory addAddressResponse.fromJson(Map<String, dynamic> json) =>
      addAddressResponse(
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
    this.type,
    this.address,
    this.apartment,
    this.how_to_reach,
    this.city,
    this.state,
    this.pin_code,
    this.geo_location,
  });

  String? type;
  String? address;
  String? apartment;
  String? how_to_reach;
  String? city;
  String? state;
  int? pin_code;
  dynamic? geo_location;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        address: json["address"],
        apartment: json["apartment"],
        how_to_reach: json["how_to_reach"],
        city: json["city"],
        state: json["state"],
        pin_code: json["pin_code"],
        geo_location: json["geo_location"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "address": address,
        "apartment": apartment,
        "how_to_reach": how_to_reach,
        "city": city,
        "state": state,
        "pin_code": pin_code,
        "geo_location": geo_location,
      };
}
