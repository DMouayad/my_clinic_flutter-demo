import 'package:flutter/material.dart';

enum DropdownMenuType { menuOnly, tileWithMenu }

class CustomDropdownMenuItem {
  final void Function()? onPressed;
  final String text;
  final Widget? leading;
  final bool selected;

  const CustomDropdownMenuItem({
    this.onPressed,
    this.leading,
    required this.text,
    required this.selected,
  });
}

abstract class BaseDropdownMenu extends StatelessWidget {
  final List<CustomDropdownMenuItem> items;
  final String title;
  final String? tooltipMessage;
  final void Function(CustomDropdownMenuItem item) onChanged;
  final Widget? leading;
  final IconData? leadingIconData;
  const BaseDropdownMenu({
    required this.title,
    required this.items,
    required this.onChanged,
    required this.tooltipMessage,
    required this.leading,
    required this.leadingIconData,
    Key? key,
  }) : super(key: key);
}
