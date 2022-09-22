part of '../api_endpoint.dart';

class ApiEndpointResult extends ResultType {
  const ApiEndpointResult();

  static R fromJson<R extends ApiEndpointResult>(
      Map<String, dynamic> jsonObject) {
    final data = jsonObject['data'];

    switch (R) {
      case LoginEndpointResult:
        return LoginEndpointResult.fromMap(data) as R;
      case RegisterEndpointResult:
        return RegisterEndpointResult.fromMap(data) as R;
      case LogoutEndpointResult:
        return LogoutEndpointResult() as R;
      case RequestEmailVerificationApiEndpoint:
        return RequestEmailVerificationEndpointResult() as R;
      case GetStaffEmailsWithRolesEndpointResult:
        return GetStaffEmailsWithRolesEndpointResult(data) as R;
      default:
        return const ApiEndpointResult() as R;
    }
  }
}
