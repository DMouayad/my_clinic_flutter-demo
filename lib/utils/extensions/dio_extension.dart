import 'package:dio/dio.dart';

extension IsSuccess on Response {
  bool get isSuccess {
    if (statusCode != null) {
      return (statusCode! ~/ 100) == 2;
    }
    return false;
  }
}
