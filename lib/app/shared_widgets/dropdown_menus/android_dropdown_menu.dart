import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

class AndroidDropdownMenu extends BaseDropdownMenu {
  const AndroidDropdownMenu({
    required this.type,
    required Widget leading,
    required String title,
    required List<CustomDropdownMenuItem> items,
    required void Function(CustomDropdownMenuItem item) onChanged,
    String? tooltipMessage,
    this.selectedItem,
    Key? key,
  }) : super(
          key: key,
          title: title,
          items: items,
          onChanged: onChanged,
          tooltipMessage: tooltipMessage,
          leading: leading,
          leadingIconData: null,
        );
  final DropdownMenuType type;
  final CustomDropdownMenuItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return type == DropdownMenuType.menuOnly
        ? _dropDownLocaleMenu(context)
        : ListTile(
            leading: leading,
            title: Text(title),
            subtitle: _dropDownLocaleMenu(context, showIcon: false),
          );
  }

  Widget _dropDownLocaleMenu(BuildContext context, {bool showIcon = true}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<CustomDropdownMenuItem>(
        icon: showIcon ? null : const SizedBox.shrink(),
        elevation: 4,
        dropdownColor: context.colorScheme.backgroundColor,
        iconEnabledColor: context.colorScheme.onPrimaryContainer,
        style: context.textTheme.subtitle1?.copyWith(
          color: context.colorScheme.onPrimary,
        ),
        value: selectedItem,
        items: items
            .map((item) => DropdownMenuItem<CustomDropdownMenuItem>(
                  value: item,
                  child: Text(
                    item.text,
                    style: context.textTheme.bodyText1?.copyWith(
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null && value != selectedItem) {
            onChanged(value);
          }
        },
      ),
    );
  }
}
