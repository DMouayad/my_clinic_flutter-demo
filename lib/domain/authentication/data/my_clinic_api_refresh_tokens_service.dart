import 'package:clinic_v2/api/endpoints/auth_endpoints.dart';
import 'package:clinic_v2/shared/models/auth_tokens.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

import '../base/base_refresh_auth_tokens_service.dart';

class ApiRefreshTokensService extends BaseRefreshAuthTokensService {
  @override
  Future<Result<AuthTokens, AppError>> refreshAuthTokens({
    required String refreshToken,
  }) async {
    final response = await RefreshAccessTokenEndpoint(
      refreshToken: refreshToken,
    ).request();

    return response.map(
      onSuccess: (result) => result.authTokens,
      onFailure: (error) => error.copyWith(
        appException: error.appException ?? AppException.failedToRefreshTokens,
      ),
    );
  }
}
