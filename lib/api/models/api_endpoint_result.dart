import 'dart:convert';

import '../endpoints_results/endpoints_results.dart';

class EmptyApiEndpointResult extends ApiEndpointResult {}

class ApiEndpointResult extends Object {
  const ApiEndpointResult();

  static R fromJson<R extends ApiEndpointResult>(dynamic json) {
    dynamic data;
    if (json is Map<String, dynamic>) {
      assert(json.containsKey('data'));
      data = json['data'];
    } else if (json is String && json.isNotEmpty) {
      try {
        final jsonMap = jsonDecode(json);
        assert(jsonMap.containsKey('data'));
        data = jsonMap['data'];
      } catch (e) {}
    }
    switch (R) {
      case EmptyApiEndpointResult:
        return EmptyApiEndpointResult() as R;
      case LoginEndpointResult:
        return LoginEndpointResult.fromMap(data) as R;
      case RegisterEndpointResult:
        return RegisterEndpointResult.fromMap(data) as R;
      case FetchStaffMembersEndpointResult:
        return FetchStaffMembersEndpointResult.fromApiResponse(json) as R;
      case RefreshAccessTokenEndpointResult:
        return RefreshAccessTokenEndpointResult.fromMap(data) as R;
      case FetchUserEndpointResult:
        return FetchUserEndpointResult.fromMap(data) as R;
      case FetchUserPreferencesEndpointResult:
        return FetchUserPreferencesEndpointResult.fromMap(data) as R;
      case AddStaffMemberEndpointResult:
        return AddStaffMemberEndpointResult.fromMap(data) as R;
      default:
        return const ApiEndpointResult() as R;
    }
  }
}
