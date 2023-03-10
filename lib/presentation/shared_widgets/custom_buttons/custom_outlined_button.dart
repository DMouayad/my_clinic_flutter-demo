import 'package:flutter/material.dart';
//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.iconData,
    this.maximumSize,
    this.fixedSize,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;
  final IconData? iconData;
  final Size? maximumSize;
  final Size? fixedSize;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            width: 1.5,
            color: context.isDarkMode
                ? context.colorScheme.primaryContainer!
                : context.colorScheme.onBackground!.withOpacity(.2),
          ),
        ),
        splashFactory: NoSplash.splashFactory,
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(16, 0, 24, 0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      label: Text(
        label,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onPrimaryContainer,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(
        iconData,
        size: 18,
        color: context.colorScheme.onPrimaryContainer,
      ),
    );
  }
}
