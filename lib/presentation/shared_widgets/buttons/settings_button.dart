import 'package:animations/animations.dart';
import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/presentation/shared_widgets/adaptive_theme_mode_dropdown.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/adaptive_locale_menu.dart';
import 'package:clinic_v2/presentation/shared_widgets/dropdown_menus/utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/dialogs/windows_general_dialog.dart';

import '../loading_indicator.dart';

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
            contentText: state.error.exception?.getMessage(context),
          );
        }
        if (state is UpdatingUserPreferencesInProgress) {
          showModal(
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.colorScheme.backgroundColor,
                    ),
                    constraints: BoxConstraints.loose(const Size.square(300)),
                    alignment: Alignment.center,
                    child: AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      switchOutCurve: Curves.elasticInOut,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          LoadingIndicator(),
                          Text("Applying changes"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
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
          showWindowsGeneralDialog(
            context: context,
            titleText: context.localizations!.settings,
            content: ListView(
              children: [
                const SizedBox(height: 20),
                AdaptiveThemeModeDropdown(
                  type: DropdownMenuType.tileWithMenu,
                  onChanged: (themeMode) {
                    context.read<AppPreferencesCubit>().updateAppTheme(
                          themeMode,
                          currentLocale: context.locale,
                        );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(height: 30),
                ),
                AdaptiveLocaleDropdown(
                  type: DropdownMenuType.tileWithMenu,
                  onChanged: (locale) {
                    context.read<AppPreferencesCubit>().updateAppLocale(
                          locale,
                          currentTheme: context.themeMode,
                        );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
