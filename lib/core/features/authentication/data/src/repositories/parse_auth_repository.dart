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
  Future<CustomResponse<NoResult>> addNewUserInfoByAdmin({
    required String emailAddress,
    required UserRole userRole,
  }) async {
    throw UnimplementedError();
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

  @override
  Future<CustomResponse<NoResult>> signUp({
    required String emailAddress,
    required String username,
    required String password,
    required UserRole role,
  }) async {
    // final emailAddressIsValid =
    //     (await ParseServer.checkIfValidEmailAddress(emailAddress)).success;
    // if (emailAddressIsValid) {
    //   final userRole =
    //       (await ParseServer.getUserRole(emailAddress: emailAddress)).result;
    //   if (userRole != null) {}
    // CustomParseUser newUser = CustomParseUser();
    // } else {
    //   return CustomResponse.failure(
    //     errorMessage:
    //         '"$emailAddress" is not a valid email address!, please try again',
    //   );
    // }
    throw UnimplementedError();
  }
}
