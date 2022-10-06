import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'android_dropdown_menu.dart';
import 'utils.dart';
import 'windows_dropdown_menu.dart';
import 'windows_tile_with_dropdown_menu.dart';

class AdaptiveDropdown<T> extends BaseDropdownMenu<T> {
  const AdaptiveDropdown({
    required this.type,
    required super.selectedValue,
    required super.title,
    required super.tooltipMessage,
    required super.items,
    required super.onChanged,
    super.dropdownSize,
    super.tileLabel,
    super.tileLeadingIconData,
    Key? key,
  })  : assert(type == DropdownMenuType.tileWithMenu &&
            tileLabel != null &&
            tileLeadingIconData != null),
        super(key: key);

  final DropdownMenuType type;

  @override
  Widget build(BuildContext context) {
    return context.isDesktopPlatform
        ? type == DropdownMenuType.menuOnly
            ? WindowsDropdownMenu<T>(
                title: title,
                items: items,
                selectedValue: selectedValue,
                dropdownSize: dropdownSize,
                onChanged: onChanged,
                tooltipMessage: tooltipMessage,
              )
            : WindowsTileWithDropdownMenu<T>(
                title: title,
                selectedValue: selectedValue,
                tileLabel: tileLabel!,
                dropdownSize: dropdownSize,
                tooltipMessage: tooltipMessage,
                onChanged: onChanged,
                items: items,
                tileLeadingIconData: tileLeadingIconData,
              )
        : AndroidDropdownMenu<T>(
            type: type,
            selectedValue: selectedValue,
            tileLeadingIconData: tileLeadingIconData,
            dropdownSize: dropdownSize,
            tooltipMessage: tooltipMessage,
            title: title,
            items: items,
            onChanged: onChanged,
          );
  }
}
