part of 'large_step_two_sign_up_screen.dart';

//
class _DesktopStepTwoSignUpScreen extends StatefulWidget {
  const _DesktopStepTwoSignUpScreen({Key? key}) : super(key: key);
  @override
  State<_DesktopStepTwoSignUpScreen> createState() =>
      _DesktopStepTwoSignUpScreenState();
}

class _DesktopStepTwoSignUpScreenState
    extends StateWithResponsiveBuilder<_DesktopStepTwoSignUpScreen> {
  int selectedPaneIndex = 0;
  Widget content = const SizedBox.shrink();

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
      child: WindowsNavView.onlyPane(
        backgroundColor: context.colorScheme.surface,
        content: fluent_ui.NavigationBody(
          index: selectedPaneIndex,
          children: [
            fluent_ui.Container(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: AppearanceSettingsScreen(),
            ),
            if (showDentalServicesTile) fluent_ui.Container(),
          ],
        ),
        navigationPane: _navPane(context, _preferencesListData),
      ),
    );
  }

  fluent_ui.NavigationPane _navPane(fluent_ui.BuildContext context,
      List<PreferencesListItemData> _preferencesListData) {
    return fluent_ui.NavigationPane(
      selected: selectedPaneIndex,
      indicator: fluent_ui.EndNavigationIndicator(
        color: context.colorScheme.primary,
      ),
      displayMode: fluent_ui.PaneDisplayMode.open,
      header: Material(
        type: MaterialType.transparency,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CustomBackButton(),
          title: Text(
            AppLocalizations.of(context)!.signUpScreenMessage,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      onChanged: (index) {
        setState(() {
          selectedPaneIndex = index;
        });
      },
      items: [
        fluent_ui.PaneItemSeparator(),
        fluent_ui.PaneItemHeader(
            header: Text(''
                // AppLocalizations.of(context)!.,
                )),
        ..._preferencesListData
            .map((e) => fluent_ui.PaneItem(
                  icon: Icon(e.icon),
                  title: Text(e.name),
                ))
            .toList()
      ],
      footerItems: [
        _CustomPaneButton(
          context: context,
          title: Text(
            'Complete sign up',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
          icon: Icon(
            Icons.done,
            size: 22,
            color: context.colorScheme.onPrimary,
          ),
          onTap: () {},
        )
      ],
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
    return fluent_ui.NavigationPaneTheme(
      data: fluent_ui.NavigationPaneThemeData(
        unselectedTextStyle:
            fluent_ui.ButtonState.all(context.textTheme.titleLarge?.copyWith(
          color: context.colorScheme.onPrimary,
        )),
      ),
      child: super.build(
        context,
        true,
        onTap,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        autofocus: autofocus,
      ),
    );
  }
}
