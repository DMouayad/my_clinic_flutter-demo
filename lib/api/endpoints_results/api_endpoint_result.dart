import 'endpoints_results.dart';

class EmptyApiEndpointResult extends ApiEndpointResult {}

class ApiEndpointResult extends Object {
  const ApiEndpointResult();

  static R fromJson<R extends ApiEndpointResult>(
      Map<String, dynamic> jsonObject) {
    final data = jsonObject['data'];
    switch (R) {
      case EmptyApiEndpointResult:
        return EmptyApiEndpointResult() as R;
      case LoginEndpointResult:
        return LoginEndpointResult.fromMap(data) as R;
      case RegisterEndpointResult:
        return RegisterEndpointResult.fromMap(data) as R;
      case FetchStaffEmailsEndpointResult:
        return FetchStaffEmailsEndpointResult.fromApiResponse(data) as R;
      case RefreshAccessTokenEndpointResult:
        return RefreshAccessTokenEndpointResult.fromMap(data) as R;
      case FetchUserEndpointResult:
        return FetchUserEndpointResult.fromMap(data) as R;
      case FetchUserPreferencesEndpointResult:
        return FetchUserPreferencesEndpointResult.fromMap(data) as R;
      default:
        return const ApiEndpointResult() as R;
    }
  }
}
