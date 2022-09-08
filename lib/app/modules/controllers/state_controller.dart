import 'dart:convert';

import 'package:app/app/helpers/storage.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/post.dart';
import 'package:app/app/modules/providers/authProvider.dart';
import 'package:app/app/modules/providers/testProvider.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateController extends GetxController {
  var currentIndex = 0;
  var prevIndex = 0;
  var wasOnExploreScreen = 0;

  @override
  void onInit() {
    print("laks:${getData('dashboard-index')}");
    super.onInit();
  }

  void changeIndex(index) {
    prevIndex = currentIndex;
    currentIndex = index;
    setData("dashboard-index", index);
    if (index == 1) {
      wasOnExploreScreen++;
    }
    update();
  }

  void goToCart() {
    Get.offAllNamed(Routes.DASHBOARD)?.then((value) {
      currentIndex = 2;
      prevIndex = currentIndex;

      update();
    });
  }
}
