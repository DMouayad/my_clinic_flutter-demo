import 'package:flutter_vector_icons/flutter_vector_icons.dart';

//
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import '../../presentation/shared_widgets/dropdown_menus/utils.dart';
import 'dropdown_menus/adaptive_dropdown.dart';

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
    final title = type == DropdownMenuType.menuOnly
        ? currentLocale.languageCode
        : context.localizations?.selectAppLang ?? 'App Language';
    final items = AppLocalizations.supportedLocales
        .map((e) => CustomDropdownMenuItem<Locale>(
              value: e,
              text: context.getLocaleFullName(e),
              selected: e == currentLocale,
              leading: const Icon(Icons.language_outlined),
            ))
        .toList();
    final dropdownSize = context.isMobile
        ? const Size.fromWidth(double.infinity)
        : const Size.fromWidth(150);

    return AdaptiveDropdown<Locale>(
      type: type,
      dropdownSize: dropdownSize,
      title: title,
      items: items,
      tileLabel: context.localizations!.language,
      selectedValue: currentLocale,
      onChanged: _onLocaleChanged,
      tooltipMessage: context.localizations!.selectAppLang,
      tileLeadingIconData: FontAwesome5Solid.globe,
    );
  }
}
