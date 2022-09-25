import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/order_failed_dialog.dart';
import 'package:app/app/helpers/string.dart';
import 'package:app/app/modules/controllers/addAdddress_controller.dart';
import 'package:app/app/modules/controllers/auth_controller.dart';
import 'package:app/app/modules/controllers/cart_controller.dart';
import 'package:app/app/modules/controllers/odercontroller.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectAdrsSheet extends StatefulWidget {
  @override
  _SelectAdrsSheetState createState() => _SelectAdrsSheetState();
}

class _SelectAdrsSheetState extends State<SelectAdrsSheet> {
  AddAddressContoller _addressContoller = Get.put(AddAddressContoller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressContoller.getAddressList();
  }

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
                  text: "Select Address",
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
            _addressContoller.getaddress.length > 0
                ? ListView.builder(
                    itemCount: _addressContoller.getaddress.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var a = _addressContoller.getaddress[index];

                      return InkWell(
                        onTap: () {
                          _addressContoller.setAddrs(a);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity * 0.8,
                          height: 60,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _addressContoller.selectedAdrs?.id == a.id
                                  ? colorPrimary
                                  : Color(0xFFE2E2E2),
                              width: _addressContoller.selectedAdrs?.id == a.id
                                  ? 2
                                  : 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  _addressContoller.selectedAdrs?.id == a.id
                                      ? 9
                                      : 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "${a.apartment}, ${a.address}, ${a.city}, ${a.pinCode}\n(${a.howToReach})",
                              style: TextStyle(
                                color: colorGreyDark,
                                fontSize: 12,
                              )),
                        ),
                      );
                    },
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            termsAndConditionsAgreement(context),
            // Container(
            //   margin: EdgeInsets.only(
            //     top: 25,
            //   ),
            //   child: AppButton(
            //     label: "Confirm",
            //     fontWeight: FontWeight.w600,
            //     padding: EdgeInsets.symmetric(
            //       vertical: 25,
            //     ),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
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
      Widget trailingWidget = const Icon(Icons.payment)}) {
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
                  onTap: () => showBottomSheet(context),
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
