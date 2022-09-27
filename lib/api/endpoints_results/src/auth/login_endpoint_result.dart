part of auth_endpoints_results;

class LoginEndpointResult implements ApiEndpointResult {
  final ApiResponseUserData userWithRoleAndPrefs;

  final AuthTokens authTokens;

  const LoginEndpointResult({
    required this.userWithRoleAndPrefs,
    required this.authTokens,
  });

  Map<String, dynamic> get userWithRoleAndPrefsMap =>
      userWithRoleAndPrefs.toMap();

  factory LoginEndpointResult.fromJson(String json) {
    return LoginEndpointResult.fromMap(jsonDecode(json));
  }

  factory LoginEndpointResult.fromMap(Map<String, dynamic> map) {
    return LoginEndpointResult(
      userWithRoleAndPrefs: ApiResponseUserData.fromMap(map['user']),
      authTokens: AuthTokens.fromMap(map),
    );
  }
}
