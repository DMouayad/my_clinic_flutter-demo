part of '../../api_endpoints.dart';

class LogoutApiEndpoint extends ApiEndpoint {
  LogoutApiEndpoint._(String token)
      : super._(
          RequestMethod.POST,
          urlWithoutBaseUrl: '/logout',
          token: token,
        );
}

class LogoutEndpointResult implements ApiEndpointResult {}