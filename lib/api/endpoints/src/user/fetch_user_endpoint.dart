part of user_api_endpoints;

class FetchUserEndpoint extends ApiEndpoint<FetchUserEndpointResult> {
  FetchUserEndpoint()
      : super(
          method: RequestMethod.GET,
          url: '/me',
          includeAccessToken: true,
          includeDeviceId: true,
        );
}
