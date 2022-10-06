import 'package:clinic_v2/api/endpoints/auth_endpoints.dart';
import 'package:clinic_v2/app/core/entities/auth_tokens.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';

abstract class BaseRefreshTokensService {
  Future<Result<AuthTokens, BasicError>> refreshAuthTokens({
    required String refreshToken,
  });
}

class RefreshTokensService extends BaseRefreshTokensService {
  @override
  Future<Result<AuthTokens, BasicError>> refreshAuthTokens({
    required String refreshToken,
  }) async {
    final response = await RefreshAccessTokenEndpoint(
      refreshToken: refreshToken,
    ).request();

    return response.map(
      onSuccess: (result) => result.authTokens,
      onFailure: (error) => error.copyWith(
        exception: const ErrorException.failedToRefreshTokens(),
      ),
    );
  }
}
