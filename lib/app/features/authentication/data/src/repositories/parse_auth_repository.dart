part of auth_data;

class ParseAuthRepository extends BaseAuthRepository<CustomParseUser> {
  @override
  Future<Result<None>> login({
    required String username,
    // required String email,
    required String password,
  }) async {
    if ((await Parse().checkConnectivity()) != ParseConnectivityResult.none) {
      final response = await ParseUser.createUser(username, password).login();
      if (response.success) {
        print(CustomParseUser.fromParseUser(response.results?.first));

        // print(response.results);
        // currentUser = CustomParseUser.fromJson(response.);
        return SuccessResult();
      }
      return Result.failure(
          errorMessage: response.error?.message ?? 'Login failed');
    } else {
      return Result.internetConnectionError();
    }
  }

  @override
  Future<Result<None>> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> addNewUserInfoByAdmin({
    required String emailAddress,
    required UserRole userRole,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> resetUserPassword(String emailAddress) {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  bool hasLoggedInUser() {
    return currentUser != null;
  }

  @override
  Future<Result<None>> loadCurrentUser() async {
    try {
      currentUser = await ParseUser.currentUser(
          customUserObject: CustomParseUser.clone());
      return SuccessResult();
    } catch (e) {
      return Result.failure(errorMessage: 'Error getting stored user');
    }
  }

  @override
  Future<Result<None>> signUp({
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
    //   return Result.failure(
    //     errorMessage:
    //         '"$emailAddress" is not a valid email address!, please try again',
    //   );
    // }
    throw UnimplementedError();
  }
}
