import 'refresh_tokens_service.dart';
import 'base_auth_tokens_service.dart';
import 'secure_storage_auth_token_provider.dart';

class AuthTokensServiceProvider {
  AuthTokensServiceProvider._() {
    _service = SecureStorageAuthTokensService(RefreshTokensService());
  }

  late final BaseAuthTokensService _service;
  BaseAuthTokensService get service => _service;
  static AuthTokensServiceProvider get instance {
    _instance ??= AuthTokensServiceProvider._();

    return _instance!;
  }

  static AuthTokensServiceProvider? _instance;
}
