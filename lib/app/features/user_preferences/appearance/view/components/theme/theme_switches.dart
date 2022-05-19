// import 'package:clinic_v2/app/base/responsive/responsive.dart';
part of 'theme_mode_switch.dart';

class _ThemeSwitchTile extends Component {
  const _ThemeSwitchTile({
    required this.onThemeModeChanged,
    required this.themeIcon,
    Key? key,
  }) : super(key: key);

  final Widget themeIcon;
  final void Function() onThemeModeChanged;

  @override
  Widget? windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return WindowsSettingTile(
      tileLabel: 'Theme',
      leadingIcon: themeIcon,
      titleText: AppLocalizations.of(context)!.darkMode,
      trailing: WindowsToggleSwitch(
        checked: context.isDarkMode,
        onChanged: (_) => onThemeModeChanged(),
      ),
    );
  }

  @override
  Widget builder(BuildContext context, contextInfo) {
    return SwitchListTile.adaptive(
      value: context.isDarkMode,
      title: Text(
        AppLocalizations.of(context)!.darkMode,
        style: context.textTheme.subtitle1,
      ),
      // contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      secondary: themeIcon,
      subtitle: Text(
        context.isDarkMode
            ? AppLocalizations.of(context)!.enabled
            : AppLocalizations.of(context)!.disabled,
        style: context.textTheme.bodyText2?.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
      activeColor: context.colorScheme.primary,
      onChanged: (_) => onThemeModeChanged(),
    );
  }
}

class _ThemeSwitchIcon extends Component {
  const _ThemeSwitchIcon({
    required this.icon,
    required this.onThemeModeChanged,
    Key? key,
  }) : super(key: key);

  final void Function() onThemeModeChanged;
  final Widget icon;

  @override
  Widget? windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return fluent_ui.Tooltip(
      message: AppLocalizations.of(context)!.enableDarkTheme,
      child: fluent_ui.IconButton(
        icon: icon,
        onPressed: onThemeModeChanged,
      ),
    );
  }

  @override
  Widget? mobileBuilder(BuildContext context, ContextInfo contextInfo) {
    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: Theme.of(context).copyWith(
          tooltipTheme:
              MaterialAppThemes.getTooltipThemeDataForDesktop(context),
        ),
        child: IconButton(
          tooltip: context.isDarkMode
              ? AppLocalizations.of(context)!.enableLightTheme
              : AppLocalizations.of(context)!.enableDarkTheme,
          icon: icon,
          onPressed: onThemeModeChanged,
        ),
      ),
    );
  }
}
