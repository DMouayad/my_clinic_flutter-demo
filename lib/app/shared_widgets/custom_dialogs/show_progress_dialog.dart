import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';

import 'adaptive_dialog.dart';

Future<T?> showAdaptiveProgressDialog<T>({
  required BuildContext context,
  Widget? content,
  String? contentText,
  bool dismissible = false,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (context) {
      return AdaptiveDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (content != null) content,
            if (contentText != null) Text(contentText),
            context.isWindowsPlatform
                ? fluent_ui.ProgressRing()
                : CircularProgressIndicator(),
          ],
        ),
      );
    },
  );
}
