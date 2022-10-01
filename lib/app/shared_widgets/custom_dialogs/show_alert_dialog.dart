import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../custom_buttons/filled_buttons.dart';
import 'adaptive_dialog.dart';

Future<T?> showAdaptiveAlertDialog<T>({
  required BuildContext context,
  required String titleText,
  Widget? content,
  String? contentText,
  required String confirmText,
  String? cancelText,
  Color? titleTextColor,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AdaptiveDialog(
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: context.isMobile ? 26 : 40,
                color: Colors.red.shade400,
              ),
              const SizedBox(height: 30),
              Text(
                titleText,
                style: TextStyle(color: titleTextColor),
              ),
            ],
          ),
        ),
        contentText: contentText,
        content: content,
        actions: [
          AdaptiveFilledButton(
            backgroundColor: context.colorScheme.errorColor,
            labelColor: context.colorScheme.onError,
            label: confirmText,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          AdaptiveFilledButton(
            backgroundColor: context.colorScheme.secondaryContainer,
            labelColor: context.colorScheme.onBackground,
            label: cancelText ?? context.localizations!.cancel,
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
}
