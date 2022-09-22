part of '../../api_endpoint.dart';

class RegisterApiEndpoint extends ApiEndpoint {
  RegisterApiEndpoint._({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String deviceId,
  }) : super._(
          RequestMethod.POST,
          urlWithoutBaseUrl: '/register',
          data: {
            'name': name,
            'email': email,
            'phone_number': phoneNumber,
            'password': password,
            'device_id': deviceId,
          },
        );
}

class RegisterEndpointResult implements ApiEndpointResult {
  final AuthTokens authTokens;

  final Map<String, dynamic> userWithRole;

  const RegisterEndpointResult({
    required this.authTokens,
    required this.userWithRole,
  });
  factory RegisterEndpointResult.fromJson(String json) {
    return RegisterEndpointResult.fromMap(jsonDecode(json));
  }

  factory RegisterEndpointResult.fromMap(Map<String, dynamic> map) {
    return RegisterEndpointResult(
      authTokens: AuthTokens.fromMap(map),
      userWithRole: map['user'] as Map<String, dynamic>,
    );
  }
}
