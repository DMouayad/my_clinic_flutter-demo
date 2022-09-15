import 'package:clinic_v2/api/utils/auth_tokens.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'base_auth_token_provider.dart';

class SecureStorageAuthTokensService extends BaseAuthTokensService {
  final _storage = const FlutterSecureStorage();

  @override
  Future<PersonalAccessToken?> getAccessToken() async {
    final storedTokenJson = await _storage.read(key: accessTokenKey);
    if (storedTokenJson != null) {
      return PersonalAccessToken.fromJson(storedTokenJson);
    }
    return null;
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: refreshTokenKey);
  }

  @override
  Future<bool> deleteAccessToken() async {
    await _storage.delete(key: accessTokenKey);
    return super.deleteAccessToken();
  }

  @override
  Future<bool> deleteRefreshToken() async {
    await _storage.delete(key: refreshTokenKey);
    return super.deleteRefreshToken();
  }

  @override
  Future<bool> saveRefreshToken(String value) async {
    await _storage.write(key: refreshTokenKey, value: value);
    return super.saveRefreshToken(value);
  }

  @override
  Future<bool> saveAccessToken(PersonalAccessToken token) async {
    await _storage.write(key: accessTokenKey, value: token.toJson());
    return super.saveAccessToken(token);
  }
}
