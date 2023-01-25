import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({
    Key? key,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
  }) : super(key: key);
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      context.localizations!.myClinic,
      style: context.textTheme.headline6?.copyWith(
        letterSpacing: 1,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: fontColor ?? context.colorScheme.onBackground,
      ),
    );
  }
}
