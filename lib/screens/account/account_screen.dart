import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/helpers/column_with_seprator.dart';
import 'package:app/app/helpers/storage.dart';
import 'package:app/app/modules/controllers/auth_controller.dart';
import 'package:app/app/modules/controllers/user_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/assets.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/screens/account/profile_setting.dart';
import 'package:app/screens/address/list_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'account_item.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserController _UserController = Get.put(UserController());
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    _UserController.me();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                getImageHeader(),
                SizedBox(
                  height: 20,
                ),
                AppText(
                  text: "Ashok Kumar Meena",
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5,
                ),
                AppText(
                  text: "Employe Id - LG142664",
                ),
                SizedBox(
                  height: 5,
                ),
                BottomSheet(
                  builder: (BuildContext context) {
                    return Container();
                  },
                  onClosing: () {},
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget logoutButton() {
  //   return Container(
  //     width: double.maxFinite,
  //     margin: EdgeInsets.symmetric(horizontal: 25),
  //     child: RaisedButton(
  //       visualDensity: VisualDensity.compact,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(18.0),
  //       ),
  //       color: Color(0xffF2F3F2),
  //       textColor: Colors.white,
  //       elevation: 0.0,
  //       padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           SizedBox(
  //             width: 20,
  //             height: 20,
  //             child: SvgPicture.asset(
  //               "assets/icons/account_icons/logout_icon.svg",
  //             ),
  //           ),
  //           Text(
  //             "Log Out",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: AppColors.primaryColor),
  //           ),
  //           Container()
  //         ],
  //       ),
  //       onPressed: () {
  //         setData("user", null);
  //         setData("token", null);
  //         _authController.socket?.disconnect();
  //         print("socket disconnect${_authController.socket}");
  //         Get.offNamed(Routes.WELCOME);
  //       },
  //     ),
  //   );
  // }

  Widget getImageHeader() {
    String imagePath = no_user_image;
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: AssetImage(
        imagePath,
      ),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              accountItem.iconPath,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
