import 'package:flutter/material.dart';
//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';

import '../../../presentation/shared_widgets/custom_dialogs/windows_custom_dialog.dart';

class AdaptiveDialog extends StatelessWidget {
  const AdaptiveDialog({
    this.title,
    this.titleText,
    this.contentText,
    this.actions,
    this.withOkOptionButton = false,
    this.content,
    this.titleTextColor,
    Key? key,
  }) : super(key: key);

  final String? titleText;
  final Widget? title;
  final String? contentText;
  final Widget? content;
  final List<Widget>? actions;
  final bool withOkOptionButton;
  final Color? titleTextColor;
  @override
  Widget build(BuildContext context) {
    if (context.isWindowsPlatform) {
      return WindowsCustomDialog(
        title: title,
        titleTextColor: titleTextColor,
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
