import 'package:app/app/api/api_request.dart';
import 'package:app/app/models/userResponse.dart';

class UserProvider {
  void me({
    required Function(User) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/me', data: null).get(
      onSuccess: (data) {
        onSuccess(User.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void updateMe({
    required Map<String, dynamic> body,
    required Function(User) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/update-me', data: body).post(
      onSuccess: (data) {
        print(data);
        onSuccess(User.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
