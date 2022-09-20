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
  void _onLocaleChanged(CustomDropdownMenuItem item) {
    onChanged(Locale(item.text));
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final title = AppLocalizations.of(context)?.language ?? 'Language';
    final items = AppLocalizations.supportedLocales
        .map((e) => CustomDropdownMenuItem(
              text: e.languageCode,
              selected: e == currentLocale,
              leading: const Icon(Icons.language_outlined),
            ))
        .toList();
    final selectedItem = CustomDropdownMenuItem(
      text: currentLocale.languageCode,
      selected: true,
    );
    return context.isDesktopPlatform
        ? type == DropdownMenuType.menuOnly
            ? WindowsDropdownMenu(
                title: title,
                items: items,
                onChanged: _onLocaleChanged,
                tooltipMessage: context.localizations!.selectAppLang,
              )
            : WindowsTileWithDropdownMenu(
                title: title,
                labelText: 'label',
                tooltipMessage: context.localizations!.selectAppLang,
                onChanged: _onLocaleChanged,
                selectedItem: selectedItem,
                items: items,
              )
        : AndroidDropdownMenu(
            type: type,
            leading: const Icon(Icons.language_outlined),
            title: title,
            items: items,
            selectedItem: selectedItem,
            onChanged: _onLocaleChanged,
          );
  }
}
