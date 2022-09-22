part of '../api_endpoint.dart';

class GetUserPreferencesApiEndpoint extends ApiEndpoint {
  GetUserPreferencesApiEndpoint._(String token)
      : super._(
          RequestMethod.GET,
          urlWithoutBaseUrl: '/user-preferences',
          token: token,
        );
}
