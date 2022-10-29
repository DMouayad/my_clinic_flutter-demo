import 'dart:async';

abstract class BaseNotificationListener<T extends Object> {
  late final StreamController<T> _notificationsController;
  StreamController<T> get notificationsController => _notificationsController;
  Stream<T> get notifications => _notificationsController.stream;

  Future<void> init() async {
    _notificationsController = StreamController();
  }

  bool get isListening;
  Future<void> startListening();
  Future<void> stopListening();
  Future<void> dispose();
}
