/// List of the exceptions which can be returned from the MyClinic API
/// with an error response
enum ApiExceptionClass {
  userNotFound("UserNotFoundException"),
  cannotDeleteOnlyAdminStaffEmail("DeletingOnlyAdminStaffEmailException"),
  emailAlreadyRegistered("EmailAlreadyRegisteredException"),
  roleNotFound("RoleNotFoundException"),
  staffEmailAlreadyExists("StaffEmailAlreadyExistsException"),
  userPreferencesAlreadySaved("StaffEmailAlreadyExistsException"),
  userDataDoesntMatchHisStaffEmail("UserDoesntMatchHisStaffEmailException"),
  emailUnauthorizedToRegister("EmailUnauthorizedToRegisterException"),
  invalidEmailCredential("InvalidEmailCredentialException"),
  invalidPasswordCredential("InvalidPasswordCredentialException"),
  validationError("CustomValidationException");

  final String name;
  const ApiExceptionClass(this.name);
}
