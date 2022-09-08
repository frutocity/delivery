// To parse this JSON data, do
//
//     final sendOtpResponse = sendOtpResponseFromJson(jsonString);

import 'dart:convert';

sendOtpResponse sendOtpResponseFromJson(String str) =>
    sendOtpResponse.fromJson(json.decode(str));

String sendOtpResponseToJson(sendOtpResponse data) =>
    json.encode(data.toJson());

class sendOtpResponse {
  bool status;
  String message;
  Data data;
  sendOtpResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory sendOtpResponse.fromJson(Map<String, dynamic> json) =>
      sendOtpResponse(
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
    required this.phone,
    required this.hash,
    required this.otp,
  });

  String phone;
  String hash;
  String otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json["phone"],
        hash: json["hash"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "hash": hash,
        "otp": otp,
      };
}
