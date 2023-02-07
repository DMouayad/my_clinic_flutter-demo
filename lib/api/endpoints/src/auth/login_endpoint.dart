part of api_auth_endpoints;

class LoginApiEndpoint extends ApiEndpoint<LoginEndpointResult> {
  LoginApiEndpoint({
    required String email,
    required String password,
  }) : super(
          method: RequestMethod.POST,
          url: '/login',
          includeAccessToken: false,
          includeDeviceId: true,
          data: {
            'email': email,
            'password': password,
          },
        );

  @override
  LoginEndpointResult resultFromMap(Map<String, dynamic> map) {
    return LoginEndpointResult.fromMap(map);
  }
}
