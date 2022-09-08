import 'package:app/app/configs/env.dart';
import 'package:app/app/data/app_utils.dart';
import 'package:app/app/helpers/storage.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? query;

  ApiRequest({
    required this.url,
    this.query,
    this.data,
  });

  Dio _dio() {
    var token = getData('token');

    if (token == null) {
      token = "";
    }

    // Put your authorization token here
    return Dio(BaseOptions(headers: {
      'Authorization': 'Bearer ' + token,
    }));
  }

  void get({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    _dio().get(base_url + this.url, queryParameters: this.query).then((res) {
      if (onSuccess != null && res.data["status"] == true) {
        Print("GET DATA:", res.data);
        return onSuccess(res.data);
      } else {
        print(res.data['message']);
        if (onError != null) onError(res.data ?? {});
      }
    }).catchError((error) {
      print(error);

      if (onError != null) onError(error);
    });
  }

  void post({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    _dio()
        .post(base_url + this.url, queryParameters: this.query, data: this.data)
        .then((res) {
      if (onSuccess != null && res.data["status"] == true) {
        return onSuccess(res.data);
      } else {
        if (onError != null) onError(res.data ?? {});
      }
    }).catchError((error) {
      print(error);
      if (onError != null) onError(error);
    });
  }
}
