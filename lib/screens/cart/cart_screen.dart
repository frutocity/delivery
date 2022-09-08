import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/chart_item_widget.dart';
import 'package:app/app/helpers/column_with_seprator.dart';
import 'package:app/app/helpers/string.dart';
import 'package:app/app/models/grocery_item.dart';
import 'package:app/app/modules/controllers/cart_controller.dart';
import 'package:app/app/styles/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'checkout_bottom_sheet.dart';

class RefrralScreen extends StatefulWidget {
  @override
  State<RefrralScreen> createState() => _RefrralScreenState();
}

class _RefrralScreenState extends State<RefrralScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AppText(
          text: "Comming Soon",
          fontWeight: FontWeight.w600,
          color: Color(0xFF7C7C7C),
        ),
      ),
    );
  }
}