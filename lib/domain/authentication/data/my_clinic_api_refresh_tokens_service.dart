import 'package:clinic_v2/api/endpoints/auth_endpoints.dart';
import 'package:clinic_v2/shared/models/auth_tokens.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

import '../base/base_refresh_auth_tokens_service.dart';

class MyClinicApiRefreshTokensService extends BaseRefreshAuthTokensService {
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
