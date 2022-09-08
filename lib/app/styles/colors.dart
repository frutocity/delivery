import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  //One instance, needs factory
  static AppColors? _instance;
  factory AppColors() => _instance ??= AppColors._();

  AppColors._();

  static const primaryColor = Color(0xff53B175);
  static const darkGrey = Color(0xff7C7C7C);
}

const colorPrimary = Color(0xff53B175);
const transparentColor = Color(0xFF808080);
const redPrimary = Color(0xFFF34345);
const colorSecondary = Color(0xFF2E2E2E);
const colorAccent = Color(0xFFFFFFFF);
const colorWhite = Color(0xFFFFFFFF);
const colorBlack = Color(0xFF000000);
const colorGrey = Color(0xFF9E9E9E);
const colorGreyText = Color(0xFFCCCCCC);
const colorGreyDark = Color(0xFF4A4A49);
const colorGreyLight = Color(0xFFAEAEAE);
const colorGreyExtraLight = Color(0xffE8E8E8);
const colorGreenLight = Color(0xFF9EBB54);
const colorGreen = Color(0xFF00AF00);
const colorRedDark = Color(0xFFB90000);
const colorPrimaryLight = const Color(0x22FEA07E);
const colorSecondaryTransparent = Color(0x22251707);
const colorTransparent = Color(0x00000000);
const colorDDD = Color(0xFFeaccff);
const colorGradient = Color(0xFFD67D5D);
const colorGradient2 = Color(0xFFFEA07E);
const colorGradient3 = Color(0xFFFEBCA4);
const colorGradient4 = Color(0xFFF5DCDC);
const colorPrimaryText = Color(0xFF000000);
const colorHintText = Color(0xFF000000);
const unselectedTab = Color(0xFF9FA9B8);
const selectedTab = Color(0xFF3c3c3c);
const orange = Color(0xffFFBB73);
const pageBg = Color(0xFFf0eff4);
const cardBorder = Color(0xFFd6d6d6);
const textGray = Color(0xFF828282);
const secondaryTextColor = Color(0xff3A3A3A);
// const textGreen = Color(0xFF119D3A);
const teamGray = Color(0xFF999999);
const borderGreen = Color(0xFFC9E6D0);
const lightBlack = Color(0xFF1B1B1B);
const semiBlack = Color(0xFF3A3A3A);
const remainProgress = Color(0xFFF3EFEF);
const remainProgress2 = Color(0xFFefefef);
const grey63 = Color(0xFF636363);
Color dividerColor = Colors.grey.shade100;
const lightGreenBtn = Color(0xFFB2F0BA);
const greenButtonBorderColor = Color(0xFF8CDE96);
const textGreen = Color(0xFF00B218);
const disableButton = Color(0xFFdadada);
const dottedBorderColor = Color(0xff707070);
const borderShadow = Color(0xff82828233);
const colorSecondaryText = Color(0xff3B3939);
const colorTextSecondary = Color(0xffA2A2A2);
const greenShadow = Color(0xff63E474);
const greyMedium = Color(0xff474747);
const labeledColor = Color(0xffC4CDDA);
const blueShadow = Color(0xff4E8DFE);
const redShadow = Color(0xffFFF6F0);
const greenBorderColor = Color(0xff00B21854);
const orangeBackGroundColor = Color(0xffFF6F00);
const greyButtonBackground = Color(0xffDCDCDCF2);
const continueBtn = Color(0xffDCDCDC);
const greyButtonBorder = Color(0xff82828233);
const progressSelected = Color(0xffb6b6b6);
const progressUnSelected = Color(0xfff0f0f0);

const MaterialColor colorPrimaryMaterial =
    MaterialColor(0xFFCF5154, <int, Color>{100: colorPrimary});

const MaterialColor colorSecondaryMaterial =
    MaterialColor(0xFFCF5154, <int, Color>{100: colorSecondary});

// rgb to hex
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  static int _getColorFromHex2(String hexColor) {
    hexColor = hexColor.toUpperCase();
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex2(hexColor));
}
