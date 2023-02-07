part of user_preferences_endpoints_results;

class FetchUserPreferencesEndpointResult extends BaseApiEndpointResult {
  final String locale;
  final String theme;

  FetchUserPreferencesEndpointResult({
    required this.locale,
    required this.theme,
  });

  Map<String, dynamic> toMap() {
    return {
      'locale': locale,
      'theme': theme,
    };
  }

  factory FetchUserPreferencesEndpointResult.fromMap(Map<String, dynamic> map) {
    return FetchUserPreferencesEndpointResult(
      locale: map['locale'] as String,
      theme: map['theme'] as String,
    );
  }
}
