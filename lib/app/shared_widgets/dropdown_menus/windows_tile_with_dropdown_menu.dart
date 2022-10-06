import 'package:fluent_ui/fluent_ui.dart';
//
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import '../windows_components/windows_tile.dart';
import 'utils.dart';

class WindowsTileWithDropdownMenu<T> extends BaseDropdownMenu<T> {
  const WindowsTileWithDropdownMenu({
    super.tileLeadingIconData,
    super.dropdownSize,
    required super.selectedValue,
    required super.items,
    required super.tileLabel,
    required super.onChanged,
    required super.title,
    required super.tooltipMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowsTile(
      tileLabel: tileLabel!,
      subtitleText: title,
      leading: tileLeadingIconData != null ? Icon(tileLeadingIconData) : null,
      childSize: dropdownSize ?? Size(context.screenWidth * .3, 66),
      child: FluentTheme(
        data: context.fluentTheme.copyWith(),
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(
            dropdownSize ?? Size(context.screenWidth * .3, 66),
          ),
          child: ComboBox<CustomDropdownMenuItem<T>>(
            popupColor: Colors.transparent,
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
                          color: context.colorScheme.onPrimaryContainer,
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
