import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';

import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/colors.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String imagePath = "assets/images/welcome_image.png";

  final List carouselList = [
    Slides("E Shopping", "Explore top organic fruits & grab them",
        "assets/images/Take Away-pana.svg", 1),
    Slides("Delivery on the way", "Get your order by speed delivery",
        "assets/images/Online Groceries-cuate.svg", 1),
    Slides("Delivery Arrived", "Order is arrived at your Place",
        "assets/images/Delivery address-rafiki.svg", 1)
  ];

  int pageIndex = 0;

  CarouselController _carouselController = CarouselController();

  String buttonText = "Next";
  final RoundedRectangleBorder r = new RoundedRectangleBorder(
      side: BorderSide.none, borderRadius: new BorderRadius.circular(5.0));
  CircleBorder c = const CircleBorder(side: BorderSide.none);

  dynamic handlePageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      pageIndex = index;
      if (index == 2) {
        buttonText = "Get Started";
      } else {
        buttonText = "Next";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          // padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: Colors.white
              // image: DecorationImage(
              //   image: AssetImage(imagePath),
              //   fit: BoxFit.cover,
              // ),
              ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Spacer(),
                SizedBox(
                  height: 86,
                ),

                InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: skipButton()),
                SizedBox(
                  height: 100,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    enableInfiniteScroll: false,
                    onPageChanged: handlePageChanged,
                    viewportFraction: 1,
                  ),
                  carouselController: _carouselController,
                  items: carouselList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  i.img,
                                  width: 300,
                                ),
                                welcomeTextWidget(i.title),
                                SizedBox(
                                  height: 16,
                                ),
                                sloganText(i.desc),
                              ],
                            ));
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 0,
                ),
                CarouselIndicator(
                  color: colorPrimary,
                  activeColor: Colors.green.shade100,
                  width: 10,
                  height: 10,
                  count: carouselList.length,
                  index: pageIndex,
                ),
                SizedBox(
                  height: 80,
                ),
                getButton(context),
              ],
            ),
          ),
        ));
  }

  Widget skipButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Skip",
          style: TextStyle(
            color: Color(0xFF898989),
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: 29,
        )
      ],
    );
  }

  Widget icon() {
    String iconPath = "assets/icons/app_icon.svg";
    return SvgPicture.asset(
      iconPath,
      color: Colors.black,
      width: 48,
      height: 56,
    );
  }

  Widget welcomeTextWidget(String title) {
    return Column(
      children: [
        AppText(
          text: title,
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget sloganText(String desc) {
    return AppText(
      text: desc,
      fontSize: 14,
      // fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 143, 143, 143).withOpacity(0.7),
    );
  }

  Widget getButton(BuildContext context) {
    return ButtonTheme(
      minWidth: 146.0,
      height: 48,
      shape: ShapeBorder.lerp(r, c, 0.1),
      buttonColor: colorPrimary,
      colorScheme: ColorScheme.dark(),
      child: ElevatedButton(
        onPressed: () {
          _carouselController.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.linear);
          if (pageIndex == 2) {
            onGetStartedClicked(context);
          }
        },
        child: Text(buttonText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Get.offNamed(Routes.SIGNUP);
  }
}

class Slides {
  String title;
  String desc;
  String img;
  int id;
  Slides(this.title, this.desc, this.img, this.id);
}
