import 'api_endpoint.dart';

abstract class BaseHttpClient {
  const BaseHttpClient();

  Future<BaseHttpClientResponse> performHttpRequest({
    required ApiEndpoint apiEndpoint,
    String? accessToken,
  });
}

abstract class BaseHttpClientResponse {
  int? get statusCode;

  Uri get uri;

  dynamic get data;
}

extension BaseHttpClientResponseExtension on BaseHttpClientResponse {
  bool get isSuccess {
    if (statusCode != null) {
      return (statusCode! ~/ 100) == 2;
    }
    return false;
  }
}
