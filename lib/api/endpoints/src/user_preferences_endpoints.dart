part of '../api_endpoints.dart';

class GetUserPreferencesApiEndpoint extends ApiEndpoint {
  GetUserPreferencesApiEndpoint._(String token)
      : super._(
          RequestMethod.GET,
          urlWithoutBaseUrl: '/user-preferences',
          token: token,
        );
}
