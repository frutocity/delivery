import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/modules/controllers/addAdddress_controller.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final AddAddressContoller _addAddressContoller =
      Get.put(AddAddressContoller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addAddressContoller.getAddressList();

    print("dnfkjhf${_addAddressContoller.getaddress}");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressContoller>(builder: (_context) {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            AppText(
              text: "Select Address",
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: colorBlack),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Address("Addess"),
                  Address("Pin Code"),
                  Address("Appatment"),
                  Address("City"),
                  Address("State"),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget Address(String text) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Row(children: [
          AppText(
            text: "$text:-",
          ),
          SizedBox(
            width: 10,
          ),
          if (_addAddressContoller.getaddress.length > 0)
            Text(
                "${text == "Addess" ? _addAddressContoller.getaddress[0].address : text == "Pin Code" ? _addAddressContoller.getaddress[0].pinCode : text == "Appatment" ? _addAddressContoller.getaddress[0].apartment : text == "City" ? _addAddressContoller.getaddress[0].city : text == "State" ? _addAddressContoller.getaddress[0].state : ""}")
        ]));
  }
}
