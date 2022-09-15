part of '../../api_endpoints.dart';

class RequestEmailVerificationApiEndpoint extends ApiEndpoint {
  RequestEmailVerificationApiEndpoint._(String token)
      : super._(
          RequestMethod.POST,
          urlWithoutBaseUrl: '/email/verification-notification',
          token: token,
        );
}

class RequestEmailVerificationEndpointResult extends ApiEndpointResult {}
