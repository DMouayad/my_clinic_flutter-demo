import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../presentation/shared_widgets/dropdown_menus/android_dropdown_menu.dart';
import '../../presentation/shared_widgets/dropdown_menus/windows_dropdown_menu.dart';
import '../../presentation/shared_widgets/dropdown_menus/windows_tile_with_dropdown_menu.dart';

import '../../presentation/shared_widgets/dropdown_menus/utils.dart';

class AdaptiveLocaleDropdown extends StatelessWidget {
  const AdaptiveLocaleDropdown({
    required this.onChanged,
    required this.type,
    Key? key,
  }) : super(key: key);

  final DropdownMenuType type;
  final void Function(Locale locale) onChanged;
  void _onLocaleChanged(CustomDropdownMenuItem<Locale> item) {
    onChanged(item.value);
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final title = context.localizations?.selectAppLang ?? 'App Language';
    final items = AppLocalizations.supportedLocales
        .map((e) => CustomDropdownMenuItem<Locale>(
              value: e,
              text: context.getLocaleFullName(e),
              selected: e == currentLocale,
              leading: const Icon(Icons.language_outlined),
            ))
        .toList();
    const dropdownSize = Size.fromWidth(150);

    return context.isDesktopPlatform
        ? type == DropdownMenuType.menuOnly
            ? WindowsDropdownMenu<Locale>(
                dropdownSize: dropdownSize,
                title: context.localizations!.language,
                items: items,
                selectedValue: currentLocale,
                onChanged: _onLocaleChanged,
                tooltipMessage: context.localizations!.selectAppLang,
              )
            : WindowsTileWithDropdownMenu<Locale>(
                title: title,
                selectedValue: currentLocale,
                dropdownSize: dropdownSize,
                tileLabel: context.localizations!.language,
                tooltipMessage: context.localizations!.selectAppLang,
                onChanged: _onLocaleChanged,
                items: items,
                tileLeadingIconData: FontAwesome5Solid.globe,
              )
        : AndroidDropdownMenu<Locale>(
            dropdownSize: dropdownSize,
            type: type,
            tooltipMessage: context.localizations!.selectAppLang,
            selectedValue: currentLocale,
            tileLeadingIconData: Icons.language_outlined,
            title: title,
            items: items,
            onChanged: _onLocaleChanged,
          );
  }
}
