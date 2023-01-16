import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

const windowsButtonHeight = 32;

class AdaptiveFilledButton extends StatelessWidget {
  const AdaptiveFilledButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.iconData,
    this.backgroundColor,
    this.labelColor,
    this.fillHeight = false,
    this.fillWidth = false,
    this.withIcon = false,
    this.width = 70,
    this.height = 34,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool fillHeight;
  final bool fillWidth;
  final double? height;
  final double? width;
  final bool withIcon;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(
      builder: (context, widgetInfo) {
        if (context.isWindowsPlatform) {
          return _WindowsFilledButton(
            label: label,
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            labelColor: labelColor,
            height: fillHeight ? widgetInfo.widgetSize.height : height,
            width: fillWidth ? widgetInfo.widgetSize.width : width,
          );
        } else if (context.isAndroidPlatform) {
          return _AndroidFilledButton(
            label: label,
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            labelColor: labelColor,
            withIcon: withIcon,
            iconData: iconData,
            height: fillHeight ? widgetInfo.widgetSize.height : height,
            width: fillWidth ? widgetInfo.widgetSize.width : width,
          );
        }
        throw UnimplementedError();
      },
    );
  }
}

class _WindowsFilledButton extends StatelessWidget {
  const _WindowsFilledButton({
    required this.label,
    required this.onPressed,
    this.height = 40,
    this.width = 100,
    this.backgroundColor,
    this.labelColor,
    Key? key,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? labelColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: fluent_ui.FilledButton(
        child: Center(child: Text(label)),
        onPressed: onPressed,
        style: fluent_ui.ButtonStyle(
          foregroundColor: fluent_ui.ButtonState.resolveWith((states) {
            return labelColor;
          }),
          backgroundColor: fluent_ui.ButtonState.resolveWith((states) {
            if (states.isHovering) {
              return backgroundColor?.lerpWith(Colors.black45, .1);
            }
            return backgroundColor;
          }),
          textStyle: fluent_ui.ButtonState.all(
            context.textTheme.titleMedium?.copyWith(
              color: labelColor,
              fontWeight: FontWeight.w600,
              fontSize: context.isDesktop ? 17 : 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _AndroidFilledButton extends StatelessWidget {
  const _AndroidFilledButton({
    required this.label,
    required this.onPressed,
    this.withIcon = false,
    this.iconData,
    this.height,
    this.width,
    this.backgroundColor,
    this.labelColor,
    Key? key,
  })  : assert(withIcon == true && iconData != null),
        super(key: key);

  final String label;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? labelColor;
  final double? height;
  final double? width;
  final bool withIcon;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      fixedSize: MaterialStateProperty.all(const Size.fromHeight(40)),
      padding: MaterialStateProperty.all(
        const EdgeInsets.fromLTRB(16, 2, 24, 2),
      ),
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
    );
    return withIcon
        ? TextButton.icon(
            label: Text(label),
            onPressed: onPressed,
            icon: Icon(iconData, size: 20),
            style: buttonStyle,
          )
        : TextButton(
            child: Text(label),
            onPressed: onPressed,
            style: buttonStyle,
          );
  }
}
