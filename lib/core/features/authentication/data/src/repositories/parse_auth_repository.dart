part of auth_data;

class ParseAuthRepository extends BaseAuthRepository<CustomParseUser> {
  @override
  Future<CustomResponse<NoResult>> login({
    required String username,
    // required String email,
    required String password,
  }) async {
    final response = await ParseUser.createUser(username, password).login();
    if (response.success) {
      print(CustomParseUser.fromParseUser(response.results?.first));

      // print(response.results);
      // currentUser = CustomParseUser.fromJson(response.);
      return CustomResponse.success();
    }
    return CustomResponse.failure(
        errorMessage: response.error?.message ?? 'Login failed');
    // CustomParseUser.
    // CustomParseUser( username: username, emailAddress: emailAddress)
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
    required UserRole userRole,
  }) async {
    CustomParseUser user = CustomParseUser(
      username: username,
      password: password,
      emailAddress: emailAddress,
      appUserId: 'NOT SPECIFIED YET',
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

  @override
  Future<CustomResponse<NoResult>> loadCurrentUser() async {
    try {
      currentUser = await ParseUser.currentUser(
          customUserObject: CustomParseUser.clone());
      return CustomResponse.success();
    } catch (e) {
      return CustomResponse.failure(errorMessage: 'Error getting stored user');
    }
  }
}
