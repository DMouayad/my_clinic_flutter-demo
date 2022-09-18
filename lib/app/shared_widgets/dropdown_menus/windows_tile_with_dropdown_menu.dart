import 'package:fluent_ui/fluent_ui.dart';
//
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import '../windows_components/windows_settings_tile.dart';
import 'utils.dart';

class WindowsTileWithDropdownMenu extends BaseDropdownMenu {
  const WindowsTileWithDropdownMenu({
    required this.labelText,
    required String title,
    required List<CustomDropdownMenuItem> items,
    required void Function(CustomDropdownMenuItem item) onChanged,
    String? tooltipMessage,
    this.selectedItem,
    Widget? leading,
    IconData? leadingIconData,
    Key? key,
  }) : super(
          key: key,
          title: title,
          items: items,
          onChanged: onChanged,
          tooltipMessage: tooltipMessage,
          leading: leading,
          leadingIconData: leadingIconData,
        );

  final String labelText;
  final CustomDropdownMenuItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return WindowsSettingTile(
      tileLabel: labelText,
      leadingIcon: Icon(
        leadingIconData,
        color: context.colorScheme.onBackground,
      ),
      titleText: title,
      trailing: SizedBox(
        width: 300,
        child: FluentTheme(
          data: context.fluentTheme.copyWith(
            buttonTheme: ButtonThemeData.all(
              ButtonStyle(backgroundColor: ButtonState.resolveWith((states) {
                if (states.isHovering) {
                  return context.colorScheme.secondary;
                }
              })),
            ),
          ),
          child: Combobox<CustomDropdownMenuItem>(
            itemHeight: 52,
            comboboxColor: context.colorScheme.secondary,
            // icon: Icon( FluentIcons.),
            // focusColor: context.colorScheme.secondary,
            onChanged: (selectedValue) {
              if (selectedValue != selectedItem && selectedValue != null) {
                onChanged(selectedValue);
              }
            },
            value: selectedItem,
            isExpanded: true,
            items: items
                .map((item) => ComboboxItem(
                      value: item,
                      child: Text(
                        item.text,
                        style: context.textTheme.labelLarge,
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
