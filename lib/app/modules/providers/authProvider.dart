import 'package:app/app/api/api_request.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/post.dart';
import 'package:app/app/models/sendOtpResponse.dart';
import 'package:app/app/models/verifyOtpReponse.dart';

class AuthProvider {
  void sendOtp({
    required Map<String, dynamic> body,
    required Function(sendOtpResponse) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/employee/send-otp', data: body).post(
      onSuccess: (data) {
        print(data);
        onSuccess(sendOtpResponse.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void verifyOtp({
    required Map<String, dynamic> body,
    required Function(VerifyOtpReponse) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/employee/verify-otp', data: body).post(
      onSuccess: (data) {
        print(data);
        onSuccess(VerifyOtpReponse.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error.toString())},
    );
  }

  void getBannerList({
    required Function(BannerListReponse) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/banner', data: null).get(
      onSuccess: (data) {
        onSuccess(BannerListReponse.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void getExclusiveOfferList({
    required Function(ProductList) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/exclusive-offer', data: null).get(
      onSuccess: (data) {
        onSuccess(ProductList.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void getBestSellingList({
    required Function(ProductList) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/best-selling', data: null).get(
      onSuccess: (data) {
        onSuccess(ProductList.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void getMostPopularList({
    required Function(ProductList) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/most-popular', data: null).get(
      onSuccess: (data) {
        onSuccess(ProductList.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void getproductDetail({
    required String id,
    required Function(ProductList) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'product/$id', data: null).get(
      onSuccess: (data) {
        onSuccess(ProductList.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void updateStatus({
    required String status,
    required Function()? onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/employee/online?status=$status', data: null).get(
      onSuccess: (data) {},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
