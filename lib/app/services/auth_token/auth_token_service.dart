import 'package:clinic_v2/app/services/auth_token/secure_storage_auth_token_provider.dart';

import 'base_auth_token_provider.dart';

class AuthTokenServiceProvider {
  AuthTokenServiceProvider._() {
    // initialize service instance
    service = SecureStorageAuthTokensService();
  }

  late final BaseAuthTokensService service;
  static AuthTokenServiceProvider instance = AuthTokenServiceProvider._();
}
