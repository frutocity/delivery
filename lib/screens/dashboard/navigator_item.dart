import 'package:app/screens/account/account_screen.dart';
import 'package:app/screens/cart/cart_screen.dart';
import 'package:app/screens/explore/explore_screen.dart';
import 'package:app/screens/favourite/favourite_screen.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Tesk", "assets/icons/shop_icon.svg", 0, TaskScreen()),
  NavigatorItem("Earning", "assets/icons/explore_icon.svg", 1, EarningScreen()),
  NavigatorItem("Refrral", "assets/icons/cart_icon.svg", 2, RefrralScreen()),
    NavigatorItem("Profile", "assets/icons/account_icon.svg", 3, AccountScreen()),

];
