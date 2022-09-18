import 'package:flutter/material.dart';
//
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';

class WindowsCustomDialog extends StatelessWidget {
  const WindowsCustomDialog({
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
    return fluent_ui.ContentDialog(
      style: fluent_ui.ContentDialogThemeData(
        barrierColor: context.colorScheme.backgroundColor,
      ),
      title: Text(
        titleText,
        style: context.fluentTextTheme.title?.copyWith(
          color: context.colorScheme.errorColor,
        ),
      ),
      content: () {
        return content ??
            ((contentText != null)
                ? Text(
                    contentText!,
                    style: context.textTheme.titleMedium?.copyWith(
                      // color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null);
      }(),
      actions: [
        if (withOkOptionButton)
          fluent_ui.FilledButton(
              child: Text(
                context.localizations!.ok,
                style: context.fluentTextTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ...actions,
      ],
    );
  }
}
