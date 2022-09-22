import 'package:clinic_v2/api/endpoints/api_endpoint.dart';
import 'package:clinic_v2/app/core/extensions/dio_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class Log {
  late Logger _logger;

  Log._internal() {
    _logger = Logger();
  }

  static Logger to = _instance._logger;

  factory Log() => _instance;

  static final Log _instance = Log._internal();

  static void v(dynamic message) {
    to.v(message);
  }

  static void d(dynamic message) {
    to.d(message);
  }

  static void i(dynamic message) {
    to.i(message);
  }

  static void w(dynamic message) {
    to.w(message);
  }

  static void e(dynamic message) {
    to.e(message);
  }

  static void wtf(dynamic message) {
    to.wtf(message);
  }

  static void logBlocTransition(Bloc bloc, Transition transition) {
    to.i('''<${bloc.runtimeType} transition>
        From:  ${transition.currentState}
        To:    ${transition.nextState}
        After: ${transition.event.runtimeType}
      ''');
  }

  static void logDioApiEndpointRequest(
    ApiEndpoint apiEndpoint,
    Response response,
  ) {
    to.i('''<Dio request>
        method:  ${apiEndpoint.method}              
        uri:     ${response.realUri}
        success: ${response.isSuccess}
        status:  ${response.statusCode}
      ''');
  }
}
