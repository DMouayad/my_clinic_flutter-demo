import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_filled_button.dart';
import 'package:clinic_v2/app/common/widgets/custom_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

class WorkShiftDetails extends StatelessWidget {
  const WorkShiftDetails({
    required this.shiftNo,
    required this.startTime,
    required this.endTime,
    required this.onEndTimeChanged,
    required this.onStartTimeChanged,
    required this.onDeleteShift,
    Key? key,
  }) : super(key: key);

  final int shiftNo;
  final DateTime startTime;
  final DateTime endTime;
  final void Function(DateTime) onStartTimeChanged;
  final void Function(DateTime) onEndTimeChanged;
  final void Function() onDeleteShift;

  void _checkIfSelectedTimeIsValid(
    BuildContext context,
    DateTime time, {
    required bool isStartTime,
  }) {
    final isValid =
        isStartTime ? time.isBefore(endTime) : time.isAfter(startTime);
    if (isValid) {
      isStartTime ? onStartTimeChanged(time) : onEndTimeChanged(time);
    } else {
      fluent_ui.showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            withOkOptionButton: true,
            titleText: 'Selected time is not valid!',
            contentText: isStartTime
                ? "Please select a shift's start time that is after its end time"
                : "Please select a shift's end time that is before its start time",
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return fluent_ui.InfoLabel(
      label: 'Shift number: $shiftNo',
      labelStyle: context.fluentTextTheme.bodyLarge,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Wrap(
          runAlignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: 20,
          runSpacing: 14,
          children: [
            SizedBox(
              width: 240,
              child: fluent_ui.TimePicker(
                header: 'From',
                selected: startTime,
                onChanged: (dateTime) {
                  _checkIfSelectedTimeIsValid(
                    context,
                    dateTime,
                    isStartTime: true,
                  );
                },
              ),
            ),
            SizedBox(
              width: 240,
              child: fluent_ui.TimePicker(
                header: 'To',
                selected: endTime,
                onChanged: (dateTime) {
                  _checkIfSelectedTimeIsValid(
                    context,
                    dateTime,
                    isStartTime: false,
                  );
                },
              ),
            ),
            if (shiftNo != 1)
              CustomFilledButton(
                label: 'D',
                // label: AppLocalizations.of(context)!.delete,
                labelColor: context.colorScheme.onError,
                backgroundColor: context.colorScheme.errorColor,
                onPressed: onDeleteShift,
                iconData: Icons.delete,
              ),
          ],
        ),
      ),
    );
  }
}
