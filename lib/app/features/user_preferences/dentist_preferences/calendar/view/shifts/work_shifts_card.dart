//
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/custom_time_range_picker.dart';
import 'package:clinic_v2/app/common/widgets/section_card.dart';
import 'package:clinic_v2/app/features/user_preferences/dentist_preferences/calendar/bloc/calendar_settings_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart ' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/common/models/work_shift.dart';
import 'components/shift_details_tile.dart';

class WorkShiftsCard extends ResponsiveStatelessWidget {
  const WorkShiftsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return SectionCard(
      title: 'Clinic work shifts',
      titleFontSize: 18,
      headTrailing: fluent_ui.IconButton(
        icon: Icon(
          fluent_ui.FluentIcons.add,
          color: context.isDarkMode
              ? context.colorScheme.primary
              : context.colorScheme.secondary,
          size: 18,
        ),
        onPressed: () => _onAddNewShift(contextInfo),
      ),
      children: const [
        Divider(),
        _ShiftsTiles(),
      ],
    );
  }

  Future<void> _onAddNewShift(ContextInfo contextInfo) async {
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    await showCustomTimeRangePicker(
      contextInfo,
      onStartChange: (time) => startTime = time,
      onEndChange: (time) => endTime = time,
      onCancel: () {
        startTime = endTime = null;
      },
    );
    if (startTime != null && endTime != null) {
      final newWorkShift = WorkShift(
        start: startTime!,
        end: endTime!,
        days: const [],
      );
      contextInfo.context.read<CalendarSettingsBloc>().add(
            CalendarSettingsEvent.shiftAdded(newWorkShift),
          );
    }
  }
}

class _ShiftsTiles extends StatelessWidget {
  const _ShiftsTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarSettingsBloc, CalendarSettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List<List<Widget>>.generate(
            state.calendar.workShifts.length,
            (index) => [
              WorkShiftDetails(shiftIndex: index),
              const Divider(),
            ],
          ).expand((e) => e).toList(),
        );
      },
    );
  }
}
