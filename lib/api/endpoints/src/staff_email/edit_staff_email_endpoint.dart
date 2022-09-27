part of staff_email_api_endpoints;

class EditStaffEmailApiEndpoint extends ApiEndpoint<EmptyApiEndpointResult> {
  EditStaffEmailApiEndpoint({
    required int staffEmailId,
    String? newEmail,
    UserRole? newRole,
  })  : assert(newEmail != null || newRole != null),
        super(
          method: RequestMethod.PUT,
          url: '/staff-emails/$staffEmailId',
          includeAccessToken: true,
          includeDeviceId: true,
          data: () {
            Map<String, dynamic> data = {};
            if (newEmail != null) {
              data['email'] = newEmail;
            }
            if (newRole != null) {
              data['role'] = newRole.name;
            }
            return data;
          }(),
        );
}
