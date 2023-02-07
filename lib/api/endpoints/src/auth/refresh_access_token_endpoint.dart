part of api_auth_endpoints;

class RefreshAccessTokenEndpoint
    extends ApiEndpoint<RefreshAccessTokenEndpointResult> {
  RefreshAccessTokenEndpoint({
    required String refreshToken,
  }) : super(
          method: RequestMethod.POST,
          url: '/token',
          includeAccessToken: false,
          includeDeviceId: true,
          headers: {'Authorization': 'Bearer $refreshToken'},
        );

  @override
  RefreshAccessTokenEndpointResult resultFromMap(Map<String, dynamic> map) {
    return RefreshAccessTokenEndpointResult.fromMap(map);
  }
}
