import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/themes/material_themes.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltipMessage,
    Key? key,
  }) : super(key: key);

  final void Function() onPressed;
  final Widget icon;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return context.isWindowsPlatform
        ? windowsBuilder(context)
        : mobileScreenBuilder(context);
  }

  Widget windowsBuilder(BuildContext context) {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 200),
      message: tooltipMessage,
      child: fluent_ui.IconButton(
        icon: icon,
        onPressed: onPressed,
        style: fluent_ui.ButtonStyle(
          iconSize: fluent_ui.ButtonState.all(20),
        ),
      ),
    );
  }

  Widget mobileScreenBuilder(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: Theme.of(context).copyWith(
          tooltipTheme:
              MaterialAppThemes.getTooltipThemeDataForDesktop(context),
        ),
        child: IconButton(
          tooltip: tooltipMessage,
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
