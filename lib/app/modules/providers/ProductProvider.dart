import 'package:app/app/api/api_request.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/CategoryList.dart';
import 'package:app/app/models/ProductByIdResponse.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/post.dart';

class ProductProvider {
  void productById({
    required String id,
    required Function(ProductByIdResponse) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'product/$id', data: null).get(
      onSuccess: (data) {
        onSuccess(ProductByIdResponse.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
