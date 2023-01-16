import 'package:clinic_v2/shared/models/auth_tokens.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

abstract class BaseRefreshAuthTokensService {
  Future<Result<AuthTokens, BasicError>> refreshAuthTokens({
    required String refreshToken,
  });
}
