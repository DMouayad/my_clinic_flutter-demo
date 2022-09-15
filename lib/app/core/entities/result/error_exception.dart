import 'package:clinic_v2/api/errors/api_exception_class.dart';

class ErrorException {
  const ErrorException(this.name);
  final String name;

  factory ErrorException.noConnectionFound() {
    return const ErrorException('NoInternetConnectionFound');
  }
  factory ErrorException.cannotConnectToServer() {
    return const ErrorException('CannotConnectToServer');
  }
  factory ErrorException.userUnauthorized() {
    return const ErrorException('UserUnauthorized');
  }
  factory ErrorException.noRefreshTokenFound() {
    return const ErrorException('NoRefreshTokenFound');
  }
  factory ErrorException.noRefreshTokenFound() {
    return const ErrorException('NoRefreshTokenFound');
  }
  factory ErrorException.fromApiException(ApiExceptionClass apiExceptionClass) {
    switch (apiExceptionClass) {
    }
  }
  @override
  String toString() {
    return 'ErrorException{name: $name}';
  }
}
