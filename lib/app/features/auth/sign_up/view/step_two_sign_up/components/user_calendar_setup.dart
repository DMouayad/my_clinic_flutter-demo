import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/core/common/models/user_calendar.dart';

class UserCalendarSettings extends ResponsiveScreen {
  const UserCalendarSettings({required this.onUserCalendarChange, Key? key})
      : super(key: key);
  final void Function(UserCalendar userCalendar) onUserCalendarChange;

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return Container();
  }
}
