import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/services/startup/base_startup_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStartupService extends BaseStartupService {
  @override
  Future<Result<VoidResult, BasicError>> init() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (shouldRetryToInit) retryToInit();
      return ErrorResult.fromErrorException(ErrorException.noConnectionFound());
    }
    return SuccessResult.voidResult();
  }

  @override
  void retryToInit() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        addStartupStreamEvent(
          ErrorResult.fromErrorException(ErrorException.noConnectionFound()),
        );
      } else {
        addStartupStreamEvent(SuccessResult.voidResult());
      }
    });
  }
}
