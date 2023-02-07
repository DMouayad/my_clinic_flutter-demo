part of auth_endpoints_results;

class RefreshAccessTokenEndpointResult extends BaseApiEndpointResult {
  final AuthTokens authTokens;

  const RefreshAccessTokenEndpointResult({required this.authTokens});

  factory RefreshAccessTokenEndpointResult.fromMap(
    Map<String, dynamic> map,
  ) {
    return RefreshAccessTokenEndpointResult(
      authTokens: AuthTokens.fromMap(map),
    );
  }
}
