import 'dart:async';

import 'package:app/app/helpers/storage.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    const delay = const Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    print(getData('user'));
    var token = getData("token");
    if (token != null) {
      Get.offNamed(Routes.DASHBOARD);
    } else {
      Get.offNamed(Routes.WELCOME);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/icons/logo.png"),
      ),
    );
  }
}

Widget splashScreenIcon() {
  String iconPath = "assets/icons/logo.png";
  return SvgPicture.asset(
    iconPath,
  );
}
