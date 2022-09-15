/// List of the exceptions which can be returned from the MyClinic API
/// with an error response
enum ApiExceptionClass {
   userNotFound: "UserNotFoundException";
  static const cannotDeleteOnlyAdminStaffEmail =
      "DeletingOnlyAdminStaffEmailException";
  static const emailAlreadyRegistered = "EmailAlreadyRegisteredException";
  static const roleNotFound = "RoleNotFoundException";
  static const staffEmailAlreadyExists = "StaffEmailAlreadyExistsException";
  static const userPreferencesAlreadySaved = "StaffEmailAlreadyExistsException";
  static const userDataDoesntMatchHisStaffEmail =
      "UserDoesntMatchHisStaffEmailException";
}
