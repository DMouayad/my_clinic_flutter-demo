import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'android_dropdown_menu.dart';
import 'windows_dropdown_menu.dart';
import 'windows_tile_with_dropdown_menu.dart';

import '../custom_widget.dart';
import 'utils.dart';

class AdaptiveLocaleMenu extends StatelessWidget {
  const AdaptiveLocaleMenu({
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
    final title = AppLocalizations.of(context)?.selectAppLang ?? 'App Language';
    final items = AppLocalizations.supportedLocales
        .map((e) => CustomDropdownMenuItem<Locale>(
              value: e,
              text: context.getLocaleFullName(e),
              selected: e == currentLocale,
              leading: const Icon(Icons.language_outlined),
            ))
        .toList();
    // final selectedItem = CustomDropdownMenuItem(
    //   text: currentLocale.languageCode,
    //   selected: true,
    // );
    return context.isDesktopPlatform
        ? type == DropdownMenuType.menuOnly
            ? WindowsDropdownMenu<Locale>(
                title: context.localizations!.language,
                items: items,
                selectedValue: currentLocale,
                onChanged: _onLocaleChanged,
                tooltipMessage: context.localizations!.selectAppLang,
              )
            : WindowsTileWithDropdownMenu<Locale>(
                title: title,
                selectedValue: currentLocale,
                labelText: context.localizations!.language,
                tooltipMessage: context.localizations!.selectAppLang,
                onChanged: _onLocaleChanged,
                // selectedItem: items.firstWhere((element) => element.selected),
                items: items,
                leadingIconData: FontAwesome5Solid.globe,
              )
        : AndroidDropdownMenu(
            type: type,
            selectedValue: currentLocale,
            leading: const Icon(Icons.language_outlined),
            title: title,
            items: items,
            onChanged: _onLocaleChanged,
          );
  }
}
