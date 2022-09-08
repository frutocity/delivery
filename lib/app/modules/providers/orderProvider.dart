import 'package:app/app/api/api_request.dart';

class OrderProvider {
  void checkoutOrder({
    required Map<String, dynamic> body,
    required Function(dynamic) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'order', data: body).post(
      onSuccess: (data) {
        print(data);
        onSuccess(data);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
