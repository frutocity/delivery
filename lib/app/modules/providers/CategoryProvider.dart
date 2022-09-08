import 'package:app/app/api/api_request.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/CategoryDataResponse.dart';
import 'package:app/app/models/CategoryList.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/post.dart';

class CategoryProvider {
  void getCategoryList({
    required Function(CategoryListResponse) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'category', data: null).get(
      onSuccess: (data) {
        onSuccess(CategoryListResponse.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void getCategoryProductList({
    required String id,
    required Function(CategoryDataReponse) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'category/$id', data: null).get(
      onSuccess: (data) {
        onSuccess(CategoryDataReponse.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
