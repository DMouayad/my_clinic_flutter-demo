import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/app/core/entities/auth_tokens.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';

abstract class BaseRefreshTokensService {
  Future<Result<AuthTokens, BasicError>> refreshAuthTokens({
    required String refreshToken,
    required String deviceId,
  });
}

class RefreshTokensService extends BaseRefreshTokensService with DioHelper {
  @override
  Future<Result<AuthTokens, BasicError>> refreshAuthTokens({
    required String refreshToken,
    required String deviceId,
  }) async {
    final response = await requestApiEndpoint<RefreshAccessTokenEndpointResult>(
      ApiEndpoint.refreshAccessToken(
        refreshToken: refreshToken,
        deviceId: deviceId,
      ),
    );
    return response.when(
      onSuccess: (result) {
        return SuccessResult(result.authTokens);
      },
      onError: (error) => ErrorResult(
        error.copyWith(exception: const ErrorException.failedToRefreshTokens()),
      ),
    );
  }
}
