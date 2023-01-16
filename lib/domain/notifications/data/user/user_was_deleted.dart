import 'package:clinic_v2/utils/extensions/map_extensions.dart';

import '../../base/base_notification.dart';

class CurrentUserWasDeletedNotification extends BaseNotification {
  final int userId;
  final DateTime? deletedAt;

  const CurrentUserWasDeletedNotification({
    required this.userId,
    required this.deletedAt,
  });

  factory CurrentUserWasDeletedNotification.fromMap(Map<String, dynamic> map) {
    return CurrentUserWasDeletedNotification(
      userId: map['user_id'] as int,
      deletedAt: DateTime.tryParse(map.get('deleted_at')),
    );
  }
}
