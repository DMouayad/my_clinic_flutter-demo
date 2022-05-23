import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_filled_button.dart';
import 'package:clinic_v2/app/features/auth/sign_up/step_two_sign_up/components/user_preferences_list_item.dart';
import 'package:clinic_v2/app/features/user_preferences/dentist_preferences/calendar/calendar_settings_screen.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
//

import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets//windows_components/custom_nav_view.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_back_button.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/appearance_settings.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';

import '../helpers/dentist_info_helper.dart';

class WindowsStepTwoSignUpScreen extends StatefulWidget {
  const WindowsStepTwoSignUpScreen({Key? key}) : super(key: key);
  @override
  State<WindowsStepTwoSignUpScreen> createState() =>
      WindowsStepTwoSignUpScreenState();
}

class WindowsStepTwoSignUpScreenState
    extends StateWithResponsiveBuilder<WindowsStepTwoSignUpScreen> {
  int selectedPaneIndex = 0;
  Widget content = const SizedBox.shrink();
  late final DentistSetupHelper _dentistSetupHelper;
  @override
  void initState() {
    _dentistSetupHelper = DentistSetupHelper();
    super.initState();
  }

  @override
  Widget? builder(BuildContext context, ContextInfo contextInfo) {
    final bool showDentalServicesTile =
        (context.read<SignUpCubit>().state as SignUpStepTwo).serverUser.role ==
            UserRole.dentist;
    final _preferencesListData = [
      PreferencesListItemData(
        name: AppLocalizations.of(context)!.calendar,
        icon: Icons.calendar_today_outlined,
      ),
      PreferencesListItemData(
        name: AppLocalizations.of(context)!.appearance,
        icon: Icons.devices,
      ),
      if (showDentalServicesTile)
        PreferencesListItemData(
          name: 'Dental services',
          // name: AppLocalizations.of(context)!.dentalServices,
          icon: Icons.medical_services_outlined,
        ),
    ];
    return fluent_ui.FluentTheme(
      data: context.fluentTheme.copyWith(
        scaffoldBackgroundColor: context.colorScheme.backgroundColor,
      ),
      child: WindowsNavView.raw(
        backgroundColor: context.colorScheme.surface,
        appBar: contextInfo.isMobile
            ? fluent_ui.NavigationAppBar(
                title: Text(
                  AppLocalizations.of(context)!.signUpScreenMessage,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: fluent_ui.Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomFilledButton(
                    // fillHeight: true,
                    label: 'complete sign up',
                    backgroundColor: context.colorScheme.primary,
                    labelColor: context.colorScheme.onPrimary,
                    onPressed: () {},
                    iconData: Icons.done,
                  ),
                ),
              )
            : null,
        content: fluent_ui.NavigationBody(
          index: selectedPaneIndex,
          children: [
            CalendarSettingsScreen(
              currentCalendar: _dentistSetupHelper.calendar,
              onCalendarUpdated: (newCal) {
                _dentistSetupHelper.calendar = newCal;
                print(_dentistSetupHelper.calendar);
              },
            ),
            const AppearanceSettingsScreen(),
            if (showDentalServicesTile) fluent_ui.Container(),
          ],
        ),
        navigationPane: _navPane(context, contextInfo, _preferencesListData),
      ),
    );
  }

  fluent_ui.NavigationPane _navPane(
      fluent_ui.BuildContext context,
      ContextInfo contextInfo,
      List<PreferencesListItemData> _preferencesListData) {
    return fluent_ui.NavigationPane(
      selected: selectedPaneIndex,
      indicator: fluent_ui.StickyNavigationIndicator(
        color: context.colorScheme.primary,
      ),
      displayMode: contextInfo.isMobile
          ? fluent_ui.PaneDisplayMode.compact
          : fluent_ui.PaneDisplayMode.open,
      // leading: const CustomBackButton(),
      header: !contextInfo.isMobile
          ? Material(
              type: MaterialType.transparency,
              child: ListTile(
                horizontalTitleGap: 10,
                contentPadding: EdgeInsets.zero,
                leading: const CustomBackButton(),
                title: AutoSizeText(
                  AppLocalizations.of(context)!.signUpScreenMessage,
                  style: context.fluentTextTheme.subtitle,
                ),
              ),
            )
          : null,
      onChanged: (index) {
        setState(() {
          selectedPaneIndex = index;
        });
      },
      items: [
        _PaneSignUpStepsIndicator(),
        // fluent_ui.PaneItemSeparator(),
        _StepTwoSignUoMessage(),
        fluent_ui.PaneItemSeparator(),
        ..._preferencesListData
            .map((e) => fluent_ui.PaneItem(
                  icon: Icon(e.icon),
                  title: Text(e.name),
                  tileColor: fluent_ui.ButtonState.resolveWith((states) {
                    if (states.isHovering) {
                      return context.isDarkMode
                          ? Colors.white10
                          : Colors.black12;
                    }
                    return Colors.transparent;
                  }),
                  selectedTileColor:
                      fluent_ui.ButtonState.resolveWith((states) {
                    if (states.isHovering) {
                      return context.isDarkMode
                          ? Colors.black26
                          : Colors.white60;
                    }
                    return context.isDarkMode
                        ? context.colorScheme.backgroundColor
                        : context.colorScheme.secondaryContainer;
                  }),
                ))
            .toList()
      ],
      footerItems: !contextInfo.isMobile
          ? [
              _CustomPaneButton(
                context: context,
                title: Text(
                  'Complete sign up',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(
                  Icons.done,
                  size: 22,
                  color: context.colorScheme.onPrimary,
                ),
                onTap: () {},
              )
            ]
          : [],
    );
  }
}

class _StepTwoSignUoMessage extends fluent_ui.PaneItemHeader {
  _StepTwoSignUoMessage() : super(header: const fluent_ui.SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return fluent_ui.Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        'Configure your app settings and calendar.',
        style: context.fluentTextTheme.bodyLarge,
      ),
    );
  }
}

class _PaneSignUpStepsIndicator extends fluent_ui.PaneItemHeader {
  _PaneSignUpStepsIndicator()
      : super(header: const fluent_ui.SizedBox.shrink());

  @override
  fluent_ui.Widget build(fluent_ui.BuildContext context) {
    return Card(
      color: context.colorScheme.primaryContainer,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: fluent_ui.Center(
        child: fluent_ui.Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            AppLocalizations.of(context)!.stepTwo,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomPaneButton extends fluent_ui.PaneItem {
  final void Function() onTap;
  _CustomPaneButton({
    required BuildContext context,
    required Widget icon,
    required Widget title,
    required this.onTap,
  }) : super(
          icon: icon,
          title: title,
          tileColor: fluent_ui.ButtonState.resolveWith(
              (states) => context.colorScheme.primary),
        );
  @override
  fluent_ui.Widget build(
    fluent_ui.BuildContext context,
    bool selected,
    fluent_ui.VoidCallback? onPressed, {
    fluent_ui.PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
  }) {
    return fluent_ui.SizedBox(
      height: 50,
      child: fluent_ui.TappableListTile(
        title: fluent_ui.Center(child: title),
        onTap: onPressed,
        tileColor: fluent_ui.ButtonState.resolveWith((states) {
          if (states.isHovering) return context.colorScheme.secondary!;
          return context.colorScheme.primary!;
        }),
      ),
    );
  }
}
