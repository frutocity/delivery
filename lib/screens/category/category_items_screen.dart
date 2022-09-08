import 'package:app/app/common_widgets/ProductCard.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/grocery_item_card_widget.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/grocery_item.dart';
import 'package:app/app/modules/controllers/category_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/screens/category/filter_screen.dart';
import 'package:app/screens/product_details/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CategoryItemsScreen extends StatefulWidget {
  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  CategoryController _categoryController = Get.put(CategoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var id = Get.parameters["id"];
    if (id != null) {
      _categoryController.categoryById(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (_context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.only(left: 25),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.FILTERSCREEN);
              },
              child: Container(
                padding: EdgeInsets.only(right: 25),
                child: Icon(
                  Icons.sort,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          title: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: AppText(
              text: _categoryController.category?.name ?? "",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: (_categoryController.category?.products ?? []).length > 0
            ? StaggeredGridView.countBuilder(
                itemCount:
                    (_categoryController.category?.products ?? []).length,
                crossAxisCount: 4,
                // I only need two card horizontally
                itemBuilder: (_, index) {
                  Product? groceryItem =
                      _categoryController.category?.products[index];
                  return GestureDetector(
                    onTap: () {
                      // onItemClicked(context, groceryItem);
                      Get.toNamed(Routes.PRODUCTDETAIL,
                          parameters: {'id': groceryItem?.id ?? ""});
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: ProductCard(
                        item: groceryItem,
                        heroSuffix: "explore_screen",
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),

                mainAxisSpacing: 3.0,
                crossAxisSpacing: 0.0, // add some space
              )
            : Container(),
      );
    });
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          heroSuffix: "explore_screen",
        ),
      ),
    );
  }
}
