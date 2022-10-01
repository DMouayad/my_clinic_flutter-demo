import 'package:fluent_ui/fluent_ui.dart';
//
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import '../windows_components/windows_settings_tile.dart';
import 'utils.dart';

class WindowsTileWithDropdownMenu<T> extends BaseDropdownMenu<T> {
  const WindowsTileWithDropdownMenu({
    required this.labelText,
    required super.selectedValue,
    required super.items,
    super.leading,
    super.leadingIconData,
    required super.onChanged,
    required super.title,
    super.tooltipMessage,
    super.key,
  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return WindowsTile(
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
            checkboxTheme: CheckboxThemeData(
              uncheckedDecoration: ButtonState.all(
                BoxDecoration(color: Colors.red),
              ),
            ),
          ),
          child: ComboBox<CustomDropdownMenuItem<T>>(
            popupColor: context.colorScheme.primary,
            value: items.firstWhere((e) => e.value == selectedValue),
            onChanged: (selected) {
              if (selected?.value != null && selected?.value != selectedValue) {
                onChanged(selected!);
              }
            },
            isExpanded: true,
            items: items
                .map((item) => ComboBoxItem(
                      value: item,
                      child: Text(
                        item.text,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
