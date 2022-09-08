import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/helpers/string.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/grocery_item.dart';
import 'package:app/app/modules/controllers/auth_controller.dart';
import 'package:app/app/modules/controllers/cart_controller.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatefulWidget {
  ProductCard({Key? key, this.item, this.heroSuffix}) : super(key: key);
  final Product? item;
  final String? heroSuffix;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final double width = 174;

  final double height = 250;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  AuthController _authController = Get.put(AuthController());

  CartController _cartController = Get.put(CartController());
  String dropdownvalue = "";
  var items = [""];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownvalue = ((widget.item?.options ?? []).first.title ?? "") +
        "-$rupees" +
        ((widget.item?.options ?? []).first.price ?? "");
    items = (widget.item?.options ?? [])
        .map((e) => "${e.title}-$rupees${e.price}")
        .toList();
  }

// List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (_context) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: imageWidget(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AppText(
                text: ((widget.item?.name ?? "").length > 18
                    ? (widget.item?.name ?? "").substring(0, 18)
                    : (widget.item?.name ?? "")),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              // (widget.item?.options ?? []).length > 0
              //     ? DropdownButton(
              //         value: dropdownvalue,
              //         icon: const Icon(Icons.keyboard_arrow_down),
              //         items: items.map((String items) {
              //           return DropdownMenuItem(
              //             value: items,
              //             child: Text(items),
              //           );
              //         }).toList(),
              //         onChanged: (String? newValue) {
              //           setState(() {
              //             dropdownvalue = newValue!;
              //           });
              //         },
              //       )
              //     : Container(),
              // AppText(
              //   text: "${widget.item?.unitValue}${widget.item?.unit.name}",
              //   fontSize: 14,
              //   fontWeight: FontWeight.w600,
              //   color: Color(0xFF7C7C7C),
              // ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  AppText(
                    text: "\₹${widget.item?.price}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      _cartController.getCart()["${widget.item?.id}"] != null
                          ? addWidget(false)
                          : Container(),
                      _cartController.getCart()["${widget.item?.id}"] != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "${_cartController.getCart()["${widget.item?.id}"]["quantity"]}"),
                            )
                          : Container(),
                      addWidget(true),
                    ],
                  )
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
      child: Image.network(widget.item?.photo.first ?? ""),
    );
  }

  Widget addWidget(bool add) {
    return InkWell(
      onTap: add
          ? () {
              _cartController.addToCart(widget.item?.id);
            }
          : () {
              _cartController.removeFromCart(widget.item?.id);
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
