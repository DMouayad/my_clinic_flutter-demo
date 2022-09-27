part of user_preferences_endpoints;

class FetchUserPreferencesApiEndpoint
    extends ApiEndpoint<FetchUserPreferencesEndpointResult> {
  FetchUserPreferencesApiEndpoint()
      : super(
          method: RequestMethod.GET,
          url: '/me/preferences',
          includeDeviceId: true,
          includeAccessToken: true,
        );
}
