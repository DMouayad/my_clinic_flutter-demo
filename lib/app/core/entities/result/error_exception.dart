import 'package:clinic_v2/api/errors/api_exception_class.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ErrorException extends Equatable {
  const ErrorException(this.name);
  final String name;
  String? getMessage(BuildContext context) => null;

  factory ErrorException.noConnectionFound() = NoConnectionFoundException;
  factory ErrorException.cannotConnectToServer() =
      CannotConnectToServerException;
  factory ErrorException.userUnauthorized() = _UserUnauthorizedException;
  factory ErrorException.noRefreshTokenFound() = _NoRefreshTokenFoundException;
  factory ErrorException.emailAlreadyRegistered() =
      EmailAlreadyRegisteredException;
  factory ErrorException.invalidEmailCredential() =
      InvalidEmailCredentialException;
  factory ErrorException.invalidPasswordCredential() =
      InvalidPasswordCredentialException;
  factory ErrorException.emailUnauthorizedToRegister() =
      EmailUnauthorizedToRegisterException;

  factory ErrorException.deletingOnlyAdminStaffEmail() {
    return const ErrorException('DeletingOnlyAdminStaffEmail');
  }

  factory ErrorException.roleNotFound() {
    return const ErrorException('RoleNotFound');
  }
  factory ErrorException.staffEmailAlreadyExists() {
    return const ErrorException('StaffEmailAlreadyExists');
  }

  factory ErrorException.userPreferencesAlreadyExists() {
    return const ErrorException('UserPreferencesAlreadyExists');
  }
  factory ErrorException.userDoesntMatchHisStaffEmail() {
    return const ErrorException('UserDoesntMatchHisStaffEmail');
  }

  factory ErrorException.fromApiException(ApiExceptionClass apiExceptionClass) {
    switch (apiExceptionClass) {
      case ApiExceptionClass.emailAlreadyRegistered:
        return ErrorException.emailAlreadyRegistered();

      case ApiExceptionClass.cannotDeleteOnlyAdminStaffEmail:
        return ErrorException.deletingOnlyAdminStaffEmail();

      case ApiExceptionClass.roleNotFound:
        return ErrorException.roleNotFound();
      case ApiExceptionClass.staffEmailAlreadyExists:
        return ErrorException.staffEmailAlreadyExists();
      case ApiExceptionClass.userPreferencesAlreadySaved:
        return ErrorException.userPreferencesAlreadyExists();

      case ApiExceptionClass.userDataDoesntMatchHisStaffEmail:
        return ErrorException.userDoesntMatchHisStaffEmail();

      case ApiExceptionClass.emailUnauthorizedToRegister:
        return ErrorException.emailUnauthorizedToRegister();

      case ApiExceptionClass.invalidEmailCredential:
        return ErrorException.invalidEmailCredential();

      case ApiExceptionClass.invalidPasswordCredential:
        return ErrorException.invalidPasswordCredential();

      default:
        return ErrorException(apiExceptionClass.name);
    }
  }
  @override
  String toString() {
    return 'ErrorException{name: $name}';
  }

  @override
  List<Object?> get props => [name];
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

class _NoRefreshTokenFoundException extends ErrorException {
  const _NoRefreshTokenFoundException() : super('NoRefreshTokenFound');
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
