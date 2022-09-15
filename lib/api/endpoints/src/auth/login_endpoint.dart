part of '../../api_endpoints.dart';

class LoginApiEndpoint extends ApiEndpoint {
  LoginApiEndpoint._(String email, String password)
      : super._(
          RequestMethod.POST,
          urlWithoutBaseUrl: '/login',
          data: {'email': email, 'password': password},
        );
}

class LoginEndpointResult implements ApiEndpointResult {
  final Map<String, dynamic> userWithRoleMap;
  final Map<String, dynamic> userPreferencesMap;
  final AuthTokens authTokens;
  const LoginEndpointResult({
    required this.userWithRoleMap,
    required this.userPreferencesMap,
    required this.authTokens,
  });
  factory LoginEndpointResult.fromJson(String json) {
    return LoginEndpointResult.fromMap(jsonDecode(json));
  }

  factory LoginEndpointResult.fromMap(Map<String, dynamic> map) {
    return LoginEndpointResult(
      userWithRoleMap: map['user'] as Map<String, dynamic>,
      userPreferencesMap: map['user']['preferences'] as Map<String, dynamic>,
      authTokens: AuthTokens.fromMap(map),
    );
  }
}
