part of staff_email_api_endpoints;

class AddStaffEmailApiEndpoint extends ApiEndpoint<EmptyApiEndpointResult> {
  AddStaffEmailApiEndpoint({
    required String email,
    required UserRole role,
  }) : super(
          method: RequestMethod.POST,
          url: '/staff-emails',
          data: {'email': email, 'role': role.name},
          includeDeviceId: true,
          includeAccessToken: true,
        );
}
