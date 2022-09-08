import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/AddtoCartResponse.dart';
import 'package:app/app/modules/controllers/addAdddress_controller.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/app/styles/theme.dart';
import 'package:app/screens/dashboard/dashboard_screen.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddAddress extends StatefulWidget {
  String geoLocation;
  AddAddress(this.geoLocation);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController homeController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController AppartmentController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController howtoreachController = TextEditingController();
  final AddAddressContoller _addAddressContoller =
      Get.put(AddAddressContoller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addAddressContoller.obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTransparent,
        elevation: 0,
        title: AppText(
          text: "Set Delivery Location",
          fontWeight: FontWeight.bold,
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: colorBlack,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textField("*House/ Flat no", house: true),
              textField("Floor No", floor: true),
              textField("Appartment/Building Name", apprtment: true),
              textField("Contact Number", phone: true),
              textField("How To Reach(Optional)", howtoreach: true),
              SizedBox(
                height: 50,
              ),
              AppButton(
                label: "Save Address",
                onPressed: () {
                  if (homeController.text.isNotEmpty) {
                    _addAddressContoller.addAddress(
                      {
                        "type": homeController.text,
                        "address": floorController.text,
                        "apartment": AppartmentController.text,
                        "how_to_reach": howtoreachController.text,
                        "city": "Jaipur",
                        "state": "state",
                        "pin_code": 302012,
                        "geo_location": {"full_address": widget.geoLocation},
                      },
                    );
                    // Get.to(() => DashboardScreen());
                    // ToastService.show("Address Add");
                  } else {
                    ToastService.show("please add House/Flat no");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(String hintText,
      {bool phone = false,
      bool house = false,
      bool floor = false,
      bool apprtment = false,
      bool howtoreach = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: phone
            ? phoneController
            : house
                ? homeController
                : floor
                    ? floorController
                    : apprtment
                        ? AppartmentController
                        : howtoreachController,
        keyboardType: phone
            ? TextInputType.phone
            : howtoreach
                ? TextInputType.multiline
                : TextInputType.text,
        cursorColor: Colors.black,
        decoration: new InputDecoration(
            focusColor: colorGrey,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: hintText),
      ),
    );
  }
}
