import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AdaptiveTextIconButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Widget iconWidget;
  final double labelFontSize;
  final Color? labelColor;
  const AdaptiveTextIconButton({
    required this.label,
    required this.onPressed,
    required this.iconWidget,
    this.labelFontSize = 16,
    this.labelColor,
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
          color: labelColor ?? context.colorScheme.onBackground,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
