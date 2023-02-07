import 'dart:async';

import 'package:clinic_v2/shared/models/result/result.dart';

abstract class BaseStartupService {
  BaseStartupService() {
    if (shouldRetryToInit) {
      _startupStatusStreamController = StreamController<Result>();
    }
  }
  bool shouldRetryToInit = true;
  Stream<Result>? get startupResultStream =>
      _startupStatusStreamController?.stream;
  late final StreamController<Result>? _startupStatusStreamController;

  /// Performs initialization logic
  ///
  Future<Result<VoidValue, AppError>?> init();

  void retryToInit();
  void addStartupStreamEvent(Result event) {
    _startupStatusStreamController?.add(event);
  }

  void addStartupStreamError(FailureResult errorResult) {
    _startupStatusStreamController?.add(errorResult);
  }
}
