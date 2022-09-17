import 'package:clinic_v2/app/themes/material_themes.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

import '../custom_widget/custom_widget.dart';

class ThemeIconSwitch extends CustomStatelessWidget {
  const ThemeIconSwitch({
    required this.icon,
    required this.onThemeModeChanged,
    Key? key,
  }) : super(key: key);

  final void Function() onThemeModeChanged;
  final Widget icon;

  @override
  Widget? windowsBuilder(BuildContext context, ContextInfo contextInfo) {
    return fluent_ui.Tooltip(
      message: context.isDarkMode
          ? AppLocalizations.of(context)!.enableLightTheme
          : AppLocalizations.of(context)!.enableDarkTheme,
      child: fluent_ui.IconButton(
        icon: icon,
        onPressed: onThemeModeChanged,
      ),
    );
  }

  @override
  Widget? mobileScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: Theme.of(context).copyWith(
          tooltipTheme:
              MaterialAppThemes.getTooltipThemeDataForDesktop(context),
        ),
        child: IconButton(
          tooltip: context.isDarkMode
              ? AppLocalizations.of(context)!.enableLightTheme
              : AppLocalizations.of(context)!.enableDarkTheme,
          icon: icon,
          onPressed: onThemeModeChanged,
        ),
      ),
    );
  }
}
