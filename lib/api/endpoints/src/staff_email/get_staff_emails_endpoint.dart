part of staff_email_api_endpoints;

/// Get a list of staff emails including their roles and users(if exists).
///
/// Requires an access token
class GetStaffEmailsApiEndpoint
    extends ApiEndpoint<GetStaffEmailsEndpointResult> {
  GetStaffEmailsApiEndpoint()
      : super(
          method: RequestMethod.GET,
          url: '/staff-emails',
          includeDeviceId: true,
          includeAccessToken: true,
        );
}
