part of auth_data;

class ParseAuthRepository extends BaseAuthRepository<CustomParseUser> {
  @override
  Future<void> init() async {
    currentUser = await ParseUser.currentUser(
      customUserObject: CustomParseUser.clone(),
    );
    print(currentUser);
  }

  @override
  Future<CustomResponse<NoResult>> login({
    required String username,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> addUserByAdmin({
    required String username,
    required String password,
    required String emailAddress,
    required String appUserId,
    required UserRole userRole,
  }) async {
    CustomParseUser user = CustomParseUser(
      username: username,
      password: password,
      emailAddress: emailAddress,
      appUserId: appUserId,
      role: userRole,
    );
    final signUpResponse = await user.signUp();
    return CustomResponse.fromParseResponse(
      signUpResponse,
      withResults: false,
    );
  }

  @override
  Future<CustomResponse<NoResult>> resetUserPassword(String emailAddress) {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  bool hasLoggedInUser() {
    return currentUser != null;
  }
}
