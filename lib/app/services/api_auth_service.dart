import 'package:clinic_v2/api/helpers/auth_token_provider.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';

class ApiAuthService with DioHelper {
  @override
  BaseAuthTokenProvider tokenProvider = SecureStorageAuthTokenProvider();
}
