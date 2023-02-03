import 'package:flutter/material.dart';

import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'adaptive_dialog.dart';

Future<T?> showAdaptiveAlertDialog<T>({
  required BuildContext context,
  required String titleText,
  Widget? content,
  String? contentText,
  String? confirmText,
  String? cancelText,
  Color? titleTextColor,
  bool useRootNavigator = true,
}) async {
  List<Widget> _getActions(BuildContext context) {
    List<Widget> actions = [
      TextButton(
        child: Text(
          cancelText ?? context.localizations!.cancel,
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.onBackground,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      if (confirmText != null)
        TextButton(
          child: Text(
            confirmText,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.errorColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
    ];
    return context.isWindowsPlatform ? actions.reversed.toList() : actions;
  }

  return await showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      return AdaptiveDialog(
        type: DialogType.alert,
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
              const SizedBox(height: 20),
              Text(
                titleText,
                style: TextStyle(
                  color: titleTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        contentText: contentText,
        content: content,
        actions: _getActions(context),
      );
    },
  );
}
