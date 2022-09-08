import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/CategoryDataResponse.dart';
import 'package:app/app/models/CategoryList.dart';
import 'package:app/app/models/post.dart';
import 'package:app/app/modules/providers/CategoryProvider.dart';
import 'package:app/app/modules/providers/testProvider.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  List<CategoryData> categories = <CategoryData>[].obs;
  Category? category;
  bool isLoading = true;
  @override
  void onInit() {
    super.onInit();
  }

  void categoryList() {
    // ToastService.show("data.message");
    categories = [];
    CategoryProvider().getCategoryList(onSuccess: (data) {
      categories = (data.data ?? []);

      update();
    }, onError: (error) {
      ToastService.show(error['message']);

      update();
    });
  }

  void categoryById(String id) {
    category = null;
    CategoryProvider().getCategoryProductList(
        id: id,
        onSuccess: (data) {
          category = data.data ?? Category.fromJson({});
          update();
        },
        onError: (error) {
          ToastService.show(error);

          update();
        });
  }
}
