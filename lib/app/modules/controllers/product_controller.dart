import 'package:app/app/helpers/string.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/CategoryDataResponse.dart';
import 'package:app/app/models/CategoryList.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/post.dart';
import 'package:app/app/modules/providers/CategoryProvider.dart';
import 'package:app/app/modules/providers/ProductProvider.dart';
import 'package:app/app/modules/providers/testProvider.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  Product? item;
  String dropdownvalue = "";
  var items = [""];

  bool isLoading = true;
  @override
  void onInit() {
    super.onInit();
  }

  void productById(String id) {
    // ToastService.show("data.message");

    ProductProvider().productById(
        id: id,
        onSuccess: (data) {
          item = data.data;
          dropdownvalue = ((data.data?.options ?? []).first.title ?? "") +
              "      -      $rupees" +
              ((data.data?.options ?? []).first.price ?? "");
          items = (data.data?.options ?? [])
              .map((e) => "${e.title}      -      $rupees${e.price}")
              .toList();
          update();
        },
        onError: (error) {
          // ToastService.show(error['message']);

          update();
        });
  }
}
