import 'dart:ui';

import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/item_counter_widget.dart';
import 'package:app/app/helpers/string.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/grocery_item.dart';
import 'package:app/app/modules/controllers/cart_controller.dart';
import 'package:app/app/modules/controllers/category_controller.dart';
import 'package:app/app/modules/controllers/product_controller.dart';
import 'package:app/app/modules/controllers/state_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'favourite_toggle_icon_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String? heroSuffix;

  const ProductDetailsScreen({this.heroSuffix});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int amount = 1;
  ProductController _productController = Get.put(ProductController());
  CartController _cartController = Get.put(CartController());
  final StateController state = Get.find<StateController>();

  @override
  void initState() {
    super.initState();
    var id = Get.parameters["id"];

    if (id != null) {
      _productController.productById(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (_context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: colorBlack,
            ),
          ),
          actions: [
            Icon(
              Icons.notifications,
              color: colorBlack,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.cloud_upload_outlined,
              color: colorBlack,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                getImageHeaderWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          _productController.item?.name ?? "",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        subtitle: AppText(
                          text:
                              "${_productController.item?.weight ?? ""} , $rupees${_productController.item?.price ?? ""}",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff7C7C7C),
                        ),
                        trailing: FavoriteToggleIcon(),
                      ),
                      (_productController.item?.options ?? []).length > 0
                          ? Container(
                              width: double.infinity * 0.8,
                              child: DropdownButton(
                                value: _productController.dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: _productController.items
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _productController.dropdownvalue =
                                        newValue!;
                                  });
                                },
                              ),
                            )
                          : Container(),

                      Row(
                        children: [
                          // ItemCounterWidget(
                          //   onAmountChanged: (newAmount) {
                          //     setState(() {
                          //       amount = newAmount;
                          //     });
                          //   },
                          // ),

                          GetBuilder<CartController>(builder: (__context) {
                            return Row(
                              children: [
                                _cartController.getCart()[
                                            "${_productController.item?.id}"] !=
                                        null
                                    ? addWidget(false)
                                    : Container(),
                                _cartController.getCart()[
                                            "${_productController.item?.id}"] !=
                                        null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "${_cartController.getCart()["${_productController.item?.id}"]["quantity"]}"),
                                      )
                                    : Container(),
                                addWidget(true),
                              ],
                            );
                          }),
                          Spacer(),
                          Text(
                            "\₹${getTotalPrice().toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Divider(thickness: 1, color: Colors.transparent),
                      ListTileTheme(
                        dense: true,
                        minVerticalPadding: 0,
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: getProductDataRowWidget(
                            "Description",
                            // customWidget: nutritionWidget()
                          ),
                          children: [
                            Text(
                                "${_productController.item?.description ?? ""}"),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      // getProductDataRowWidget("Product Details"),
                      // Divider(thickness: 1),
                      // getProductDataRowWidget("Nutritions",
                      //     customWidget: nutritionWidget()),

                      // getProductDataRowWidget(
                      //   "Review",
                      //   customWidget: ratingWidget(),
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.25,
                      // ),

                      GetBuilder<StateController>(builder: (context) {
                        return AppButton(
                          label: "Add To Basket",
                          onPressed: () {
                            // _cartController
                            //     .addToCart(_productController.item?.id);

                            Get.toNamed(Routes.CARTSCREEN);
                          },
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        // gradient: new LinearGradient(
        //     colors: [
        //       const Color(0xFF3366FF).withOpacity(0.1),
        //       const Color(0xFF3366FF).withOpacity(0.09),
        //     ],
        //     begin: const FractionalOffset(0.0, 0.0),
        //     end: const FractionalOffset(0.0, 1.0),
        //     stops: [0.0, 1.0],
        //     tileMode: TileMode.clamp),
      ),
      child: Image(
        image: NetworkImage(_productController.item?.photo.first ??
            "https://assets.frutocity.com/1657127340712.jpg"),
      ),
    );
  }

  Widget getProductDataRowWidget(String label, {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
          Spacer(),
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
          // Icon(
          //   Icons.arrow_forward_ios,
          //   size: 20,
          // )
        ],
      ),
    );
  }

  Widget nutritionWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: "100gm",
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget ratingWidget() {
    Widget starIcon() {
      return Icon(
        Icons.star,
        color: Color(0xffF3603F),
        size: 20,
      );
    }

    return Row(
      children: [
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
      ],
    );
  }

  double getTotalPrice() {
    return amount * ((_productController.item?.price ?? 0).toDouble());
  }

  Widget addWidget(bool add) {
    return InkWell(
      onTap: add
          ? () {
              _cartController.addToCart(_productController.item?.id);
            }
          : () {
              _cartController.removeFromCart(_productController.item?.id);
            },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: add ? colorPrimary : colorWhite,
            border: !add ? Border.all(color: Color(0xffE2E2E2)) : null),
        child: Center(
          child: Icon(
            add ? Icons.add : Icons.remove,
            color: add ? Colors.white : colorGreyDark,
            size: 25,
          ),
        ),
      ),
    );
  }
}
