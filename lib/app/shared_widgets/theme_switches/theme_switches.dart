import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
//
import '../windows_components/windows_settings_tile.dart';
import '../windows_components/windows_toggle_switch.dart';

class ThemeTileSwitch extends StatelessWidget {
  const ThemeTileSwitch({
    required this.onThemeModeChanged,
    required this.themeIcon,
    Key? key,
  }) : super(key: key);

  final Widget themeIcon;
  final void Function() onThemeModeChanged;
  @override
  Widget build(BuildContext context) {
    return context.isWindowsPlatform
        ? windowsBuilder(context)
        : defaultBuilder(context);
  }

  Widget windowsBuilder(BuildContext context) {
    return WindowsSettingTile(
      tileLabel: 'Theme',
      leadingIcon: themeIcon,
      titleText: context.localizations!.darkMode,
      trailing: WindowsToggleSwitch(
        checked: context.isDarkMode,
        onChanged: (_) => onThemeModeChanged(),
      ),
    );
  }

  Widget defaultBuilder(BuildContext context) {
    return SwitchListTile.adaptive(
      value: context.isDarkMode,
      title: Text(
        context.localizations!.darkMode,
        style: context.textTheme.subtitle1,
      ),
      // contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      secondary: themeIcon,
      subtitle: Text(
        context.isDarkMode
            ? context.localizations!.enabled
            : context.localizations!.disabled,
        style: context.textTheme.bodyText2?.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
      activeColor: context.colorScheme.primary,
      onChanged: (_) => onThemeModeChanged(),
    );
  }
}
