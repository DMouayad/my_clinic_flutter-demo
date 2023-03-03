import 'dart:async';

import 'base_notification.dart';

abstract class BaseNotificationHandler {
  const BaseNotificationHandler();

  void call(
    StreamController<BaseNotification> notificationsController,
    String channel,
  );

  void dispose(String channel);
}
