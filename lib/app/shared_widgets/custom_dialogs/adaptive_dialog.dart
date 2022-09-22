import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';

import 'windows_custom_dialog.dart';

class AdaptiveDialog extends StatelessWidget {
  const AdaptiveDialog({
    required this.titleText,
    this.contentText,
    this.actions = const [],
    this.withOkOptionButton = false,
    this.content,
    Key? key,
  }) : super(key: key);

  final String titleText;
  final String? contentText;
  final Widget? content;
  final List<Widget> actions;
  final bool withOkOptionButton;

  @override
  Widget build(BuildContext context) {
    if (context.isWindowsPlatform) {
      return WindowsCustomDialog(
        titleText: titleText,
        contentText: contentText,
        content: content,
        actions: actions,
        withOkOptionButton: withOkOptionButton,
      );
    } else {
      return Container();
    }
  }
}
