import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/helpers/storage.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/modules/controllers/user_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/assets.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileSetting extends StatefulWidget {
  String name;
  String mobile_no;
  ProfileSetting(this.mobile_no, this.name, {Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  String? token;
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  UserController _UserController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    token = getData('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: _bottomWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize(context).height * 0.08,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: screenSize(context).height * 0.11,
                        width: screenSize(context).height * 0.11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)),
                        child: Center(
                          child: SizedBox(
                            height: screenSize(context).height * 0.09,
                            width: screenSize(context).height * 0.09,
                            child: Container(
                              // height: 35,
                              // width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // image: DecorationImage(
                                //     // image: AssetImage(profileImage),
                                //     fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                AppText(
                                  text: "${widget.name}",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // Image.asset(editIcon)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          AppText(
                            text: "${widget.mobile_no.toString()}",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkGrey,
                          )
                        ],
                      )
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20),
                  //   child: Icon(Icons.notifications,color: AppColors.notifiactionBell,size: 16,),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            textField("name", name: true),
            textField("phone", phone: true),
            textField("email", email: true),
            AppButton(
              label: "Update Profile",
              fontWeight: FontWeight.w600,
              padding: EdgeInsets.symmetric(
                vertical: 25,
              ),
              onPressed: () {
                onupdateProfile();
              },
            ),
          ],
        ),
      ),
    );
  }

  void onupdateProfile() {
    _UserController.updateMe({
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "device_token": token,
    });
  }

  Widget textField(
    String hintText, {
    bool phone = false,
    bool name = false,
    bool email = false,
  }) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: TextFormField(
        controller: phone
            ? phoneController
            : name
                ? nameController
                : emailController,
        keyboardType: phone ? TextInputType.phone : TextInputType.text,
        cursorColor: Colors.black,
        decoration: new InputDecoration(
            focusColor: colorGrey,
            prefixIconColor: colorPrimary,
            prefixIcon: Icon(name
                ? Icons.person
                : phone
                    ? Icons.phone
                    : Icons.email),
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: hintText),
      ),
    );
  }

  Widget _bottomWidget() {
    return Container(
      child: SizedBox(
        height: 100,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Container()],
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
  //         Get.offNamed(Routes.WELCOME);
  //       },
  //     ),
  //   );
  // }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
