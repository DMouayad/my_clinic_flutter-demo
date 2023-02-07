import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
//
import '../../../presentation/shared_widgets/windows_components/windows_tile.dart';
import '../../../presentation/shared_widgets/windows_components/windows_toggle_switch.dart';

class AdaptiveSwitchTile extends StatelessWidget {
  const AdaptiveSwitchTile({
    required this.value,
    required this.label,
    required this.onChanged,
    required this.icon,
    required this.description,
    Key? key,
  }) : super(key: key);

  final bool value;
  final Widget icon;
  final void Function(bool value) onChanged;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return context.isWindowsPlatform
        ? windowsBuilder(context)
        : defaultBuilder(context);
  }

  Widget windowsBuilder(BuildContext context) {
    return WindowsTile(
      tileLabel: label,
      leading: icon,
      subtitleText: description,
      subtitle: Text(
        value
            ? context.localizations!.enabled
            : context.localizations!.disabled,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
      child: WindowsToggleSwitch(
        checked: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget defaultBuilder(BuildContext context) {
    return SwitchListTile.adaptive(
      value: value,
      title: Text(
        description,
        style: context.textTheme.titleMedium,
      ),
      // contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      secondary: icon,
      subtitle: Text(
        value
            ? context.localizations!.enabled
            : context.localizations!.disabled,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
      activeColor: context.colorScheme.primary,
      onChanged: onChanged,
    );
  }
}
