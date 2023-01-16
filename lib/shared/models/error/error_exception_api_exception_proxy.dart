import 'package:clinic_v2/api/errors/api_exception_class.dart';

import 'error_exception.dart';

mixin ApiExceptionClassProxy {
  static toErrorException(ApiExceptionClass apiExceptionClass) {
    switch (apiExceptionClass) {
      case ApiExceptionClass.emailAlreadyRegistered:
        return const ErrorException.emailAlreadyRegistered();

      case ApiExceptionClass.cannotDeleteOnlyAdminStaffMember:
        return ErrorException.deletingOnlyAdminStaffMember();

      case ApiExceptionClass.roleNotFound:
        return ErrorException.roleNotFound();
      case ApiExceptionClass.staffMemberAlreadyExists:
        return ErrorException.staffMemberAlreadyExists();
      case ApiExceptionClass.userPreferencesAlreadySaved:
        return ErrorException.userPreferencesAlreadyExists();

      case ApiExceptionClass.userDataDoesntMatchHisStaffMember:
        return ErrorException.userDoesntMatchHisStaffMember();

      case ApiExceptionClass.emailUnauthorizedToRegister:
        return const ErrorException.emailUnauthorizedToRegister();

      case ApiExceptionClass.invalidEmailCredential:
        return const ErrorException.invalidEmailCredential();

      case ApiExceptionClass.invalidPasswordCredential:
        return const ErrorException.invalidPasswordCredential();
      case ApiExceptionClass.validationError:
        return const ErrorException.invalidApiRequest();

      default:
        return ErrorException(apiExceptionClass.name);
    }
  }
}
