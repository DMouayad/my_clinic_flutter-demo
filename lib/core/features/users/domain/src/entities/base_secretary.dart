import 'package:clinic_v2/core/common/models/dentist_calendar.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
import 'package:clinic_v2/core/features/users/domain/src/entities/base_app_user.dart';

abstract class BaseSecretary extends BaseAppUser {
  BaseSecretary({
    required String id,
    required DentistCalendar userCalendar,
  }) : super(
          id: id,
          role: UserRole.secretary,
          userCalendar: userCalendar,
        );
}
