import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/data/auth_data.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/app/services/auth_token/base_auth_token_provider.dart';

class MyClinicApiAuthRepository implements BaseAuthRepository<MyClinicApiUser> {
  late final MyClinicApiAuthDataSource _dataSource;

  MyClinicApiAuthRepository(BaseAuthTokensService authTokenProvider) {
    _dataSource = MyClinicApiAuthDataSource(authTokenProvider);
  }

  @override
  MyClinicApiUser? currentUser;
  @override
  void setCurrentUser(MyClinicApiUser user) {
    currentUser = user;
  }

  @override
  Stream<bool> get hasLoggedInUser => throw UnimplementedError();
  @override
  Future<Result<MyClinicApiUser, BasicError>> login({
    required String email,
    required String password,
  }) async {
    // login user with email and password
    final loginResult = await _dataSource.login(email, password);

    return loginResult.when(
      onSuccess: (result) {
        // set returned user as the current user
        setCurrentUser(result);
        return SuccessResult(currentUser!);
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
    return (await _dataSource.register(name, email, password)).when(
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
    return await _dataSource.logout();
  }

  @override
  Future<Result<VoidResult, BasicError>> requestPasswordReset(
      String emailAddress) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> requestVerificationEmail() async {
    return await _dataSource.sendVerificationEmail();
  }

  @override
  Future<Result<MyClinicApiUser, BasicError>> onInit() async {
    return (await _dataSource.loadUser()).when(
      onSuccess: (result) {
        currentUser = result;
        return SuccessResult(result);
      },
      onError: (error) => ErrorResult(error),
    );
  }
}
