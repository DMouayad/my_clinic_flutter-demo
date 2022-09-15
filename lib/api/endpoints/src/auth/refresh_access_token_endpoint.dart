part of '../../api_endpoints.dart';

class RefreshAccessTokenEndpoint extends ApiEndpoint {
  RefreshAccessTokenEndpoint._(String refreshToken)
      : super._(
          RequestMethod.POST,
          urlWithoutBaseUrl: '/token',
          token: refreshToken,
        );
}

class RefreshAccessTokenEndpointResult extends ApiEndpointResult {
  final AuthTokens authTokens;

  const RefreshAccessTokenEndpointResult({required this.authTokens});

  factory RefreshAccessTokenEndpointResult.fromMap(
    Map<String, dynamic> map,
  ) {
    return RefreshAccessTokenEndpointResult(
      authTokens: AuthTokens.fromMap(map['authTokens']),
    );
  }
}
