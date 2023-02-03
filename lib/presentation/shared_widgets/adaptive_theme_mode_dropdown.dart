import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/dropdown_menus/adaptive_dropdown.dart';
import 'package:flutter/material.dart';

import '../../presentation/shared_widgets/dropdown_menus/utils.dart';

class AdaptiveThemeModeDropdown extends StatelessWidget {
  const AdaptiveThemeModeDropdown({
    required this.onChanged,
    required this.type,
    Key? key,
  }) : super(key: key);

  final DropdownMenuType type;
  final void Function(ThemeMode themeMode) onChanged;

  @override
  Widget build(BuildContext context) {
    return AdaptiveDropdown<ThemeMode>(
      type: type,
      dropdownSize: context.isMobile
          ? const Size.fromWidth(double.infinity)
          : const Size.fromWidth(150),
      selectedValue: context.themeMode,
      title: context.localizations!.selectThemeMode,
      tooltipMessage: context.localizations!.selectThemeMode,
      tileLabel: context.localizations!.themeModeSettings,
      tileLeadingIconData: Icons.color_lens_outlined,
      items: ThemeMode.values
          .map((e) => CustomDropdownMenuItem<ThemeMode>(
                value: e,
                text: context.themeModeName(e),
                selected: e == context.themeMode,
              ))
          .toList(),
      onChanged: (item) => onChanged(item.value),
    );
  }
}
