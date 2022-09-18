import 'android_dropdown_menu.dart';
import 'windows_dropdown_menu.dart';
import 'windows_tile_with_dropdown_menu.dart';

import '../custom_widget.dart';
import 'utils.dart';

class AdaptiveLocaleMenu extends CustomStatelessWidget {
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
  Widget customBuild(BuildContext context, WidgetInfo contextInfo) {
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
              )
            : WindowsTileWithDropdownMenu(
                title: title,
                labelText: 'label',
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
