import 'package:clinic_v2/api/utils/auth_tokens.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';

abstract class BaseAuthTokensService {
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
}

class TokenNotFoundError extends BasicError {
  final String tokenKey;

  const TokenNotFoundError(this.tokenKey);

  @override
  String toString() {
    return 'Bearer token with key $tokenKey not found';
  }
}
