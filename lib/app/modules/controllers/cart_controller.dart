import 'dart:convert';

import 'package:app/app/data/app_utils.dart';
import 'package:app/app/helpers/storage.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/post.dart';
import 'package:app/app/modules/providers/CartProvider.dart';
import 'package:app/app/modules/providers/authProvider.dart';
import 'package:app/app/modules/providers/testProvider.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<Product> items = <Product>[].obs;
  bool test = false;

  @override
  void onInit() {
    super.onInit();
    // cartList();
  }

  void addToCart(id) {
    var cart = getData("cart");

    if (cart != null) {
      if (cart[id] != null) {
        cart = {
          ...cart,
          "$id".toString(): {"quantity": cart[id]["quantity"] + 1}
        };
      } else {
        cart = {
          ...cart,
          "$id".toString(): {"quantity": 1}
        };
      }
    } else {
      cart = {
        "$id".toString(): {"quantity": 1}
      };
    }

    setData("cart", cart);
    update();

    this.sendCart(Map<String, dynamic>.from(cart));
    return cart;
  }

  void removeFromCart(id) {
    var cart = getData("cart");

    if (cart != null) {
      if (cart[id] != null) {
        if (cart[id]["quantity"] > 1) {
          cart = {
            ...cart,
            "$id".toString(): {"quantity": cart[id]["quantity"] - 1}
          };
        } else {
          cart.removeWhere((key, value) => key == "$id".toString());
        }

        setData("cart", cart);
        update();

        this.sendCart(Map<String, dynamic>.from(cart));
        return cart;
      }
    }
  }

  void deleteFromCart(id) {
    var cart = getData("cart");

    if (cart != null) {
      if (cart[id] != null) {
        cart.removeWhere((key, value) => key == "$id".toString());

        setData("cart", cart);
        update();

        this.sendCart(Map<String, dynamic>.from(cart));
        return cart;
      }
    }
  }

  double totalCartAmount() {
    double total = items.fold(
        0,
        (tot, item) =>
            tot.toDouble() + (item.price.toDouble() * item.meta['quantity']));

    return total;
  }

  void sendCart(body) {
    print("lasdjgl: $body ");
    CartProvider().addToCart(
        body: body,
        onSuccess: (data) {
          // ToastService.show(data.message);
          cartList();

          update();
        },
        onError: (error) {
          ToastService.show(error['message']);

          update();
        });
  }

  getCart() {
    var cart = getData("cart");

    if (cart != null) {
      return cart;
    } else {
      return {};
    }
  }

  void cartList() {
    CartProvider().getCartList(onSuccess: (data) {
      print(data.message);
      print(jsonEncode(data.data));
      print("DATA Got: ${data.data?.length}");

      items = (data.data ?? []);
      test = true;

      update();
    }, onError: (error) {
      update();
    });
  }
}
