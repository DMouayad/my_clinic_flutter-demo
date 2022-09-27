part of api_auth_endpoints;

class LogoutApiEndpoint extends ApiEndpoint<EmptyApiEndpointResult> {
  LogoutApiEndpoint()
      : super(
          method: RequestMethod.POST,
          url: '/logout',
          includeAccessToken: true,
          includeDeviceId: true,
        );
}
