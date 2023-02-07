part of staff_member_api_endpoints;

/// Get all staff emails data including their roles.
/// Requires an access token
class DeleteStaffMemberApiEndpoint extends ApiEndpointWithEmptyResult {
  DeleteStaffMemberApiEndpoint({
    required int id,
  }) : super(
          method: RequestMethod.DELETE,
          url: '/staff-members/$id',
          includeAccessToken: true,
          includeDeviceId: true,
        );
}
