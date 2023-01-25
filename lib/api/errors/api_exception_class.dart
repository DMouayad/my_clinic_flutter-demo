/// the exceptions which can be returned from the MyClinic API
enum ApiExceptionClass {
  userNotFound("UserNotFoundException"),
  cannotDeleteOnlyAdminStaffMember("DeletingOnlyAdminStaffMemberException"),
  emailAlreadyRegistered("EmailAlreadyRegisteredException"),
  roleNotFound("RoleNotFoundException"),
  staffMemberAlreadyExists("StaffMemberAlreadyExistsException"),
  userPreferencesAlreadySaved("StaffMemberAlreadyExistsException"),
  userDataDoesntMatchHisStaffMember("UserDoesntMatchHisStaffMemberException"),
  emailUnauthorizedToRegister("EmailUnauthorizedToRegisterException"),
  invalidEmailCredential("InvalidEmailCredentialException"),
  invalidPasswordCredential("InvalidPasswordCredentialException"),
  invalidRefreshToken("InvalidRefreshTokenException"),
  validationError("CustomValidationException");

  final String name;

  const ApiExceptionClass(this.name);
}
