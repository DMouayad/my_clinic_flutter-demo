part of '../../api_endpoints.dart';

class LoginApiEndpoint extends ApiEndpoint {
  LoginApiEndpoint._(String email, String password, String deviceId)
      : super._(
          RequestMethod.POST,
          urlWithoutBaseUrl: '/login',
          data: {'email': email, 'password': password, 'device_id': deviceId},
        );
}

class LoginEndpointResult implements ApiEndpointResult {
  final Map<String, dynamic> userWithRoleAndPrefs;

  final AuthTokens authTokens;
  const LoginEndpointResult({
    required this.userWithRoleAndPrefs,
    required this.authTokens,
  });
  factory LoginEndpointResult.fromJson(String json) {
    return LoginEndpointResult.fromMap(jsonDecode(json));
  }

  factory LoginEndpointResult.fromMap(Map<String, dynamic> map) {
    return LoginEndpointResult(
      userWithRoleAndPrefs: map['user'] as Map<String, dynamic>,
      authTokens: AuthTokens.fromMap(map),
    );
  }
}
