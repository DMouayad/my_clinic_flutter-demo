part of api_auth_endpoints;

class LogoutApiEndpoint extends ApiEndpointWithEmptyResult {
  LogoutApiEndpoint()
      : super(
          method: RequestMethod.POST,
          url: '/logout',
          includeAccessToken: true,
          includeDeviceId: true,
        );
}
