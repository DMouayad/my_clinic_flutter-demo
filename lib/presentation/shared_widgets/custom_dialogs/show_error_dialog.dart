import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
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
        type: DialogType.error,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: context.isMobile ? 26 : 40,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              titleText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: titleTextColor ?? context.colorScheme.errorColor),
            ),
          ],
        ),
        contentText: contentText,
        content: content,
        actions: [
          TextButton(
            style: ButtonStyle(
              maximumSize: MaterialStateProperty.all(Size.fromWidth(100)),
            ),
            child: Text(context.localizations!.ok),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
}
