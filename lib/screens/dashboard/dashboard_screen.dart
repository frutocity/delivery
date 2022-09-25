import 'package:app/app/modules/controllers/state_controller.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../app/helpers/storage.dart';
import 'navigator_item.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  DateTime timeBackPressed = DateTime.now();

  final StateController state = Get.put(StateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData('orderStatus', "O");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(builder: (_context) {
      return WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference > Duration(seconds: 2);
          timeBackPressed = DateTime.now();
          if (isExitWarning) {
            final message = 'Press back again to exit';
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: navigatorItems[state.currentIndex].screen,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 37,
                    offset: Offset(0, -12)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: state.currentIndex,
                onTap: (index) {
                  state.changeIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: colorPrimary,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                unselectedItemColor: Colors.black,
                items: navigatorItems.map((e) {
                  return getNavigationBarItem(
                      label: e.label, index: e.index, iconPath: e.iconPath);
                }).toList(),
              ),
            ),
          ),
        ),
      );
    });
  }

  BottomNavigationBarItem getNavigationBarItem(
      {String? label, String? iconPath, int? index}) {
    Color iconColor =
        index == state.currentIndex ? AppColors.primaryColor : Colors.black;
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        iconPath!,
        color: iconColor,
      ),
    );
  }
}
