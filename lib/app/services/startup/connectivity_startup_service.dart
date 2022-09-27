import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/services/startup/base_startup_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStartupService extends BaseStartupService {
  @override
  Future<Result<VoidValue, BasicError>> init() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (shouldRetryToInit) retryToInit();
      return FailureResult.fromErrorException(
          const ErrorException.noConnectionFound());
    }
    return SuccessResult.voidResult();
  }

  @override
  void retryToInit() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        addStartupStreamEvent(
          FailureResult.fromErrorException(
              const ErrorException.noConnectionFound()),
        );
      } else {
        addStartupStreamEvent(SuccessResult.voidResult());
      }
    });
  }
}
