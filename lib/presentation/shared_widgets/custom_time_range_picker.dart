import 'package:flutter/material.dart';

//
import 'package:time_range_picker/time_range_picker.dart';

//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/themes/material_themes.dart';

Future<void> showCustomTimeRangePicker(
  BuildContext context, {
  TimeOfDay? start,
  TimeOfDay? end,
  TimeRange? disabledTime,
  Function(TimeOfDay)? onStartChange,
  Function(TimeOfDay)? onEndChange,
  void Function()? onCancel,
}) async {
  final timeRangePicker = FittedBox(
    child: Dialog(
      backgroundColor: context.colorScheme.backgroundColor,
      child: SizedBox(
        width: () {
          if (context.isDesktop) {
            return 500.0;
          } else if (context.isLandScapeTablet) {
            return 400.0;
          } else if (context.isPortraitTablet) {
            return 300.0;
          } else {
            return 220.0;
          }
        }(),
        child: CustomTimeRangePicker(
          start: start,
          end: end,
          onEndChange: onEndChange,
          onStartChange: onStartChange,
          disabledTime: disabledTime,
          onCancel: onCancel,
        ),
      ),
    ),
  );
  await showDialog(
    context: context,
    builder: (context) {
      return Theme(
        data: MaterialAppThemes.of(context).copyWith(
          // when darkMode is on: this will be the background color of the
          // [timeRangePicker] header
          primaryColor: context.colorScheme.primary!,
          // when darkMode is off: this will be the background color of the
          // [timeRangePicker] header
          // backgroundColor: context.colorScheme.primary,
        ),
        child: timeRangePicker,
      );
    },
  );
}

class CustomTimeRangePicker extends StatelessWidget {
  const CustomTimeRangePicker({
    this.start,
    this.end,
    this.disabledTime,
    this.onStartChange,
    this.onEndChange,
    this.onCancel,
    Key? key,
  }) : super(key: key);
  final TimeOfDay? start;
  final TimeOfDay? end;

  final TimeRange? disabledTime;

  final void Function(TimeOfDay)? onStartChange;
  final void Function(TimeOfDay)? onEndChange;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return TimeRangePicker(
      // onCancel: onCancel,
      handlerColor: context.colorScheme.onPrimaryContainer,
      snap: true,
      padding: 70,
      rotateLabels: false,
      labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"]
          .asMap()
          .entries
          .map((e) {
        return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
      }).toList(),
      start: start,
      end: end,
      ticksOffset: 6,
      onStartChange: onStartChange,
      onEndChange: onEndChange,
      disabledTime: disabledTime,
      strokeColor: context.colorScheme.primary,
      backgroundColor: context.colorScheme.backgroundColor,
      use24HourFormat: false,
      autoAdjustLabels: true,
      handlerRadius: context.isDesktop ? 12 : 5,
      ticks: 24,
      labelStyle: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      ticksColor: context.colorScheme.onBackground!,
      selectedColor: context.colorScheme.primary?.withOpacity(.8),
      interval: const Duration(minutes: 30),
      timeTextStyle: context.textTheme.titleLarge?.copyWith(
        color: context.colorScheme.onPrimary?.withOpacity(.8),
        fontWeight: FontWeight.w600,
      ),
      activeTimeTextStyle: context.textTheme.titleLarge?.copyWith(
        color: context.colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
      ),
      strokeWidth: context.isMobile || context.isPortraitTablet ? 5 : 10,
      labelOffset: 40,
      backgroundWidget: ConstrainedBox(
        constraints: BoxConstraints.loose(
          Size(
            context.isMobile
                ? 60.0
                : context.isTablet
                    ? 70
                    : 100,
            70,
          ),
        ),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Icon(
                Icons.wb_sunny_outlined,
                size: context.isDesktop ? 32 : 22,
              ),
            ),
            Expanded(
              child: VerticalDivider(
                thickness: 2,
                indent: !context.isDesktop ? 10 : 0,
                endIndent: !context.isDesktop ? 10 : 0,
                color: context.isDarkMode ? Colors.white24 : Colors.black38,
              ),
            ),
            Expanded(
              child: Icon(
                Icons.nightlight_round,
                size: context.isDesktop ? 32 : 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
