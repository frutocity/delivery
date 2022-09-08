import 'dart:convert';

import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/AddAddressResponse.dart';
import 'package:app/app/models/GetAddressResponse.dart';
import 'package:app/app/modules/providers/addressProvider.dart';
import 'package:app/screens/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';

class AddAddressContoller extends GetxController {
  List<Datum> getaddress = <Datum>[].obs;
  Datum? selectedAdrs = null;
  @override
  void onInit() {
    super.onInit();
  }

  void addAddress(body) {
    AddressProvider().addAddress(
        body: body,
        onSuccess: (data) {
          ToastService.show(data.message);
          Get.to(() => DashboardScreen());
          // verifyOtpBody["hash"] = data.data.hash;
          update();
        },
        onError: (error) {
          ToastService.show(error.toString());

          // isLoading = false;
          // isOtpSent = false;

          update();
        });
  }

  void setAddrs(d) {
    selectedAdrs = d;
    update();
  }

  void getAddressList() {
    AddressProvider().getAddressList(onSuccess: (data) {
      print(data.message);
      print(jsonEncode(data.data));

      getaddress = (data.data ?? []);

      update();
    }, onError: (error) {
      ToastService.show("data.message ?? " "");
      // ToastService.show(error['message']);

      update();
    });
  }
}
