import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/section_card.dart';
import 'package:clinic_v2/core/common/models/work_shift.dart';
import 'package:fluent_ui/fluent_ui.dart ' as fluent_ui;
import 'shift_details_tile.dart';

class ShiftsSettingsCard extends Component {
  final List<WorkShift> workShifts;
  final void Function(List<WorkShift>) onShiftsChanged;
  const ShiftsSettingsCard({
    required this.workShifts,
    required this.onShiftsChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget windowsDesktopBuilder(BuildContext context, contextInfo) {
    return SectionCard(
      title: 'Clinic work shifts',
      titleFontSize: 20,
      headTrailing: fluent_ui.IconButton(
        icon: const Icon(fluent_ui.FluentIcons.add),
        onPressed: _addNewShift,
      ),
      children: [
        const SizedBox(height: 20),
        const Divider(),
        ...List<List<Widget>>.generate(
          workShifts.length,
          (index) => [
            WorkShiftDetails(
              shiftNo: index + 1,
              startTime: workShifts.elementAt(index).startDateTime,
              endTime: workShifts.elementAt(index).endDateTime,
              onDeleteShift: () => _deleteShift(index),
              onStartTimeChanged: (time) {
                final oldShift = workShifts[index];
                workShifts[index] =
                    oldShift.copyWith(start: TimeOfDay.fromDateTime(time));
                onShiftsChanged(workShifts);
              },
              onEndTimeChanged: (time) {
                final oldShift = workShifts[index];
                workShifts[index] =
                    oldShift.copyWith(end: TimeOfDay.fromDateTime(time));
                onShiftsChanged(workShifts);
              },
            ),
            const Divider(),
          ],
        ).expand((e) => e)
      ],
    );
  }

  void _deleteShift(int shiftIndex) {
    workShifts.removeAt(shiftIndex);
    onShiftsChanged(workShifts);
  }

  void _addNewShift() {
    workShifts.add(workShifts.last);
    onShiftsChanged(workShifts);
  }
}

// class WorkShiftDetails extends StatelessWidget {
//   const WorkShiftDetails({
//     required this.shiftNo,
//     required this.startTime,
//     required this.endTime,
//     required this.onEndTimeChanged,
//     required this.onStartTimeChanged,
//     required this.onDeleteShift,
//     Key? key,
//   }) : super(key: key);

//   final int shiftNo;
//   final DateTime startTime;
//   final DateTime endTime;
//   final void Function(DateTime) onStartTimeChanged;
//   final void Function(DateTime) onEndTimeChanged;
//   final void Function() onDeleteShift;

//   void _checkIfSelectedTimeIsValid(
//     BuildContext context,
//     DateTime time, {
//     required bool isStartTime,
//   }) {
//     final isValid =
//         isStartTime ? time.isBefore(endTime) : time.isAfter(startTime);
//     if (isValid) {
//       isStartTime ? onStartTimeChanged(time) : onEndTimeChanged(time);
//     } else {
//       fluent_ui.showDialog(
//         context: context,
//         builder: (context) {
//           return CustomDialog(
//             withOkOptionButton: true,
//             titleText: 'Selected time is not valid!',
//             contentText: isStartTime
//                 ? "Please select a shift's start time that is after its end time"
//                 : "Please select a shift's end time that is before its start time",
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return fluent_ui.InfoLabel(
//       label: 'Shift number: $shiftNo',
//       labelStyle: context.fluentTextTheme.bodyLarge,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
//         child: Wrap(
//           runAlignment: WrapAlignment.end,
//           crossAxisAlignment: WrapCrossAlignment.end,
//           spacing: 20,
//           runSpacing: 14,
//           children: [
//             SizedBox(
//               width: 240,
//               child: fluent_ui.TimePicker(
//                 header: 'From',
//                 selected: startTime,
//                 onChanged: (dateTime) {
//                   _checkIfSelectedTimeIsValid(
//                     context,
//                     dateTime,
//                     isStartTime: true,
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               width: 240,
//               child: fluent_ui.TimePicker(
//                 header: 'To',
//                 selected: endTime,
//                 onChanged: (dateTime) {
//                   _checkIfSelectedTimeIsValid(
//                     context,
//                     dateTime,
//                     isStartTime: false,
//                   );
//                 },
//               ),
//             ),
//             if (shiftNo != 1)
//               CustomFilledButton(
//                 label: 'Delete',
//                 labelColor: context.colorScheme.onError,
//                 backgroundColor: context.colorScheme.errorColor,
//                 onPressed: onDeleteShift,
//                 iconData: Icons.delete,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
