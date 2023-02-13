import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/presentation/shared_widgets/adaptive_theme_mode_dropdown.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/adaptive_dialog.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/adaptive_locale_menu.dart';
import 'package:clinic_v2/presentation/shared_widgets/dropdown_menus/utils.dart';

import '../custom_dialogs/show_progress_dialog.dart';

class ShowSettingsDialogButton extends StatelessWidget {
  const ShowSettingsDialogButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppPreferencesCubit, AppPreferencesState>(
      listener: (context, state) {
        if (state is AppPreferencesStateWithData &&
            (ModalRoute.of(context)?.isActive ?? false)) {
          Navigator.of(context).pop();
        }
        if (state is UpdatingUserPreferencesFailed) {
          if ((ModalRoute.of(context)?.isActive ?? false)) {
            Navigator.of(context).pop();
          }
          showAdaptiveErrorDialog(
            context: context,
            titleText: "Failed to Save your changes",
            contentText: state.error.appException?.getMessage(context),
          );
        }
        if (state is UpdatingUserPreferencesInProgress) {
          showAdaptiveProgressDialog(
              context: context, contentText: "Applying Changes");
        }
      },
      child: CustomIconButton(
        tooltipMessage: context.localizations!.settings,
        icon: Icon(
          Icons.settings,
          color: context.colorScheme.secondary,
          size: 22,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AdaptiveDialog(
                type: DialogType.general,
                titleText: context.localizations!.settings,
                content: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 20),
                    AdaptiveThemeModeDropdown(
                      type: DropdownMenuType.tileWithMenu,
                      onChanged: (themeMode) {
                        context.read<AppPreferencesCubit>().setAppThemeMode(
                              themeMode,
                              currentLocale: context.locale,
                            );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Divider(),
                    ),
                    AdaptiveLocaleDropdown(
                      type: DropdownMenuType.tileWithMenu,
                      onChanged: (locale) {
                        context.read<AppPreferencesCubit>().setAppLocale(
                              locale,
                              currentTheme: context.themeMode,
                            );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
