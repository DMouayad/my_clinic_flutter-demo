import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/themes/material_themes.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';

class ThemeIconSwitch extends StatelessWidget {
  const ThemeIconSwitch({
    required this.icon,
    required this.onThemeModeChanged,
    Key? key,
  }) : super(key: key);

  final void Function() onThemeModeChanged;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return context.isWindowsPlatform
        ? windowsBuilder(context)
        : mobileScreenBuilder(context);
  }

  Widget windowsBuilder(BuildContext context) {
    return fluent_ui.Tooltip(
      message: context.isDarkMode
          ? context.localizations!.enableLightTheme
          : context.localizations!.enableDarkTheme,
      child: fluent_ui.IconButton(
        icon: icon,
        onPressed: onThemeModeChanged,
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
          tooltip: context.isDarkMode
              ? context.localizations!.enableLightTheme
              : context.localizations!.enableDarkTheme,
          icon: icon,
          onPressed: onThemeModeChanged,
        ),
      ),
    );
  }
}
