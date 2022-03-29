import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/models/user_preferences_item.dart';
import 'package:clinic_v2/app/features/preferences/cubit/preferences_cubit.dart';

class AppPreferencesSettings extends StatelessWidget {
  const AppPreferencesSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appPreferencesItems = [
      UserPreferencesItem(
        name: AppLocalizations.of(context)!.appearance,
        icon: Icons.color_lens,
        itemWidget: const ThemeSettings(),
      ),
    ];
    return ListView.builder(
      itemCount: _appPreferencesItems.length,
      itemBuilder: (BuildContext context, int index) {
        return _appPreferencesItems.elementAt(index).itemWidget;
      },
    );
  }
}

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({Key? key}) : super(key: key);

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends StateWithResponsiveBuilder<ThemeSettings>
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
    return SwitchListTile.adaptive(
      value: context.isDarkMode,
      title: Text(
        AppLocalizations.of(context)!.darkMode,
        style: context.textTheme.subtitle1,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      secondary: SpinPerfect(
        duration: const Duration(milliseconds: 600),
        animate: false,
        manualTrigger: true,
        controller: (_) {
          animationController = _;
        },
        child: Icon(
          Icons.nightlight_round,
          color: context.isDarkMode ? context.colorScheme.primary : null,
        ),
      ),
      subtitle: Text(
        context.isDarkMode
            ? AppLocalizations.of(context)!.enabled
            : AppLocalizations.of(context)!.disabled,
        style: context.textTheme.bodyText2?.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
      activeColor: context.colorScheme.primary,
      onChanged: (isDarkModeEnabled) {
        context.read<PreferencesCubit>().provideThemeMode(
              isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            );

        setState(() {
          context.isDarkMode
              ? animationController.reverse(from: 1)
              : animationController.forward(from: 0);
        });
      },
    );
  }
}
