/// the exceptions which can be returned from the MyClinic API
enum ApiExceptionClass {
  userNotFound("UserNotFoundException"),
  deletingOnlyAdminStaffMember("DeletingOnlyAdminStaffMemberException"),
  emailAlreadyRegistered("EmailAlreadyRegisteredException"),
  roleNotFound("RoleNotFoundException"),
  staffMemberAlreadyExists("StaffMemberAlreadyExistsException"),
  userPreferencesAlreadyExists("StaffMemberAlreadyExistsException"),
  userDoesntMatchHisStaffMember("UserDoesntMatchHisStaffMemberException"),
  emailUnauthorizedToRegister("EmailUnauthorizedToRegisterException"),
  invalidEmailCredential("InvalidEmailCredentialException"),
  invalidPasswordCredential("InvalidPasswordCredentialException"),
  invalidRefreshToken("InvalidRefreshTokenException"),
  validationError("CustomValidationException");

  final String exceptionClass;

  const ApiExceptionClass(this.exceptionClass);
}
