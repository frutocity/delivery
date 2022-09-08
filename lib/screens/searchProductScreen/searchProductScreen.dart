import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/category_item_card_widget.dart';
import 'package:app/app/common_widgets/search_bar_widget.dart';
import 'package:app/app/common_widgets/search_bar_widget2.dart';
import 'package:app/app/models/CategoryList.dart';
import 'package:app/app/models/category_item.dart';
import 'package:app/app/modules/controllers/category_controller.dart';
import 'package:app/app/routes/app_pages.dart';
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

class SearchProductScreen extends StatelessWidget {
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
              child: getStaggeredGridView(context),
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SearchBarWidget2("home"),
          // child: SearchBarWidget("explore"),
        ),
      ],
    );
  }

  Widget getStaggeredGridView(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 4,
      children: _categoryController.categories.asMap().entries.map<Widget>((e) {
        int index = e.key;
        CategoryData categoryItem = e.value;
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.CATEGORYITEMS,
                parameters: {"id": e.value.id.toString()});
            // onCategoryItemClicked(context, categoryItem);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: CategoryItemCardWidget(
              item: categoryItem,
              color: gridColors[index % gridColors.length],
            ),
          ),
        );
      }).toList(),

      //Here is the place that we are getting flexible/ dynamic card for various images
      staggeredTiles: _categoryController.categories
          .map<StaggeredTile>((_) => StaggeredTile.fit(2))
          .toList(),
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 4.0, // add some space
    );
  }

  void onCategoryItemClicked(BuildContext context, CategoryData categoryItem) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return CategoryItemsScreen();
      },
    ));
  }
}
