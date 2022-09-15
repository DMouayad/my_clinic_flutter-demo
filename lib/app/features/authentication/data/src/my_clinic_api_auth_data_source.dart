import 'package:clinic_v2/api/endpoints/api_endpoints.dart';
import 'package:clinic_v2/api/errors/api_response_error.dart';
import 'package:clinic_v2/api/helpers/api_request_helper.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/api/utils/auth_tokens.dart';
import 'package:clinic_v2/app/core/entities/result/error_exception.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/data/src/my_clinic_api_user.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/app/features/authentication/domain/src/base_auth_data_source.dart';
import 'package:clinic_v2/app/features/user_preferences/data/src/my_clinic_api_user_preferences.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/src/base_user_preferences.dart';
import 'package:clinic_v2/app/services/auth_token/base_auth_token_provider.dart';

class MyClinicApiAuthDataSource
    with DioHelper, ApiRequestHelper
    implements BaseAuthDataSource {
  final BaseAuthTokensService _authTokensService;

  MyClinicApiAuthDataSource(this._authTokensService);

  @override
  Future<
      Result<ApiLoginResult<MyClinicApiUser, MyClinicApiUserPreferences>,
          BasicError>> login(
    String email,
    String password,
  ) async {
    final response = await requestApiEndpoint<LoginEndpointResult>(
      ApiEndpoint.login(email, password),
    );
    return response.when(
      onSuccess: (endpointResult) {
        // save returned auth tokens to storage
        _saveAuthTokens(endpointResult.authTokens);

        return SuccessResult(
          ApiLoginResult(
            user: MyClinicApiUser.fromApiResponseMap(
              endpointResult.userWithRoleMap,
            ),
            userPreferences: MyClinicApiUserPreferences.fromMap(
              endpointResult.userPreferencesMap,
            ),
          ),
        );
      },
      onError: (BasicError error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<MyClinicApiUser, BasicError>> register(
    String username,
    String email,
    String password,
  ) async {
    final response = await requestApiEndpoint<RegisterEndpointResult>(
      ApiEndpoint.register(username, email, password),
    );
    return response.when(
      onSuccess: (endpointResult) {
        _saveAuthTokens(endpointResult.authTokens);

        return SuccessResult(
          MyClinicApiUser.fromApiResponseMap(endpointResult.userWithRole),
        );
      },
      onError: (error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> logout() async {
    final token = await _authTokensService.getAccessToken();
    if (token == null) {
      return ErrorResult(TokenNotFoundError(_authTokensService.accessTokenKey));
    }
    final response = await requestApiEndpoint<LogoutEndpointResult>(
      ApiEndpoint.logout(token),
    );
    return response.when(
      onSuccess: (_) => SuccessResult.voidResult(),
      onError: (error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> requestPasswordReset(String email) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> sendVerificationEmail() async {
    throw UnimplementedError();
    // final token = await _authTokensService.getAccessToken();
    // if (token == null) {
    //   return ErrorResult(TokenNotFoundError(_authTokensService.accessTokenKey));
    // }
    // final response = await requestApiEndpoint(
    //   ApiEndpoint.requestEmailVerification(token),
    // );
    // return response.when(
    //   onSuccess: (_) => SuccessResult.voidResult(),
    //   onError: (error) => ErrorResult(error),
    // );
  }

  @override
  Future<Result<VoidResult, BasicError>> loadUser() {
    throw UnimplementedError();
  }

  Future<Result<String, BasicError>> _getValidAccessToken() async {
    final accessToken = await _authTokensService.getAccessToken();
    if (accessToken != null && !accessToken.isExpired) {
      return SuccessResult(accessToken.token);
    } else {
      final refreshToken = await _authTokensService.getRefreshToken();
      if (refreshToken != null) {
        return (await _refreshAuthTokens(refreshToken)).when(
          onSuccess: (result) => SuccessResult(result.accessToken.token),
          onError: (error) => ErrorResult(error),
        );
      } else {
        return ErrorResult.fromErrorException(
          ErrorException.noRefreshTokenFound(),
        );
      }
    }
  }

  Future<Result<AuthTokens, ApiResponseError>> _refreshAuthTokens(
    String refreshToken,
  ) async {
    final response = await requestApiEndpoint<RefreshAccessTokenEndpointResult>(
        ApiEndpoint.refreshAccessToken(refreshToken));
    return await response.whenAsync(
      onSuccess: (result) async {
        await _saveAuthTokens(result.authTokens);
        return SuccessResult(result.authTokens);
      },
      onError: (error) async => ErrorResult(error),
    );
  }

  Future<void> _saveAuthTokens(AuthTokens authTokens) async {
    await _authTokensService.saveRefreshToken(authTokens.refreshToken);
    await _authTokensService.saveAccessToken(authTokens.accessToken);
  }
}

class ApiLoginResult<U extends BaseServerUser, P extends BaseUserPreferences>
    extends ResultType {
  final U user;
  final P userPreferences;

  const ApiLoginResult({
    required this.user,
    required this.userPreferences,
  });
}
