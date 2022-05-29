import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/custom_time_range_picker.dart';
import 'package:clinic_v2/app/common/widgets/section_card.dart';
import 'package:clinic_v2/app/features/user_preferences/dentist_preferences/calendar/bloc/calendar_settings_bloc.dart';
import 'package:clinic_v2/core/common/models/work_shift.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_shift_button.dart';
import 'hour_digit_card.dart';

class WorkShiftDetails extends ResponsiveStatelessWidget {
  const WorkShiftDetails({
    required this.shiftIndex,
    Key? key,
  }) : super(key: key);

  final int shiftIndex;

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<CalendarSettingsBloc, CalendarSettingsState>(
      builder: (context, state) {
        final isOnlyShift = state.calendar.workShifts.length == 1;
        return SectionCard(
          title: 'Shift number: ${shiftIndex + 1}',
          titleIsColored: true,
          headTrailing: ButtonBar(
            children: [
              if (!isOnlyShift)
                DeleteShiftButton(
                  onConfirmed: () {
                    context.read<CalendarSettingsBloc>().add(
                          CalendarSettingsEvent.shiftDeleted(
                            shiftIndex: shiftIndex,
                          ),
                        );
                  },
                ),
            ],
          ),
          children: [
            fluent_ui.HoverButton(
              onPressed: () => _onPressed(contextInfo),
              builder: (context, states) {
                final _cardColor = states.isHovering
                    ? context.isDarkMode
                        ? Colors.white10
                        : Colors.black12
                    : context.colorScheme.primaryContainer!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Wrap(
                    runAlignment: WrapAlignment.end,
                    alignment: contextInfo.widgetSize!.width >= 750
                        ? WrapAlignment.spaceAround
                        : WrapAlignment.start,
                    // runSpacing: 14,
                    children: [
                      _ShiftHour(
                        cardColor: _cardColor,
                        shiftIndex: shiftIndex,
                        isStartHour: true,
                      ),
                      _ShiftHour(
                        cardColor: _cardColor,
                        shiftIndex: shiftIndex,
                        isStartHour: false,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  WorkShift getWorkShift(BuildContext context) {
    return context
        .read<CalendarSettingsBloc>()
        .state
        .calendar
        .workShifts
        .elementAt(shiftIndex);
  }

  void _onPressed(ContextInfo contextInfo) async {
    TimeOfDay? newStartTime;
    TimeOfDay? newEndTime;
    TimeOfDay currentStartTime = getWorkShift(contextInfo.context).start;
    TimeOfDay currentEndTime = getWorkShift(contextInfo.context).end;

    await showCustomTimeRangePicker(
      contextInfo,
      start: currentStartTime,
      end: currentEndTime,
      onStartChange: (start) => newStartTime = start,
      onEndChange: (end) => newEndTime = end,
      onCancel: () {
        newStartTime = newEndTime = null;
      },
    );
    if (newStartTime != currentStartTime || newEndTime != currentEndTime) {
      contextInfo.context.read<CalendarSettingsBloc>().add(
            CalendarSettingsEvent.shiftUpdated(
              shiftIndex: shiftIndex,
              newWorkShift: getWorkShift(contextInfo.context).copyWith(
                start: newStartTime ?? currentStartTime,
                end: newEndTime ?? currentEndTime,
              ),
            ),
          );
    }
  }
}

class _ShiftHour extends ResponsiveStatelessWidget {
  const _ShiftHour({
    required this.shiftIndex,
    required this.isStartHour,
    required this.cardColor,
    Key? key,
  }) : super(key: key);

  final int shiftIndex;
  final bool isStartHour;
  final Color cardColor;

  WorkShift getWorkShift(BuildContext context) {
    return context
        .read<CalendarSettingsBloc>()
        .state
        .calendar
        .workShifts
        .elementAt(shiftIndex);
  }

  TimeOfDay getTime(BuildContext context) {
    return isStartHour
        ? getWorkShift(context).start
        : getWorkShift(context).end;
  }

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return fluent_ui.InfoLabel(
      label: isStartHour ? 'From' : 'To',
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(const Size(350, 50)),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: HourDigitCard(
                labelText: getTime(context).hourOfPeriod.toString(),
                cardColor: cardColor,
              ),
            ),
            Text(
              ':',
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: HourDigitCard(
                labelText: getTime(context).minute.toString(),
                cardColor: cardColor,
              ),
            ),
            Expanded(
              child: HourDigitCard(
                label: Wrap(
                  spacing: 20,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(
                      getTime(context).period == DayPeriod.am
                          ? Icons.wb_sunny
                          : Icons.dark_mode,
                    ),
                    Text(
                      getTime(context).period.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
                cardColor: cardColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  //
  // bool _selectedTimeIsValid(BuildContext context, TimeOfDay selectedTime) {
  //   return isStartHour
  //       ? selectedTime.isBefore(getWorkShift(context).end)
  //       : selectedTime.isAfter(getWorkShift(context).start);
  // }
  //
  // void _showInvalidSelectedHourDialog(
  //     BuildContext parentContext, TimeOfDay selectedTime) {
  //   fluent_ui.showDialog(
  //     context: parentContext,
  //     builder: (context) {
  //       return CustomDialog(
  //         withOkOptionButton: true,
  //         titleText: 'Selected time is not valid!',
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             AdaptiveListTile(
  //               leading: const Icon(Icons.timelapse),
  //               title: Text(
  //                 isStartHour
  //                     ? 'Current shift-end hour: ${getTime(parentContext).format(context)}'
  //                     : 'Current shift-start hour: ${getTime(parentContext).format(context)}',
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //             Text(
  //               'You selected ${selectedTime.format(context)} as ' +
  //                   (isStartHour
  //                       ? 'shift-start hour which is After shift-end hour.'
  //                       : 'shift-end hour which is Before shift-start hour.'),
  //               style: context.textTheme.bodyLarge?.copyWith(
  //                 fontStyle: FontStyle.italic,
  //                 color: context.colorScheme.onPrimaryContainer,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

}

// @override
// Widget defaultBuilder(BuildContext context, ContextInfo contextInfo)  {
//   print(contextInfo.widgetSize!);
//   return SizedBox(
//     height: contextInfo.widgetSize!.height,
//     child:

// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     IconButton(
//       onPressed: () => setState(() => _pressed = !_pressed),
//       icon: Icon(
//         Icons.remove_circle_outline,
//         size: 22,
//         color: context.colorScheme.errorColor,
//       ),
//     ),
//     // alignment: _pressed ? Alignment.bottomCenter : Alignment.topCenter,
//
//     if (_pressed)
//       Expanded(
//         flex: 0,
//         child: CustomFilledButton(
//           // onPressed: () {},
//           onPressed: () => setState(() => _pressed = false),
//
//           label: 'confirm delete',
//           iconData: Icons.done,
//         ),
//       ),
//   ],
// ),
// );
// }
