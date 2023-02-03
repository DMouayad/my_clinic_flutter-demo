import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import '../adaptive_locale_menu.dart';
import '../../../presentation/shared_widgets/dropdown_menus/utils.dart';
import '../adaptive_theme_switch.dart';

class BlocAppSettingsBar extends StatelessWidget {
  const BlocAppSettingsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSettingsBar(
      onLocaleChanged: (Locale locale) {
        context.read<AppPreferencesCubit>().updateAppLocale(
              locale,
              currentTheme: context.themeMode,
            );
      },
      onThemeModeChanged: (ThemeMode themeMode) {
        context.read<AppPreferencesCubit>().updateAppTheme(
              themeMode,
              currentLocale: context.locale,
            );
      },
    );
  }
}

class AppSettingsBar extends StatelessWidget {
  const AppSettingsBar({
    required this.onLocaleChanged,
    required this.onThemeModeChanged,
    Key? key,
  }) : super(key: key);
  final void Function(Locale locale) onLocaleChanged;
  final void Function(ThemeMode themeMode) onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 2,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8,
          ),
          child: Flex(
            direction: Axis.horizontal,
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AdaptiveLocaleDropdown(
                type: DropdownMenuType.menuOnly,
                onChanged: (Locale locale) {
                  onLocaleChanged(locale);
                },
              ),
              const SizedBox(width: 12),
              AdaptiveThemeSwitch(
                switchType: ThemeModeSwitchType.icon,
                onThemeChanged: (ThemeMode themeMode) {
                  onThemeModeChanged(themeMode);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
