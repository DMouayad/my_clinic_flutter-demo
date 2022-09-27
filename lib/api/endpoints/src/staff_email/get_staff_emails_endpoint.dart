part of staff_email_api_endpoints;

/// Get a list of staff emails including their roles and users(if exists).
///
/// Requires an access token
class FetchStaffEmailsApiEndpoint
    extends ApiEndpoint<FetchStaffEmailsEndpointResult> {
  FetchStaffEmailsApiEndpoint()
      : super(
          method: RequestMethod.GET,
          url: '/staff-emails',
          includeDeviceId: true,
          includeAccessToken: true,
        );
}
