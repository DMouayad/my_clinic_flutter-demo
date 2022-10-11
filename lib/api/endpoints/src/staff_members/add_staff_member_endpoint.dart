part of staff_member_api_endpoints;

class AddStaffMemberApiEndpoint
    extends ApiEndpoint<AddStaffMemberEndpointResult> {
  AddStaffMemberApiEndpoint({
    required String email,
    required UserRole role,
  }) : super(
          method: RequestMethod.POST,
          url: '/staff-members',
          data: {'email': email, 'role': role.name},
          includeDeviceId: true,
          includeAccessToken: true,
        );
}
