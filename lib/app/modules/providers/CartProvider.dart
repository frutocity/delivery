import 'package:app/app/api/api_request.dart';
import 'package:app/app/data/app_utils.dart';
import 'package:app/app/models/AddtoCartResponse.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/CategoryList.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/post.dart';

class CartProvider {
  void addToCart({
    required Map<String, dynamic> body,
    required Function(AddtoCartResponse) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'cart/add', data: body).post(
      onSuccess: (data) {
        print(data);
        onSuccess(AddtoCartResponse.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void getCartList({
    required Function(ProductList) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'cart', data: null).get(
      onSuccess: (data) {
        onSuccess(ProductList.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
