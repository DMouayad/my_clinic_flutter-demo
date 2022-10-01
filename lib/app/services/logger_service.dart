export 'package:logger/logger.dart' show Level;

import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/app/core/extensions/dio_extension.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class Log {
  late Logger _logger;

  Log._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        errorMethodCount: 3,
        printEmojis: true,
        methodCount: 0,
      ),
    );
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

  /// Logs a [Cubit]'s state changes
  static void logCubitChange(
    Cubit cubit,
    Change change, {
    Level logLevel = Level.info,
  }) {
    final message = '''<${cubit.runtimeType} State Change>
        From:  ${change.currentState}
        To:    ${change.nextState}
      ''';
    _logByLevel(logLevel, message);
  }

  /// Logs a [Bloc] state transition, from a state to another, caused by an Event
  static void logBlocTransition(Bloc bloc, Transition transition) {
    final message = '''<${bloc.runtimeType} transition>
        From:  ${transition.currentState}   
        To:    ${transition.nextState}     
        After: ${transition.event.runtimeType}
      ''';
    to.i(message);
  }

  static void logApiEndpointRequest(ApiEndpoint apiEndpoint) {
    to.i('${apiEndpoint.runtimeType} was requested');
  }

  static void logDioRequest(dio.Dio dio, ApiEndpoint endpoint) {
    final headersIncludeToken =
        dio.options.headers.containsKey('Authorization');

    if (!headersIncludeToken && endpoint.includeAccessToken) {
      to.w(
        '${endpoint.runtimeType} requires an auth token to be '
        'included but was not present inside the request headers',
      );
    }
    final acceptsJson = dio.options.headers.containsValue('application/json');
    to.i('''<Dio Request>
        <baseUrl: ${dio.options.baseUrl}>   <endpoint: ${endpoint.url}>              
        <method: ${dio.options.method}>   <includes token: $headersIncludeToken>   <accepts json: $acceptsJson>
      ''');
  }

  static void logDioResponse(dio.Response response) {
    to.i('''<Dio Request>
        <requested uri: ${response.realUri}>
        <status: ${response.statusCode}>   <success: ${response.isSuccess}>
      ''');
  }

  static void _logByLevel(Level logLevel, String message) {
    switch (logLevel) {
      case Level.info:
        to.i(message);
        break;
      case Level.warning:
        to.w(message);
        break;

      case Level.error:
        to.e(message);
        break;
      default:
        throw UnimplementedError();
    }
  }
}
