import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/data/auth_data.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/app/services/auth_token/base_auth_token_provider.dart';

class MyClinicApiAuthRepository extends BaseAuthRepository<MyClinicApiUser> {
  late final MyClinicApiAuthDataSource _dataSource;

  MyClinicApiAuthRepository(BaseAuthTokensService authTokenProvider) {
    _dataSource = MyClinicApiAuthDataSource(authTokenProvider);
  }
  MyClinicApiUser? _currentUser;
  @override
  void setCurrentUser(MyClinicApiUser user) {
    _currentUser = user;
  }

  @override
  Stream<bool> get hasLoggedInUser => throw UnimplementedError();
  @override
  Future<Result<AuthRepoLoginResult, BasicError>> login({
    required String email,
    required String password,
  }) async {
    // login user with email and password
    final result = await _dataSource.login(email, password);

    return result.when(
      onSuccess: (result) {
        // set returned user as the current user
        setCurrentUser(result.user);
        return SuccessResult(
          AuthRepoLoginResult(_currentUser!, result.userPreferences),
        );
      },
      onError: (error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> register({
    required String email,
    required String name,
    required String password,
  }) async {
    // login user with email and password
    final result = await _dataSource.register(name, email, password);

    return result.when(
      onSuccess: (result) {
        // set current user to the retrieved user
        setCurrentUser(result);
        return SuccessResult.voidResult();
      },
      onError: (error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> logout() async {
    final result = await _dataSource.logout();
    return result.when(
      onSuccess: (_) => SuccessResult.voidResult(),
      onError: (error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> requestPasswordReset(
      String emailAddress) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> requestVerificationEmail() async {
    final result = await _dataSource.sendVerificationEmail();
    return result.when(
      onSuccess: (_) => SuccessResult.voidResult(),
      onError: (error) => ErrorResult(error),
    );
  }

  @override
  Future onInit() async {
    return await _dataSource.loadUser();
  }
}
