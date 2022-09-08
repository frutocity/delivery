import 'package:app/app/common_widgets/toastWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Toast {
  static loading(String message) {
    Get.snackbar("", "",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        borderRadius: 20,
        overlayBlur: 0.10,
        barBlur: 0,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        isDismissible: false,
        forwardAnimationCurve: Curves.bounceInOut,
        reverseAnimationCurve: Curves.bounceIn,
        boxShadows: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 25.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              -10.0, // Move to right 10  horizontally
              -10.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        titleText: CustomeToast(message));
  }
}
