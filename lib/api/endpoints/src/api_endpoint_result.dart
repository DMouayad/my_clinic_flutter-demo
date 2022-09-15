part of '../api_endpoints.dart';

abstract class ApiEndpointResult extends ResultType {
  const ApiEndpointResult();
  static R fromJson<R extends ApiEndpointResult>(String json) {
    final String dataJson = jsonDecode(json)['data'];
    switch (R.runtimeType) {
      case LoginEndpointResult:
        return LoginEndpointResult.fromJson(dataJson) as R;
      case RegisterEndpointResult:
        return RegisterEndpointResult.fromJson(dataJson) as R;
      case LogoutEndpointResult:
        return LogoutEndpointResult() as R;
      case RequestEmailVerificationApiEndpoint:
        return RequestEmailVerificationApiEndpointResult() as R;
      default:
        throw UnimplementedError();
    }
  }
}
