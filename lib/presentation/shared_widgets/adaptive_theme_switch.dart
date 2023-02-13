import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//
import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';

import '../../presentation/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'custom_switches/adaptive_switch_tile.dart';

class AdaptiveThemeSwitch extends StatefulWidget {
  const AdaptiveThemeSwitch({
    required this.switchType,
    required this.onThemeChanged,
    Key? key,
  }) : super(key: key);

  final ThemeModeSwitchType switchType;
  final void Function(ThemeMode themeMode) onThemeChanged;

  @override
  State<AdaptiveThemeSwitch> createState() => _ThemeSettingsSwitchState();
}

class _ThemeSettingsSwitchState extends State<AdaptiveThemeSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 800),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.switchType == ThemeModeSwitchType.tile
        ? AdaptiveSwitchTile(
            value: context.isDarkMode,
            label: context.localizations!.appearance,
            description: context.localizations!.enableDarkTheme,
            icon: _animatedThemeIcon(context),
            onChanged: (_) => _onThemeModeChanged(),
          )
        : CustomIconButton(
            icon: _animatedThemeIcon(context),
            onPressed: _onThemeModeChanged,
            iconSize: 18,
            tooltipMessage: context.isDarkMode
                ? context.localizations!.enableLightTheme
                : context.localizations!.enableDarkTheme,
          );
  }

  void _onThemeModeChanged() {
    final newThemeMode = context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    widget.onThemeChanged(newThemeMode);
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
        size: context.isDesktopPlatform ? 18 : null,
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

enum ThemeModeSwitchType { tile, icon }
