part of staff_member_api_endpoints;

class UpdateStaffMemberApiEndpoint extends ApiEndpointWithEmptyResult {
  UpdateStaffMemberApiEndpoint({
    required int id,
    String? newEmail,
    UserRole? newRole,
  })  : assert(newEmail != null || newRole != null),
        super(
          method: RequestMethod.PUT,
          url: '/staff-members/$id',
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
