import 'package:animate_do/animate_do.dart';
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeModeSwitchType { tile, icon }

class ThemeModeSwitch extends StatefulWidget {
  const ThemeModeSwitch({this.switchType = ThemeModeSwitchType.tile, Key? key})
      : super(key: key);
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

  // @override
  // void dispose() {
  //   super.dispose();
  //   animationController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return widget.switchType == ThemeModeSwitchType.tile
        ? SwitchListTile.adaptive(
            value: context.isDarkMode,
            title: Text(
              AppLocalizations.of(context)!.darkMode,
              style: context.textTheme.subtitle1,
            ),
            // contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            secondary: _animatedThemeIcon(),
            subtitle: Text(
              context.isDarkMode
                  ? AppLocalizations.of(context)!.enabled
                  : AppLocalizations.of(context)!.disabled,
              style: context.textTheme.bodyText2?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            activeColor: context.colorScheme.primary,
            onChanged: (_) => _onThemeModeChanged(),
          )
        : Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: _animatedThemeIcon(),
              onPressed: _onThemeModeChanged,
            ),
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

  Widget _animatedThemeIcon() {
    return SpinPerfect(
      duration: const Duration(milliseconds: 600),
      animate: false,
      manualTrigger: true,
      controller: (_) {
        animationController = _;
      },
      child: Icon(
        Icons.dark_mode,
        color: context.isDarkMode
            ? AppColorScheme.lightColorScheme.background
            : AppColorScheme.darkColorScheme.background,
      ),
    );
  }
}
