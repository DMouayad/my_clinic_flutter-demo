// ignore_for_file: constant_identifier_names
library api_endpoint;

import 'dart:convert';

import 'package:clinic_v2/api/utils/auth_tokens.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';

part 'src/staff_email/add_staff_email_endpoint.dart';
part 'src/staff_email/get_staff_emails_endpoint.dart';
part 'src/staff_email/edit_staff_email_endpoint.dart';
part 'src/staff_email/delete_staff_email_endpoint.dart';
part 'src/api_endpoint_result.dart';
part 'src/auth/login_endpoint.dart';
part 'src/auth/logout_endpoint.dart';
part 'src/auth/refresh_access_token_endpoint.dart';
part 'src/auth/register_endpoint.dart';
part 'src/auth/request_email_verification_endpoint.dart';
part 'src/user/get_user_info_endpoint.dart';
part 'src/user_preferences_endpoints.dart';

/// Provides all required data to perform an HTTP request for
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
  /*
  * Auth Api Endpoints
  */
  factory ApiEndpoint.login(String email, String password, String deviceId) =
      LoginApiEndpoint._;
  factory ApiEndpoint.register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String deviceId,
  }) = RegisterApiEndpoint._;
  factory ApiEndpoint.logout(String accessToken) = LogoutApiEndpoint._;
  factory ApiEndpoint.requestEmailVerification(String accessToken) =
      RequestEmailVerificationApiEndpoint._;
  factory ApiEndpoint.refreshAccessToken(String refreshToken) =
      RefreshAccessTokenEndpoint._;
  /*
  * User Api Endpoints
  */
  factory ApiEndpoint.getUserInfo(String accessToken) = GetUserInfoEndpoint._;
  /*
  * Staff Emails Api Endpoints
  */
  factory ApiEndpoint.addStaffEmail({
    required String email,
    required UserRole role,
    required String token,
  }) = AddStaffEmailApiEndpoint._;
  factory ApiEndpoint.getStaffEmailsWithRoles(String accessToken) =
      GetStaffEmailsWithRolesApiEndpoint._;

  /// Updates the staff email that matches the provided ID
  factory ApiEndpoint.editStaffEmail({
    required int id,
    required String token,
    String? newEmail,
    UserRole? newRole,
  }) = EditStaffEmailApiEndpoint._;

  /// Delete the staff email that matches the provided ID
  factory ApiEndpoint.deleteStaffEmail({
    required int id,
    required String token,
  }) = DeleteStaffEmailApiEndpoint._;
  // factory ApiEndpoint.getUserPreferences(String token) =
  //     GetUserPreferencesApiEndpoint._;
}

enum RequestMethod { GET, POST, DELETE, PUT }
