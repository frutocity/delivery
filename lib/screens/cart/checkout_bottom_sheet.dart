import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/order_failed_dialog.dart';
import 'package:app/app/helpers/string.dart';
import 'package:app/app/modules/controllers/addAdddress_controller.dart';
import 'package:app/app/modules/controllers/auth_controller.dart';
import 'package:app/app/modules/controllers/cart_controller.dart';
import 'package:app/app/modules/controllers/odercontroller.dart';
import 'package:app/screens/address/selectAddressSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutBottomSheet extends StatefulWidget {
  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  CartController _cartController = Get.put(CartController());
  OrderController _orderController = Get.put(OrderController());
  final AuthController _authController = Get.put(AuthController());
  AddAddressContoller _addressContoller = Get.put(AddAddressContoller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressContoller>(builder: (_context) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: new Wrap(
          children: <Widget>[
            Row(
              children: [
                AppText(
                  text: "Checkout",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 25,
                    ))
              ],
            ),
            SizedBox(
              height: 45,
            ),
            getDivider(),
            checkoutRow("Delivery",
                trailingText: _addressContoller.selectedAdrs?.apartment ??
                    "Select Address", click: () {
              showBottomSheet(context);
            }),
            getDivider(),
            checkoutRow("Total Cost",
                trailingText: "$rupees ${_cartController.totalCartAmount()}"),
            getDivider(),
            SizedBox(
              height: 30,
            ),
            termsAndConditionsAgreement(context),
            Container(
              margin: EdgeInsets.only(
                top: 25,
              ),
              child: AppButton(
                label: "Place Order",
                fontWeight: FontWeight.w600,
                padding: EdgeInsets.symmetric(
                  vertical: 25,
                ),
                onPressed: () {
                  onPlaceOrderClicked();
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'By placing an order you agree to our',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 14,
            fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily ?? "",
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
                text: " Terms",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            TextSpan(text: " And"),
            TextSpan(
                text: " Conditions",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ]),
    );
  }

  Widget checkoutRow(String label,
      {required String trailingText,
      Widget trailingWidget = const Icon(Icons.payment),
      click = null}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        children: [
          AppText(
            text: label,
            fontSize: 18,
            color: Color(0xFF7C7C7C),
            fontWeight: FontWeight.w600,
          ),
          Spacer(),
          trailingText == "null"
              ? trailingWidget
              : InkWell(
                  onTap: click == null ? () {} : click,
                  child: AppText(
                    text: trailingText,
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  void onPlaceOrderClicked() {
    Navigator.pop(context);
    print("cartItems dAta: ${_cartController.getCart()}");
    // _orderController.checkoutOrder({
    //   "items": _cartController.items,
    //   "address": "62e8091abc36085a93df43d0"
    // });
    _authController.socket?.emit('place-order', {
      "order": {
        "items": _cartController.items,
        "address": "62e8091abc36085a93df43d0"
      }
    });

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return OrderFailedDialogue();
    //     });
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return SelectAdrsSheet();
        });
  }
}
