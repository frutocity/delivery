import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/post.dart';
import 'package:app/app/modules/providers/testProvider.dart';
import 'package:get/get.dart';

class PostsController extends GetxController {
  List<Post> postsList = [];
  bool isLoading = true;
  @override
  void onInit() {
    bannerList();
    super.onInit();
  }

  void bannerList() {
    // ToastService.show("data.message");

    PostsProvider().getBannerList(onSuccess: (data) {
      print(data.message);

      update();
    }, onError: (error) {
      ToastService.show(error['message']);

      update();
    });
  }
}
