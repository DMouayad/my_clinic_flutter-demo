import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/section_card.dart';

import 'clinic_holidays_card.dart';
import 'shifts/work_shifts_card.dart';

class CalendarSettingsScreen extends ResponsiveStatelessWidget {
  const CalendarSettingsScreen({
    // required this.bloc,
    Key? key,
  }) : super(key: key);
  // final CalendarSettingsBloc bloc;

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return Material(
      type: MaterialType.canvas,
      color: context.colorScheme.backgroundColor,
      child: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Column(
            children: [
              SizedBox(
                width: contextInfo.widgetSize!.width,
                child: const ClinicHolidaysCard(),
              ),
              const WorkShiftsCard(),
              SectionCard(title: 'Assign shifts to work days'),
            ],
          ),
        ),
      ),
    );
  }
}
