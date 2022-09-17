import 'package:clinic_v2/api/errors/api_exception_class.dart';

class ErrorException {
  const ErrorException(this.name);
  final String name;

  factory ErrorException.noConnectionFound() {
    return const ErrorException('NoInternetConnectionFound');
  }
  factory ErrorException.cannotConnectToServer() {
    return const ErrorException('CannotConnectToServer');
  }
  factory ErrorException.userUnauthorized() {
    return const ErrorException('UserUnauthorized');
  }
  factory ErrorException.noRefreshTokenFound() {
    return const ErrorException('NoRefreshTokenFound');
  }
  factory ErrorException.emailAlreadyRegistered() {
    return const ErrorException('EmailAlreadyRegistered');
  }
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

  factory ErrorException.invalidEmailCredential() {
    return const ErrorException('InvalidEmailCredential');
  }
  factory ErrorException.invalidPasswordCredential() {
    return const ErrorException('InvalidPasswordCredential');
  }
  factory ErrorException.emailUnauthorizedToRegister() {
    return const ErrorException('EmailUnauthorizedToRegister');
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
}
