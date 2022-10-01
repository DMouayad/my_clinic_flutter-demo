import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/preferences_cubit/preferences_cubit.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/adaptive_theme_switch.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/adaptive_locale_menu.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/utils.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/dialogs/windows_general_dialog.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltipMessage: context.localizations!.settings,
      icon: Icon(
        Icons.settings,
        color: context.colorScheme.secondary,
        size: 22,
      ),
      onPressed: () {
        showWindowsGeneralDialog(
          context: context,
          titleText: context.localizations!.settings,
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                AdaptiveThemeSwitch(
                  switchType: ThemeModeSwitchType.tile,
                  onThemeChanged: (themeMode) {
                    context
                        .read<PreferencesCubit>()
                        .updateUserThemePreference(themeMode);
                  },
                ),
                const SizedBox(height: 20),
                AdaptiveLocaleMenu(
                  type: DropdownMenuType.tileWithMenu,
                  onChanged: (locale) {
                    context
                        .read<PreferencesCubit>()
                        .updateUserLocalePreference(locale);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
