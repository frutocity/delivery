import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/userResponse.dart';
import 'package:app/app/modules/providers/userProvider.dart';
import 'package:app/screens/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController {
  bool isLoading = true;
  User? user;
  @override
  void onInit() {
    super.onInit();
  }

  void me() {
    // ToastService.show("data.message");

    UserProvider().me(onSuccess: (data) {
      user = data;
      update();
    }, onError: (error) {
      // ToastService.show(error['message']);

      update();
    });
  }

  void updateMe(body) {
    UserProvider().updateMe(
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
}
