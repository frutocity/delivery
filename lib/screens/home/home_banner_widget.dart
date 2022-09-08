import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  BannerData? banner;

  HomeBanner(this.banner);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: 500,
        height: 115,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                  widget.banner?.image ?? "",
                ),
                fit: BoxFit.cover)),
        child: Container(),
        // Row(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        //       child: Image.network(
        //         "",
        //       ),
        //     ),
        //     Spacer(),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         AppText(
        //           text: "Fresh Vegetables",
        //           fontSize: 22,
        //           fontWeight: FontWeight.bold,
        //         ),
        //         AppText(
        //           text: "Get Up To 40%  OFF",
        //           fontSize: 16,
        //           fontWeight: FontWeight.w600,
        //           color: colorPrimary,
        //         ),
        //       ],
        //     ),
        //     SizedBox(
        //       width: 20,
        //     )
        //   ],
        // ),
      ),
    );
  }
}
