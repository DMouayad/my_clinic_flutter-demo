part of user_preferences_endpoints;

class CreateUserPreferencesApiEndpoint
    extends ApiEndpoint<EmptyApiEndpointResult> {
  CreateUserPreferencesApiEndpoint({
    required String locale,
    required String theme,
  }) : super(
          method: RequestMethod.POST,
          url: '/me/preferences',
          includeDeviceId: true,
          includeAccessToken: true,
          data: {
            "theme": theme,
            "locale": locale,
          },
        );
}
