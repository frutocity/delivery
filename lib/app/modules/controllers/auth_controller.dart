import 'dart:convert';

import 'package:app/app/data/app_utils.dart';
import 'package:app/app/helpers/storage.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/post.dart';
import 'package:app/app/modules/providers/authProvider.dart';
import 'package:app/app/modules/providers/testProvider.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AuthController extends GetxController {
  bool isLoading = true;
  bool isVerified = false;
  bool isOtpSent = false;
  Map<String, dynamic> verifyOtpBody = {};
  List<BannerData> banners = <BannerData>[].obs;
  List<Product> exclusives = <Product>[].obs;
  List<Product> bestSellings = <Product>[].obs;
  List<Product> mostPopulars = <Product>[].obs;
  List<Product> productdetail = <Product>[].obs;
  IO.Socket? socket;

  @override
  void onInit() {
    super.onInit();
  }

  void sendOtp(body) {
    AuthProvider().sendOtp(
        body: body,
        onSuccess: (data) {
          print("Sending Otp");
          isOtpSent = true;
          isLoading = false;
          ToastService.show(data.message + data.data.otp);
          verifyOtpBody["phone"] = data.data.phone;
          verifyOtpBody["hash"] = data.data.hash;
          update();
        },
        onError: (error) {
          isLoading = false;
          isOtpSent = false;

          update();
        });
  }

  void verifyOtp(body) {
    // ToastService.show("data.message");
    body['device_token'] = "TEST:TOKEN";
    AuthProvider().verifyOtp(
        body: body,
        onSuccess: (data) {
          ToastService.show(data.message);
          isVerified = true;

          setData("user", data.data);
          socket?.emit('set-user', {"id":data.data.id});
          setData("token", data.data.token);
          print("verify data success");

          Get.offAllNamed(Routes.DASHBOARD);

          update();
        },
        onError: (error) {
          ToastService.show(error);
          isVerified = false;

          update();
        });
  }

  void bannerList() {
    banners = [];
    // ToastService.show("data.message");

    AuthProvider().getBannerList(onSuccess: (data) {
      // print(data.message);
      // print(jsonEncode(data.data));

      banners = (data.data ?? []);

      update();
    }, onError: (error) {
      ToastService.show("data.message ?? " "");
      ToastService.show(error['message']);
    });
    update();
  }

 void connectsocket() {
    socket = IO.io('https://socket.frutocity.com/', <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'foo': 'bar'}
    });
    socket?.connect();
      socket?.onConnect((_) {
    print('connect');
    socket?.emit('msg', 'from flutter');
  });
    // socket?.onconnect((d){
    //   // print( "socket onconnect" + d.toString());
    // });
    update();
  }

  void exclusiveOfferList() {
    // ToastService.show("data.message");

    AuthProvider().getExclusiveOfferList(onSuccess: (data) {
      print(data.message);
      print(jsonEncode(data.data));

      exclusives = (data.data ?? []);

      update();
    }, onError: (error) {
      ToastService.show("data.message ?? " "");
      // ToastService.show(error['message']);

      update();
    });
  }

  void bestSellingOfferList() {
    // ToastService.show("data.message");

    AuthProvider().getBestSellingList(onSuccess: (data) {
      print("best Selling products");
      print(data.message);
      print(jsonEncode(data.data));
      debugPrint(data.data.toString());

      bestSellings = (data.data ?? []);

      update();
    }, onError: (error) {
      ToastService.show("data.message ?? " "");
      // ToastService.show(error['message']);

      update();
    });
  }

  void mostPopularList() {
    // ToastService.show("data.message");

    AuthProvider().getMostPopularList(onSuccess: (data) {
      print(data.message);
      print(jsonEncode(data.data));

      mostPopulars = (data.data ?? []);

      update();
    }, onError: (error) {
      ToastService.show("data.message ?? " "");
      // ToastService.show(error['message']);

      update();
    });
  }

  void addToCart(id) {
    var cart = getData("cart");

    if (cart != null) {
      if (cart[id] != null) {
        cart = {
          ...cart,
          "$id": {"quantity": cart[id]["quantity"] + 1}
        };
      } else {
        cart = {
          ...cart,
          "$id": {"quantity": 1}
        };
      }
    } else {
      cart = {
        "$id": {"quantity": 1}
      };
    }

    setData("cart", cart);

    return cart;
  }

  void productDetail(String id) {
    // ToastService.show("data.message");

    AuthProvider().getproductDetail(
        onSuccess: (data) {
          print(data.message);
          print(jsonEncode(data.data));

          productdetail = (data.data ?? []);

          update();
        },
        onError: (error) {
          ToastService.show("${error} ?? " "");
          // ToastService.show(error['message']);

          update();
        },
        id: id);
  }
}
