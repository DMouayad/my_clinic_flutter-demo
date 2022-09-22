import 'package:clinic_v2/app/services/auth_token/secure_storage_auth_token_provider.dart';

import 'base_auth_token_provider.dart';

class AuthTokensServiceProvider {
  AuthTokensServiceProvider._() {
    _service = SecureStorageAuthTokensService();
  }

  late final BaseAuthTokensService _service;
  BaseAuthTokensService get service => _service;
  static AuthTokensServiceProvider get instance {
    _instance ??= AuthTokensServiceProvider._();

    return _instance!;
  }

  static AuthTokensServiceProvider? _instance;
}
