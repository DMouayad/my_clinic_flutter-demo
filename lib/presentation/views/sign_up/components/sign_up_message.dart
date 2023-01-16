import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SignUpMessage extends StatelessWidget {
  const SignUpMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.localizations!.signUpScreenMessage,
      textAlign: TextAlign.start,
      style: context.isDesktop
          ? context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onBackground,
            )
          : context.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onBackground,
            ),
    );
  }
}
