import 'package:flutter/material.dart';

import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import '../custom_buttons/filled_buttons.dart';
import 'adaptive_dialog.dart';

Future<T?> showAdaptiveErrorDialog<T>({
  required BuildContext context,
  required String titleText,
  Widget? content,
  String? contentText,
  Color? titleTextColor,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AdaptiveDialog(
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: context.isMobile ? 26 : 40,
                color: Colors.red.shade400,
              ),
              const SizedBox(height: 20),
              Text(
                titleText,
                style: TextStyle(
                    color: titleTextColor ?? context.colorScheme.errorColor),
              ),
            ],
          ),
        ),
        contentText: contentText,
        content: content,
        actions: [
          AdaptiveFilledButton(
            backgroundColor: context.colorScheme.secondaryContainer,
            labelColor: context.colorScheme.onBackground,
            label: context.localizations!.ok,
            fillWidth: true,
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
}
