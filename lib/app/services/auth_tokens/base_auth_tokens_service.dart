import 'package:clinic_v2/app/core/entities/auth_tokens.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/services/logger_service.dart';

import 'refresh_tokens_service.dart';

/// Manages saving and retrieving auth tokens
/// alongside with refreshing the access token if needed
///
abstract class BaseAuthTokensService {
  /// The class responsible for implementing the access token refresh process
  final BaseRefreshTokensService refreshTokensService;

  BaseAuthTokensService(this.refreshTokensService);

  /// The key to be used in access token read/write/delete
  String get accessTokenKey => 'accessToken';

  /// The key to be used in refresh token read/write/delete
  String get refreshTokenKey => 'refreshToken';

  /// returns the access token associated with [accessTokenKey]
  Future<PersonalAccessToken?> getAccessToken();

  /// returns the refresh token associated with [refreshTokenKey]
  Future<String?> getRefreshToken();

  /// Save access token value
  Future<bool> saveAccessToken(PersonalAccessToken token) async {
    return (await getAccessToken()) == token;
  }

  /// Save refresh token value
  Future<bool> saveRefreshToken(String value) async {
    return (await getRefreshToken()) == value;
  }

  Future<bool> deleteAccessToken() async {
    return (await getAccessToken()) == null;
  }

  Future<bool> deleteRefreshToken() async {
    return (await getRefreshToken()) == null;
  }

  Future<void> saveAuthTokens(AuthTokens authTokens) async {
    await saveRefreshToken(authTokens.refreshToken);
    await saveAccessToken(authTokens.accessToken);
  }

  Future<Result<String, BasicError>> getValidAccessToken() async {
    final accessToken = await getAccessToken();
    if (accessToken != null) {
      // return the access token if was not expired
      if (!accessToken.isExpired) {
        Log.i(
            'A valid access token was found\nExpires at ${accessToken.expiresAt}');
        return SuccessResult(accessToken.token);
      } else {
        Log.i("An expired access token was found, trying to refresh it...");
        final refreshToken = await getRefreshToken();

        // if a refresh token found => request to refresh auth tokens
        if (refreshToken != null) {
          return (await refreshAuthTokens(refreshToken)).mapSuccess(
            (result) => result.accessToken.token,
          );
        } else {
          return FailureResult.fromErrorException(
            const ErrorException.noRefreshTokenFound(),
          );
        }
      }
    } else {
      return FailureResult.fromErrorException(
        const ErrorException.noAccessTokenFound(),
      );
    }
  }

  Future<Result<AuthTokens, BasicError>> refreshAuthTokens(
    String refreshToken,
  ) async {
    final refreshTokensResponse = await refreshTokensService.refreshAuthTokens(
      refreshToken: refreshToken,
    );
    return await refreshTokensResponse.foldAsync(
      ifSuccess: (tokens) async => await saveAuthTokens(tokens),
    );
  }
}

class TokenNotFoundError extends BasicError {
  final String tokenKey;

  TokenNotFoundError(this.tokenKey);

  @override
  String toString() {
    return 'Bearer token with key $tokenKey not found';
  }
}
