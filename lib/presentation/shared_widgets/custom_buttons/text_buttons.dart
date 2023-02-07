import 'package:flutter/material.dart';
//
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';

abstract class _BaseTextButton extends StatelessWidget {
  const _BaseTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.labelFontSize = 14,
    this.labelColor,
    this.labelColorOnHover,
    this.backgroundColorOnHover,
  }) : super(key: key);

  final String label;
  final void Function() onPressed;
  final double labelFontSize;
  final Color? labelColor;
  final Color? labelColorOnHover;
  final Color? backgroundColorOnHover;

  TextStyle? getTextStyle(BuildContext context) {
    TextStyle? textStyle = context.isWindowsPlatform
        ? context.fluentTextTheme.title?.copyWith(
            fontSize: labelFontSize,
            color: labelColor,
            fontWeight: FontWeight.bold,
          )
        : context.textTheme.titleMedium?.copyWith(
            fontSize: labelFontSize,
            color: labelColor,
            fontWeight: FontWeight.bold,
          );

    return textStyle;
  }
}

class AdaptiveTextButton extends _BaseTextButton {
  const AdaptiveTextButton({
    required super.label,
    required super.onPressed,
    super.backgroundColorOnHover,
    super.labelColorOnHover,
    super.labelFontSize = 16,
    super.labelColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isWindowsPlatform) {
      return _WindowsTextButton(
        label: label,
        onPressed: onPressed,
        labelColor: labelColor,
        labelColorOnHover: labelColorOnHover,
        labelFontSize: labelFontSize,
        backgroundColorOnHover: backgroundColorOnHover ?? Colors.grey.shade300,
      );
    }
    if (context.isAndroidPlatform) {
      return _AndroidTextButton(
        label: label,
        onPressed: onPressed,
        labelColor: labelColor,
        labelColorOnHover: labelColorOnHover,
        labelFontSize: labelFontSize,
        backgroundColorOnHover: backgroundColorOnHover,
      );
    }
    throw UnimplementedError();
  }
}

class _WindowsTextButton extends _BaseTextButton {
  const _WindowsTextButton({
    required super.label,
    required super.onPressed,
    super.backgroundColorOnHover,
    super.labelColorOnHover,
    super.labelFontSize = 16,
    super.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return fluent_ui.TextButton(
      onPressed: onPressed,
      style: fluent_ui.ButtonStyle(
        backgroundColor: fluent_ui.ButtonState.resolveWith((states) {
          if (states.isHovering) {
            return backgroundColorOnHover;
          }
        }),
        textStyle: fluent_ui.ButtonState.resolveWith((states) {
          var textStyle = getTextStyle(context);
          if (states.contains(fluent_ui.ButtonStates.hovering)) {
            textStyle?.copyWith(color: labelColorOnHover);
          }
          return textStyle;
        }),
      ),
      child: Text(
        label,
        style: getTextStyle(context),
      ),
    );
  }
}

class _AndroidTextButton extends _BaseTextButton {
  const _AndroidTextButton({
    required super.label,
    required super.onPressed,
    super.backgroundColorOnHover,
    super.labelColorOnHover,
    super.labelFontSize = 16,
    super.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith((states) {
          var textStyle = getTextStyle(context);
          if (states.contains(MaterialState.hovered)) {
            textStyle?.copyWith(color: labelColorOnHover);
          }
          return textStyle;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return backgroundColorOnHover;
          }
        }),
      ),
      child: Text(label),
    );
  }
}
