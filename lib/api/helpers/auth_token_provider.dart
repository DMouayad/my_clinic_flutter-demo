import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BaseAuthTokenProvider {
  String get tokenKey;

  /// returns the token associated with the token key
  Future<Result<String, BaseError>> getToken();

  /// Save token value
  Future<Result<VoidResult, BaseError>> saveToken(String value);
  Future<Result<VoidResult, BaseError>> deleteToken();
}

class SecureStorageAuthTokenProvider implements BaseAuthTokenProvider {
  // Create storage
  final storage = const FlutterSecureStorage();

  @override
  String get tokenKey => 'token';

  @override
  Future<Result<String, BaseError>> getToken() async {
    final token = await storage.read(key: tokenKey);
    if (token != null) {
      return SuccessResult(token);
    } else {
      return ErrorResult.withMessage('Token not found where key is $tokenKey');
    }
  }

  @override
  Future<Result<VoidResult, BaseError>> deleteToken() async {
    await storage.delete(key: tokenKey);
    return SuccessResult.voidResult();
  }

  @override
  Future<Result<VoidResult, BaseError>> saveToken(String value) async {
    await storage.write(key: tokenKey, value: value);
    return SuccessResult.voidResult();
  }
}
