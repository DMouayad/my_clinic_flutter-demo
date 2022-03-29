import 'package:clinic_v2/app/infrastructure/themes/app_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Widget iconWidget;
  final double labelFontSize;
  const CustomTextButton({
    required this.label,
    required this.onPressed,
    required this.iconWidget,
    this.labelFontSize = 16,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: iconWidget,
      label: Text(
        label,
        style: context.textTheme.subtitle1?.copyWith(
          fontSize: labelFontSize,
          color: context.colorScheme.onBackground,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
