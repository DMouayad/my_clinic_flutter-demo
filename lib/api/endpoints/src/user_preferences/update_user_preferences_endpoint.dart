part of user_preferences_endpoints;

class UpdateUserPreferencesApiEndpoint
    extends ApiEndpoint<EmptyApiEndpointResult> {
  UpdateUserPreferencesApiEndpoint({
    String? locale,
    String? theme,
  }) : super(
          method: RequestMethod.PUT,
          url: '/me/preferences',
          includeDeviceId: true,
          includeAccessToken: true,
          data: () {
            Map<String, dynamic> data = {};
            if (locale != null) {
              data['locale'] = locale;
            }
            if (theme != null) {
              data['theme'] = theme;
            }
            return data;
          }(),
        );
}
