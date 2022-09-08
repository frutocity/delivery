import 'package:app/app/api/api_request.dart';
import 'package:app/app/models/BannerList.dart';
import 'package:app/app/models/post.dart';

class PostsProvider {
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
}
