import 'package:clinic_v2/app/shared_widgets/adaptive_theme_mode_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/preferences_cubit/preferences_cubit.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/app/shared_widgets/adaptive_locale_menu.dart';
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
          content: ListView(
            children: [
              const SizedBox(height: 20),
              AdaptiveThemeModeDropdown(
                type: DropdownMenuType.tileWithMenu,
                onChanged: (themeMode) {
                  context.read<PreferencesCubit>().updateAppTheme(themeMode);
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(height: 30),
              ),
              AdaptiveLocaleDropdown(
                type: DropdownMenuType.tileWithMenu,
                onChanged: (locale) {
                  context.read<PreferencesCubit>().updateAppLocale(locale);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
