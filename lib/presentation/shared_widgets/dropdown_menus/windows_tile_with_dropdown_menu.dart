import 'package:fluent_ui/fluent_ui.dart';
//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import '../../../presentation/shared_widgets/windows_components/windows_tile.dart';
import '../../../presentation/shared_widgets/dropdown_menus/utils.dart';

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
    this.dropdownPadding,
  });
  final EdgeInsets? dropdownPadding;

  @override
  Widget build(BuildContext context) {
    final dropDownMenuSize = Size(context.screenWidth * .3, 66);
    return WindowsTile(
      tileLabel: tileLabel!,
      subtitleText: title,
      leading: tileLeadingIconData != null ? Icon(tileLeadingIconData) : null,
      childSize: dropdownSize ?? dropDownMenuSize,
      child: FluentTheme(
        data: context.fluentTheme.copyWith(),
        child: Container(
          constraints: BoxConstraints.loose(
            dropdownSize ?? dropDownMenuSize,
          ),
          padding: dropdownPadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
