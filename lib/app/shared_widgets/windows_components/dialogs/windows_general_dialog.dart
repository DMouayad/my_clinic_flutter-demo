import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/custom_dialogs/windows_custom_dialog.dart';
import 'package:flutter/material.dart';

import '../../custom_buttons/custom_icon_button.dart';

Future<T?> showWindowsGeneralDialog<T>({
  required BuildContext context,
  required String titleText,
  required Widget content,
  Color? titleTextColor,
}) async {
  return await showDialog<T>(
    context: context,
    builder: (context) {
      return WindowsCustomDialog(
        titleText: titleText,
        content: content,
        constraintsBuilder: (widgetInfo) => BoxConstraints.tight(
          Size(
            widgetInfo.widgetSize.width *
                (context.isTablet
                    ? .7
                    : context.isMobile
                        ? .8
                        : .5),
            widgetInfo.widgetSize.height * .7,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleText,
              style: context.fluentTextTheme.title?.copyWith(
                color: titleTextColor ?? context.colorScheme.onPrimaryContainer,
              ),
            ),
            CustomIconButton(
              tooltipMessage: context.localizations!.close,
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                size: 24,
                color: Colors.red.shade400,
              ),
            ),
          ],
        ),
      );
    },
  );
}
