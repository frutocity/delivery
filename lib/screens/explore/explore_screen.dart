import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/category_item_card_widget.dart';
import 'package:app/app/common_widgets/search_bar_widget.dart';
import 'package:app/app/common_widgets/search_bar_widget2.dart';
import 'package:app/app/models/CategoryList.dart';
import 'package:app/app/models/category_item.dart';
import 'package:app/app/modules/controllers/category_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/screens/category/category_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

List<Color> gridColors = [
  Color(0xff53B175),
  Color(0xffF8A44C),
  Color(0xffF7A593),
  Color(0xffD3B0E0),
  Color(0xffFDE598),
  Color(0xffB7DFF5),
  Color(0xff836AF6),
  Color(0xffD73B77),
];

class EarningScreen extends StatelessWidget {
  final CategoryController _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (_context) {
      return Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            getHeader(),
            Expanded(
              child: getOrderListView(context),
            ),
          ],
        ),
      ));
    });
  }

  Widget getHeader() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: AppText(
            text: "₹ 0",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: AppText(
            text: "Today",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      
      ],
    );
  }

  Widget getOrderListView(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Theme(
              data: ThemeData(focusColor: colorBlack),
              child: ExpansionTile(
                textColor: Colors.black,
              title: Text(
                "26 Aug",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                  "Total Earning ₹ 0" ,
              style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),

                ListTile(
                  title: Text(
                  "Orders Done 0" ,
              style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                ListTile(
                  title: Text(
                  "incentive ₹ 0" ,
              style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                ListTile(
                  title: Text(
                  "Deduction -₹ 0" ,
                  
              style: TextStyle( color: colorRedDark, fontWeight: FontWeight.w700),
                  ),
                )
              ],
                      ),
            ),
          ),
        );
      });
  }


}
