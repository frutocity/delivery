import 'package:app/app/api/api_request.dart';
import 'package:app/app/models/AddAddressResponse.dart';
import 'package:app/app/models/GetAddressResponse.dart';

class AddressProvider {
  void addAddress({
    required Map<String, dynamic> body,
    required Function(addAddressResponse) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/address', data: body).post(
      onSuccess: (data) {
        print(data);
        onSuccess(addAddressResponse.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void getAddressList({
    required Function(AddressList) onSuccess,
    required Function(dynamic error)? onError,
  }) {
    ApiRequest(url: 'auth/address', data: null).get(
      onSuccess: (data) {
        onSuccess(AddressList.fromJson(data));
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
