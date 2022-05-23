import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
//
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets//windows_components/windows_settings_tile.dart';
import 'package:clinic_v2/app/common/widgets//windows_components/windows_toggle_switch.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:clinic_v2/app/infrastructure/themes/material_themes.dart';

part 'theme_switches.dart';

enum ThemeModeSwitchType { tile, icon }

class ThemeModeSwitch extends StatefulWidget {
  const ThemeModeSwitch(this.switchType, {Key? key}) : super(key: key);
  final ThemeModeSwitchType switchType;
  @override
  State<ThemeModeSwitch> createState() => _ThemeSettingsSwitchState();
}

class _ThemeSettingsSwitchState
    extends StateWithResponsiveBuilder<ThemeModeSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.switchType == ThemeModeSwitchType.tile
        ? _ThemeSwitchTile(
            themeIcon: _animatedThemeIcon(context),
            onThemeModeChanged: _onThemeModeChanged,
          )
        : _ThemeSwitchIcon(
            icon: _animatedThemeIcon(context),
            onThemeModeChanged: _onThemeModeChanged,
          );
  }

  void _onThemeModeChanged() {
    final newThemeMode = context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    context.read<AppearancePreferencesCubit>().provideThemeMode(newThemeMode);
    setState(() {
      context.isDarkMode
          ? animationController.reverse(from: 1)
          : animationController.forward(from: 0);
    });
  }

  Widget _animatedThemeIcon(BuildContext context) {
    return SpinPerfect(
      duration: const Duration(milliseconds: 600),
      animate: false,
      manualTrigger: true,
      controller: (_) {
        animationController = _;
      },
      child: Icon(
        _getThemeModeIcon(context),
        size: context.isDesktopPlatform ? 22 : null,
        color: context.colorScheme.onBackground,
      ),
    );
  }

  IconData _getThemeModeIcon(BuildContext context) {
    if (context.isDesktopPlatform) {
      return context.isDarkMode
          ? fluent_ui.FluentIcons.light
          : fluent_ui.FluentIcons.clear_night;
    } else if (context.isIOSPlatform) {
      return context.isDarkMode
          ? CupertinoIcons.sun_max_fill
          : CupertinoIcons.moon;
    } else {
      return context.isDarkMode ? Icons.light_mode : Icons.dark_mode;
    }
  }
}
