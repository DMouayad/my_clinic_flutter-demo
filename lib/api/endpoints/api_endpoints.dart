import 'dart:convert';

import 'package:clinic_v2/api/utils/auth_tokens.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';

part 'src/api_endpoint_result.dart';
part 'src/auth/login_endpoint.dart';
part 'src/auth/logout_endpoint.dart';
part 'src/auth/refresh_access_token_endpoint.dart';
part 'src/auth/register_endpoint.dart';
part 'src/auth/request_email_verification_endpoint.dart';
part 'src/user/get_user_info_endpoint.dart';
part 'src/user_preferences_endpoints.dart';

/// A class that provides all required data to perform an HTTP request for
/// a specific API endpoint.
abstract class ApiEndpoint {
  final String urlWithoutBaseUrl;
  final RequestMethod method;
  final String? token;
  final Map<String, dynamic>? data;

  const ApiEndpoint._(
    this.method, {
    required this.urlWithoutBaseUrl,
    this.token,
    this.data,
  });

  factory ApiEndpoint.login(String email, String password, String deviceId) =
      LoginApiEndpoint._;

  factory ApiEndpoint.register(
    String name,
    String email,
    String password,
    String deviceId,
  ) = RegisterApiEndpoint._;

  factory ApiEndpoint.logout(String accessToken) = LogoutApiEndpoint._;
  factory ApiEndpoint.requestEmailVerification(String accessToken) =
      RequestEmailVerificationApiEndpoint._;
  factory ApiEndpoint.refreshAccessToken(String refreshToken) =
      RefreshAccessTokenEndpoint._;

  factory ApiEndpoint.getUserInfo(String accessToken) = GetUserInfoEndpoint._;
  // factory ApiEndpoint.getUserPreferences(String token) =
  //     GetUserPreferencesApiEndpoint._;
}

enum RequestMethod { GET, POST, DELETE, PUT }
