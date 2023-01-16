import 'package:flutter/material.dart';
//
import 'package:equatable/equatable.dart';
//
import 'package:clinic_v2/api/errors/api_exception_class.dart';
import 'package:clinic_v2/utils/extensions/context_extensions.dart';

import 'error_exception_api_exception_proxy.dart';

/// Represents specific app exceptions
///
/// used in:
/// - determining the error message
/// - converting [ApiExceptionClass] to app [ErrorException]
class ErrorException extends Equatable {
  const ErrorException(this.name);
  final String name;
  String? getMessage(BuildContext context) => null;

  const factory ErrorException.noConnectionFound() = NoConnectionFoundException;
  const factory ErrorException.noAccessTokenFound() =
      NoAccessTokenFoundException;
  const factory ErrorException.cannotConnectToServer() =
      CannotConnectToServerException;
  const factory ErrorException.userUnauthorized() = _UserUnauthorizedException;
  const factory ErrorException.noRefreshTokenFound() =
      NoRefreshTokenFoundException;
  const factory ErrorException.emailAlreadyRegistered() =
      EmailAlreadyRegisteredException;
  const factory ErrorException.invalidEmailCredential() =
      InvalidEmailCredentialException;
  const factory ErrorException.invalidPasswordCredential() =
      InvalidPasswordCredentialException;
  const factory ErrorException.emailUnauthorizedToRegister() =
      EmailUnauthorizedToRegisterException;
  const factory ErrorException.invalidApiRequest() = InvalidApiRequestException;
  const factory ErrorException.failedToRefreshTokens() =
      FailedToRefreshAuthTokensException;

  factory ErrorException.deletingOnlyAdminStaffMember() {
    return const ErrorException('DeletingOnlyAdminStaffMember');
  }

  factory ErrorException.roleNotFound() {
    return const ErrorException('RoleNotFound');
  }
  factory ErrorException.staffMemberAlreadyExists() {
    return const ErrorException('StaffMemberAlreadyExists');
  }

  factory ErrorException.userPreferencesAlreadyExists() {
    return const ErrorException('UserPreferencesAlreadyExists');
  }
  factory ErrorException.userDoesntMatchHisStaffMember() {
    return const ErrorException('UserDoesntMatchHisStaffMember');
  }

  factory ErrorException.fromApiException(ApiExceptionClass apiExceptionClass) {
    return ApiExceptionClassProxy.toErrorException(apiExceptionClass);
  }

  @override
  String toString() {
    return 'ErrorException{name: $name}';
  }

  @override
  List<Object?> get props => [name];
}

class NoAccessTokenFoundException extends ErrorException {
  const NoAccessTokenFoundException() : super('NoAccessTokenFound');
}

class NoConnectionFoundException extends ErrorException {
  const NoConnectionFoundException() : super('NoInternetConnectionFound');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.noInternetConnection;
  }
}

class CannotConnectToServerException extends ErrorException {
  const CannotConnectToServerException() : super('CannotConnectToServer');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.cannotConnectToServer;
  }
}

class _UserUnauthorizedException extends ErrorException {
  const _UserUnauthorizedException() : super('UserUnauthorized');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.userUnauthorized;
  }
}

class NoRefreshTokenFoundException extends ErrorException {
  const NoRefreshTokenFoundException() : super('NoRefreshTokenFound');
}

class EmailAlreadyRegisteredException extends ErrorException {
  const EmailAlreadyRegisteredException() : super('EmailAlreadyRegistered');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.emailAlreadyExists;
  }
}

class InvalidEmailCredentialException extends ErrorException {
  const InvalidEmailCredentialException() : super('InvalidEmailCredential');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.emailAddressNotFound;
  }
}

class InvalidPasswordCredentialException extends ErrorException {
  const InvalidPasswordCredentialException()
      : super('InvalidPasswordCredential');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.passwordIsIncorrect;
  }
}

class EmailUnauthorizedToRegisterException extends ErrorException {
  const EmailUnauthorizedToRegisterException()
      : super('EmailUnauthorizedToRegister');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.emailUnauthorizedToRegister;
  }
}

class InvalidApiRequestException extends ErrorException {
  const InvalidApiRequestException() : super('InvalidApiRequest');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.invalidApiRequest;
  }
}

class FailedToRefreshAuthTokensException extends ErrorException {
  const FailedToRefreshAuthTokensException()
      : super('FailedToRefreshAuthTokens');
  @override
  String getMessage(BuildContext context) {
    return context.localizations!.failedToAuthenticateUser;
  }
}
