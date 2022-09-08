import 'package:app/app/modules/providers/orderProvider.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void checkoutOrder(body) {
    OrderProvider().checkoutOrder(
        body: body,
        onSuccess: (data) {
          print("Sending Otp");

          update();
        },
        onError: (error) {
          update();
        });
  }
}
