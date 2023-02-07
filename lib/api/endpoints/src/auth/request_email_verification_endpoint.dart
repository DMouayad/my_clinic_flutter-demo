part of api_auth_endpoints;

class RequestEmailVerificationApiEndpoint extends ApiEndpointWithEmptyResult {
  RequestEmailVerificationApiEndpoint()
      : super(
          method: RequestMethod.POST,
          url: '/email/verification-notification',
          includeAccessToken: true,
          includeDeviceId: true,
        );
}
