import 'dart:async';

import 'package:clinic_v2/app/core/entities/result/result.dart';

abstract class BaseStartupService {
  bool shouldRetryToInit = true;
  Stream<Result>? onStartupStatusChanged;
  StreamController<Result>? _startupStatusStreamController;
  Future<Result<VoidResult, BasicError>?> init() async {
    if (shouldRetryToInit) {
      _startupStatusStreamController = StreamController<Result>();
      onStartupStatusChanged = _startupStatusStreamController!.stream;
    }
  }

  void retryToInit();
  void addStartupStreamEvent(Result event) {
    _startupStatusStreamController?.sink.add(event);
  }

  void addStartupStreamError(ErrorResult errorResult) {
    _startupStatusStreamController?.sink.addError(errorResult);
  }
}
