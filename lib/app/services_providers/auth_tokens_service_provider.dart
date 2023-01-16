import 'package:clinic_v2/domain/authentication/base/base_auth_tokens_service.dart';

import '../../../domain/authentication/data/my_clinic_api_refresh_tokens_service.dart';
import '../../domain/authentication/data/secure_storage_auth_tokens_service.dart';

class AuthTokensServiceProvider {
  AuthTokensServiceProvider._() {
    _service =
        SecureStorageAuthTokensService(MyClinicApiRefreshTokensService());
  }

  late final BaseAuthTokensService _service;
  BaseAuthTokensService get service => _service;
  static AuthTokensServiceProvider get instance {
    _instance ??= AuthTokensServiceProvider._();

    return _instance!;
  }

  static AuthTokensServiceProvider? _instance;
}
