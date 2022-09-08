import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/grocery_item.dart';
import 'package:app/app/modules/controllers/cart_controller.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'item_counter_widget.dart';

class ChartItemWidget extends StatefulWidget {
  ChartItemWidget({required this.item});
  final Product item;

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 80;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;
  CartController _cartController = Get.find<CartController>();

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (context) {
      return Container(
        height: height,
        margin: EdgeInsets.symmetric(
          vertical: 30,
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              imageWidget(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: ((widget.item.name).length > 18
                        ? (widget.item.name).substring(0, 18)
                        : (widget.item.name)),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  AppText(
                      text:
                          "${widget.item.unitValue}${widget.item.unit.name}, \₹${widget.item.price}",
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey),
                  SizedBox(
                    height: 5,
                  ),
                  Spacer(),
                  // ItemCounterWidget(
                  //   onAmountChanged: (newAmount) {
                  //     setState(() {
                  //       amount = newAmount;
                  //     });
                  //   },
                  // )
                  Row(
                    children: [
                      iconWidget(Icons.remove, iconColor: colorGreyDark,
                          onPressed: () {
                        _cartController.removeFromCart(widget.item.id);
                      }),
                      SizedBox(width: 18),
                      Container(
                          width: 30,
                          child: Center(
                              child: getText(
                                  text: widget.item.meta['quantity'].toString(),
                                  fontSize: 14,
                                  isBold: true))),
                      SizedBox(width: 18),
                      iconWidget(Icons.add, iconColor: AppColors.primaryColor,
                          onPressed: () {
                        _cartController.addToCart(widget.item.id);
                      })
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      _cartController.deleteFromCart(widget.item.id);
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColors.darkGrey,
                      size: 25,
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                  Container(
                    width: 70,
                    child: AppText(
                      text: "\₹${getPrice().toStringAsFixed(1)}",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget imageWidget() {
    return Container(
      width: 80,
      child: Image.network(widget.item.photo.first),
    );
  }

  dynamic getPrice() {
    return (widget.item.price) * widget.item.meta['quantity'];
  }

  Widget iconWidget(IconData iconData, {Color? iconColor, onPressed}) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Color(0xffE2E2E2),
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor ?? Colors.black,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget getText(
      {String? text,
      double? fontSize,
      bool isBold = false,
      color = Colors.black}) {
    return Text(
      text ?? "",
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
}
