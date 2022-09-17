import 'package:clinic_v2/app/services/auth_token/secure_storage_auth_token_provider.dart';

import 'base_auth_token_provider.dart';

class AuthTokenServiceProvider {
  AuthTokenServiceProvider._() {
    _service = SecureStorageAuthTokensService();
  }

  // static AuthTokenServiceProvider init(BaseAuthTokensService service) {
  //   return AuthTokenServiceProvider._(service);
  // }

  late final BaseAuthTokensService _service;
  BaseAuthTokensService get service => _service;
  static AuthTokenServiceProvider get instance {
    _instance ??= AuthTokenServiceProvider._();

    return _instance!;
  }

  static AuthTokenServiceProvider? _instance;
}
