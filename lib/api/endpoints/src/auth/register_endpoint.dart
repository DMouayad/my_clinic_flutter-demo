part of api_auth_endpoints;

class RegisterApiEndpoint extends ApiEndpoint<RegisterEndpointResult> {
  RegisterApiEndpoint({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) : super(
          method: RequestMethod.POST,
          url: '/register',
          includeDeviceId: true,
          includeAccessToken: false,
          data: {
            'name': name,
            'email': email,
            'phone_number': phoneNumber,
            'password': password,
          },
        );

  @override
  RegisterEndpointResult resultFromApiResponseMap(map) {
    return RegisterEndpointResult.fromMap(map);
  }
}
