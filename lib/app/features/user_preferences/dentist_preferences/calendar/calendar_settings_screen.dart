import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/core/common/models/dentist_calendar.dart';

import 'components/shifts/shifts_settings_card.dart';
import 'components/work_days_card.dart';

class CalendarSettingsScreen extends StatefulWidget {
  const CalendarSettingsScreen({
    required this.onCalendarUpdated,
    required this.currentCalendar,
    Key? key,
  }) : super(key: key);
  final void Function(DentistCalendar userCalendar) onCalendarUpdated;
  final DentistCalendar currentCalendar;

  @override
  State<CalendarSettingsScreen> createState() => _CalendarSettingsScreenState();
}

class _CalendarSettingsScreenState
    extends StateWithResponsiveBuilder<CalendarSettingsScreen> {
  late DentistCalendar dentistCalendar;

  @override
  void initState() {
    dentistCalendar = widget.currentCalendar;
    super.initState();
  }

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return Material(
      type: MaterialType.canvas,
      color: context.colorScheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          children: [
            ShiftsSettingsCard(
              workShifts: dentistCalendar.workShifts,
              onShiftsChanged: (newShifts) {
                setState(
                  () => dentistCalendar =
                      dentistCalendar.copyWith(workShifts: newShifts),
                );
                widget.onCalendarUpdated(dentistCalendar);
              },
            ),
            WorkDaysCard(),
          ],
        ),
      ),
    );
  }
}
