import 'dart:async';

import 'base_notification.dart';

abstract class BaseNotificationHandler<T extends BaseNotification> {
  const BaseNotificationHandler();

  void call(StreamController<T> notificationsController);

  void dispose();
}
