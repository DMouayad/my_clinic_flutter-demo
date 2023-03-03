import 'dart:async';

import 'base_notification.dart';
import 'base_notification_handler.dart';

abstract class BaseNotificationsListener<T extends BaseNotification,
    H extends BaseNotificationHandler> {
  late final StreamController<T> _notificationsController;

  StreamController<T> get notificationsController => _notificationsController;

  Stream<T> get notifications => _notificationsController.stream;

  Future<void> ensureInitialized() async {
    if (!_initialized) {
      _notificationsController = StreamController();
      _initialized = true;
    }
  }

  bool _initialized = false;

  bool get wasInitialized => _initialized;

  bool get isListening;

  Future<void> registerHandlers(List<H> handlers, String channel) async {
    for (var handler in handlers) {
      handler.call(notificationsController, channel);
    }
  }

  Future<void> unRegisterHandlers(List<H> handlers, String channel) async {
    for (var handler in handlers) {
      handler.dispose(channel);
    }
  }

  Future<void> listenOnChannel(String channel);

  Future<void> dispose();
}
