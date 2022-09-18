import 'package:clinic_v2/app/shared_widgets/custom_widget.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

const buttonHight = 40;

class CustomFilledButton extends CustomStatelessWidget {
  const CustomFilledButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.iconData,
    this.backgroundColor,
    this.labelColor,
    this.fillHeight = false,
    this.fillWidth = false,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;
  final IconData iconData;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool fillHeight;
  final bool fillWidth;

  Widget windowsBuilder(BuildContext context, WidgetInfo contextInfo) {
    return SizedBox(
      height: fillHeight ? contextInfo.widgetSize!.height : null,
      width: fillWidth ? contextInfo.widgetSize!.width : null,
      child: fluent_ui.FilledButton(
        child: Text(label),
        onPressed: onPressed,
        style: fluent_ui.ButtonStyle(
          backgroundColor: fluent_ui.ButtonState.all(backgroundColor),
          foregroundColor: fluent_ui.ButtonState.resolveWith((states) {
            return labelColor ?? context.colorScheme.onBackground;
          }),
          textStyle: fluent_ui.ButtonState.all(
            context.textTheme.titleMedium?.copyWith(
              color: labelColor ?? context.colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget defaultBuilder(BuildContext context, WidgetInfo contextInfo) {
    return TextButton.icon(
      label: Text(label),
      onPressed: onPressed,
      icon: Icon(iconData, size: 20),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size.fromHeight(40)),
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(16, 2, 24, 2)),
        backgroundColor: MaterialStateProperty.all(
          backgroundColor ??
              (context.isDarkMode
                  ? const Color(0xFF485860)
                  // : const Color(0xFF95bcb7)
                  : context.colorScheme.secondaryContainer),
        ),
        textStyle: MaterialStateProperty.all(
          context.textTheme.subtitle2?.copyWith(
            color: labelColor ?? context.colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          labelColor ?? (context.colorScheme.onSecondaryContainer),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget customBuild(BuildContext context, WidgetInfo contextInfo) {
    return context.isWindowsPlatform
        ? windowsBuilder(context, contextInfo)
        : defaultBuilder(context, contextInfo);
  }
}
