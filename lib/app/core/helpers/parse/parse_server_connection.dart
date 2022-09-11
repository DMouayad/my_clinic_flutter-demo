import 'dart:async';
import 'dart:io';

import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

/// Initialize the [Parse] server
class ParseServerConnection {
  static const _appID = 'v4pEePO9kYDmIrY5eG5tZV4MvbvuBIjeXl4Ut577';
  static const _serverURL = 'https://parseapi.back4app.com';
  static const _liveQueryUrl = 'wss://clinic.b4a.io';
  static const _clientKey = 'bVQHLTM3Vrmxt8kIdp3vM3KxFsIytLpSP6oqSsOp';

  static bool _serverIsInitialized = false;
  static bool get isInitialized => _serverIsInitialized;

  static Future<Result<bool, BaseError>> init() async {
    try {
      final hasInternetConnection =
          (await Parse().checkConnectivity()) != ParseConnectivityResult.none;
      if (hasInternetConnection) {
        await Parse().initialize(
          _appID,
          _serverURL,
          clientKey: _clientKey,
          liveQueryUrl: _liveQueryUrl,
          debug: true,
          autoSendSessionId: true,
        );
        final parseHealthCheck =
            await Parse().healthCheck().timeout(const Duration(seconds: 30));
        _serverIsInitialized = parseHealthCheck.success;
        return SuccessResult(parseHealthCheck.success);
      } else {
        throw const SocketException('No Internet Connection!');
      }
    } on SocketException catch (_) {
      return ErrorResult.noInternetConnection();
    } on ParseError catch (e) {
      return ErrorResult.withParseError(e);
    } on TimeoutException catch (_) {
      return ErrorResult.cannotConnectToServer();
    } catch (e) {
      return ErrorResult.withException(e);
    }
  }
}
