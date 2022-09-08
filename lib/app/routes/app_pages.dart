import 'package:app/screens/SplashScreen.dart';
import 'package:app/screens/cart/cart_screen.dart';
import 'package:app/screens/category/category_items_screen.dart';
import 'package:app/screens/category/filter_screen.dart';
import 'package:app/screens/dashboard/dashboard_screen.dart';
import 'package:app/screens/onboarding/MobileVerificationScreen.dart';
import 'package:app/screens/onboarding/SignupScreen.dart';
import 'package:app/screens/onboarding/WelcomeScreen.dart';
import 'package:app/screens/product_details/product_details_screen.dart';
import 'package:app/screens/searchProductScreen/searchProductScreen.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: _Paths.MOBILEVERIFY,
      page: () => MobileVerification(),
    ),
    GetPage(
      name: _Paths.CATEGORYITEMS,
      page: () => CategoryItemsScreen(),

      // transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAIL,
      page: () => ProductDetailsScreen(),
      // transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: _Paths.SEARCHPRODUCT,
      page: () => SearchProductScreen(),
      // transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: _Paths.FILTERSCREEN,
      page: () => FilterScreen(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
      popGesture: false,
    ),
    GetPage(
      name: _Paths.CARTSCREEN,
      page: () => RefrralScreen(),
    ),
  ];
}
