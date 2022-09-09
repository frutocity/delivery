import 'package:app/app/modules/providers/authProvider.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() {
  initGetStorage();
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        primaryColor: colorPrimary,
        accentColor: colorPrimary,
        accentColorBrightness: Brightness.light,
      ),
    ),
  );
}

void initGetStorage() async {
  await GetStorage.init();
  AuthProvider().updateStatus(status: "on", onError: (e) {}, onSuccess: () {});
}
