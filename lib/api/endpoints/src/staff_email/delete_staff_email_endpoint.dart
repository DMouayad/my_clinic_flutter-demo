part of staff_email_api_endpoints;

/// Get all staff emails data including their roles.
/// Requires an access token
class DeleteStaffEmailApiEndpoint extends ApiEndpoint<EmptyApiEndpointResult> {
  DeleteStaffEmailApiEndpoint({
    required int staffEmailId,
  }) : super(
          method: RequestMethod.DELETE,
          url: '/staff-emails/$staffEmailId',
          includeAccessToken: true,
          includeDeviceId: true,
        );
}
