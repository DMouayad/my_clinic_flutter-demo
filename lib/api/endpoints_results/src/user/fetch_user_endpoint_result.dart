part of user_endpoints_results;

class FetchUserEndpointResult extends ApiEndpointResult {
  final ApiResponseUserData userWithRoleAndPrefs;

  const FetchUserEndpointResult({required this.userWithRoleAndPrefs});

  factory FetchUserEndpointResult.fromJson(String json) {
    return FetchUserEndpointResult.fromMap(jsonDecode(json));
  }

  factory FetchUserEndpointResult.fromMap(Map<String, dynamic> map) {
    return FetchUserEndpointResult(
      userWithRoleAndPrefs: ApiResponseUserData.fromMap(map),
    );
  }
}
