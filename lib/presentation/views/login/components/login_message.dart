import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LoginMessage extends StatelessWidget {
  const LoginMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.localizations!.loginScreenMessage,
      textAlign: TextAlign.start,
      style: context.textTheme.headline6?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onBackground,
      ),
    );
  }
}
