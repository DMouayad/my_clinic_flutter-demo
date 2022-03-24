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

  Future<CustomResponse<NoResult>> signUp({
    required String emailAddress,
    required String username,
    required String password,
    required UserRole role,
  });

  Future<CustomResponse<NoResult>> addNewUserInfoByAdmin({
    required String emailAddress,
    required UserRole userRole,
  });
}
