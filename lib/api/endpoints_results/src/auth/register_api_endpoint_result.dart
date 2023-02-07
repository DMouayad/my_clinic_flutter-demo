part of auth_endpoints_results;

class RegisterEndpointResult implements BaseApiEndpointResult {
  final AuthTokens authTokens;

  final ApiResponseUserData userWithRole;

  const RegisterEndpointResult({
    required this.authTokens,
    required this.userWithRole,
  });
  factory RegisterEndpointResult.fromJson(String json) {
    return RegisterEndpointResult.fromMap(jsonDecode(json));
  }
  Map<String, dynamic> get userWithRoleMap => userWithRole.toMap();
  factory RegisterEndpointResult.fromMap(Map<String, dynamic> map) {
    return RegisterEndpointResult(
      authTokens: AuthTokens.fromMap(map),
      userWithRole: ApiResponseUserData.fromMap(map['user']),
    );
  }
}
