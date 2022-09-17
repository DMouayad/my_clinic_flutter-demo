import '../custom_widget/custom_widget.dart';
import '../windows_components/windows_settings_tile.dart';
import '../windows_components/windows_toggle_switch.dart';

class ThemeTileSwitch extends CustomStatelessWidget {
  const ThemeTileSwitch({
    required this.onThemeModeChanged,
    required this.themeIcon,
    Key? key,
  }) : super(key: key);

  final Widget themeIcon;
  final void Function() onThemeModeChanged;

  @override
  Widget? windowsBuilder(BuildContext context, ContextInfo contextInfo) {
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
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
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
