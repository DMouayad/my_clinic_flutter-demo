part of auth_domain;

abstract class BaseAuthRepository<T extends BaseServerUser> {
  Future<bool> init() async => true;
  Future<CustomResponse<NoResult>> loadCurrentUser();
  T? currentUser;
  bool hasLoggedInUser();
  Future<CustomResponse<NoResult>> resetUserPassword(String emailAddress);
  Future<CustomResponse<NoResult>> logoutUser();
  Future<CustomResponse<NoResult>> login({
    required String username,
    required String password,
  });

  /// [appUserId] is the ID that references the app user which is saved in the local and
  /// remote databases.
  ///
  /// [appUserId] should be the primary key in a SQL DB.
  Future<CustomResponse<NoResult>> addUserByAdmin({
    required String username,
    required String password,
    required String emailAddress,
    required UserRole userRole,
  });
}
