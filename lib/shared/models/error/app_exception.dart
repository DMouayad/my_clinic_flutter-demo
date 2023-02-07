import 'package:clinic_v2/shared/services/logger_service.dart';
import 'package:flutter/material.dart';

//
import 'package:clinic_v2/api/errors/api_exception_class.dart';
import 'package:clinic_v2/utils/extensions/context_extensions.dart';

/// Custom app exception
///
/// Usage:
/// - determining the error message
/// - converting [ApiExceptionClass] to [AppException]
enum AppException {
  noConnectionFound,
  noAccessTokenFound,
  cannotConnectToServer,
  userUnauthorized,
  noRefreshTokenFound,
  emailAlreadyRegistered,
  invalidEmailCredential,
  invalidPasswordCredential,
  emailUnauthorizedToRegister,
  invalidApiRequest,
  failedToRefreshTokens,
  deletingOnlyAdminStaffMember,
  roleNotFound,
  staffMemberAlreadyExists,
  userPreferencesAlreadyExists,
  invalidRefreshToken,
  userDoesntMatchHisStaffMember,
  decodingJsonFailed,

  /// indicates that an undefined exception was thrown/returned.
  ///
  /// applies for platform exceptions, unregistered api exceptions,
  /// plugin exception, etc
  external;

  static AppException fromApiException(
    ApiExceptionClass apiExceptionClass,
  ) {
    try {
      return AppException.values.byName(apiExceptionClass.name);
    } on ArgumentError {
      Log.w(
          "No [AppException] matches the [ApiExceptionClass]'$apiExceptionClass'");
      return AppException.external;
    }
  }

  String getMessage(BuildContext context) {
    switch (this) {
      case AppException.noConnectionFound:
        return context.localizations!.cannotConnectToServer;
      case AppException.emailAlreadyRegistered:
        return context.localizations!.emailAlreadyExists;
      case AppException.userUnauthorized:
        return context.localizations!.userUnauthorized;
      case AppException.invalidEmailCredential:
        return context.localizations!.emailAddressNotFound;
      case AppException.invalidPasswordCredential:
        return context.localizations!.passwordIsIncorrect;
      case AppException.emailUnauthorizedToRegister:
        return context.localizations!.emailUnauthorizedToRegister;
      case AppException.invalidApiRequest:
        return context.localizations!.invalidApiRequest;
      case AppException.failedToRefreshTokens:
        return context.localizations!.failedToAuthenticateUser;
      case AppException.invalidRefreshToken:
        return context.localizations!.loginRequired;

      case AppException.decodingJsonFailed:
      case AppException.deletingOnlyAdminStaffMember:
      case AppException.roleNotFound:
      case AppException.staffMemberAlreadyExists:
      case AppException.userPreferencesAlreadyExists:
      case AppException.userDoesntMatchHisStaffMember:
      case AppException.noAccessTokenFound:
      case AppException.cannotConnectToServer:
      case AppException.noRefreshTokenFound:
      case AppException.external:
        return name;
    }
  }
}
