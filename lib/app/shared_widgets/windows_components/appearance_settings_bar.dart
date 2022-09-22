import 'package:clinic_v2/app/blocs/preferences_cubit/preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dropdown_menus/adaptive_locale_menu.dart';
import '../dropdown_menus/utils.dart';
import '../theme_switches/adaptive_theme_switch.dart';

class BlocAppearanceSettingsBar extends StatelessWidget {
  const BlocAppearanceSettingsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppearanceSettingsBar(
      onLocaleChanged: (Locale locale) =>
          context.read<PreferencesCubit>().provideLocale(locale),
      onThemeModeChanged: (ThemeMode themeMode) =>
          context.read<PreferencesCubit>().provideThemeMode(themeMode),
    );
  }
}

class AppearanceSettingsBar extends StatelessWidget {
  const AppearanceSettingsBar({
    required this.onLocaleChanged,
    required this.onThemeModeChanged,
    Key? key,
  }) : super(key: key);
  final void Function(Locale locale) onLocaleChanged;
  final void Function(ThemeMode themeMode) onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 2,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AdaptiveLocaleMenu(
              type: DropdownMenuType.menuOnly,
              onChanged: (Locale locale) {
                onLocaleChanged(locale);
              },
            ),
            const SizedBox(width: 8),
            AdaptiveThemeSwitch(
              switchType: ThemeModeSwitchType.icon,
              onThemeChanged: (ThemeMode themeMode) {
                onThemeModeChanged(themeMode);
              },
            ),
          ],
        ),
      ),
    );
  }
}
