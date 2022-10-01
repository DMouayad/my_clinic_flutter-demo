import 'package:flutter/material.dart';

enum DropdownMenuType { menuOnly, tileWithMenu }

class CustomDropdownMenuItem<T> {
  final void Function()? onPressed;
  final String text;
  final Widget? leading;
  final bool selected;
  final T value;
  const CustomDropdownMenuItem({
    this.onPressed,
    this.leading,
    required this.value,
    required this.text,
    required this.selected,
  });
}

abstract class BaseDropdownMenu<T> extends StatelessWidget {
  final List<CustomDropdownMenuItem<T>> items;
  final String title;
  final String? tooltipMessage;
  final void Function(CustomDropdownMenuItem<T> item) onChanged;
  final Widget? leading;
  final IconData? leadingIconData;
  final T selectedValue;

  const BaseDropdownMenu({
    required this.title,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.tooltipMessage,
    required this.leading,
    required this.leadingIconData,
    Key? key,
  }) : super(key: key);
}
