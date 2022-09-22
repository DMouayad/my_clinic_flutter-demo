part of '../../api_endpoint.dart';

class GetUserInfoEndpoint extends ApiEndpoint {
  GetUserInfoEndpoint._(String accessToken)
      : super._(
          RequestMethod.GET,
          urlWithoutBaseUrl: '/me',
          token: accessToken,
        );
}

class GetUserInfoEndpointResult extends ApiEndpointResult {
  final Map<String, dynamic> userWithRoleAndPrefs;

  const GetUserInfoEndpointResult({required this.userWithRoleAndPrefs});

  factory GetUserInfoEndpointResult.fromJson(String json) {
    return GetUserInfoEndpointResult.fromMap(jsonDecode(json));
  }

  factory GetUserInfoEndpointResult.fromMap(Map<String, dynamic> map) {
    return GetUserInfoEndpointResult(
      userWithRoleAndPrefs: map['user'] as Map<String, dynamic>,
    );
  }
}
