part of api_endpoint;

class AddStaffEmailApiEndpoint extends ApiEndpoint {
  AddStaffEmailApiEndpoint._({
    required String email,
    required UserRole role,
    required String token,
  }) : super._(
          RequestMethod.POST,
          urlWithoutBaseUrl: '/staff-emails',
          token: token,
          data: {'email': email, 'role': role.name},
        );
}
