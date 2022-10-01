import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

class AndroidDropdownMenu<T> extends BaseDropdownMenu<T> {
  const AndroidDropdownMenu({
    required this.type,
    required super.leading,
    required super.title,
    required super.items,
    required super.onChanged,
    required super.selectedValue,
    super.tooltipMessage,
    super.key,
  }) : super(
          leadingIconData: null,
        );
  final DropdownMenuType type;

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
      child: DropdownButton<CustomDropdownMenuItem<T>>(
        icon: showIcon ? null : const SizedBox.shrink(),
        elevation: 4,
        dropdownColor: context.colorScheme.backgroundColor,
        iconEnabledColor: context.colorScheme.onPrimaryContainer,
        style: context.textTheme.subtitle1?.copyWith(
          color: context.colorScheme.onPrimary,
        ),
        value: items.firstWhere((e) => e.value == selectedValue),
        items: items
            .map((item) => DropdownMenuItem<CustomDropdownMenuItem<T>>(
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
          if (value != null && value != selectedValue) {
            onChanged(value);
          }
        },
      ),
    );
  }
}
