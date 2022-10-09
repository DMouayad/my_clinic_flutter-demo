import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
//
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';

class WindowsCustomDialog extends StatelessWidget {
  const WindowsCustomDialog({
    this.titleText,
    this.title,
    this.contentText,
    this.actions,
    this.withOkOptionButton = false,
    this.content,
    this.titleTextColor,
    this.constraintsBuilder,
    Key? key,
  }) : super(key: key);

  final String? titleText;
  final Widget? title;
  final String? contentText;
  final Widget? content;
  final List<Widget>? actions;
  final bool withOkOptionButton;
  final Color? titleTextColor;
  final BoxConstraints? Function(WidgetInfo widgetInfo)? constraintsBuilder;

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(builder: (context, widgetInfo) {
      return fluent_ui.ContentDialog(
        constraints: () {
          const defaultConstraints = BoxConstraints(maxWidth: 368);
          if (constraintsBuilder != null) {
            return constraintsBuilder!(widgetInfo) ?? defaultConstraints;
          }
          return defaultConstraints;
        }(),
        title: _getTitle(context),
        content: _getContent(context),
        actions: _getActions(context),
      );
    });
  }

  Widget? _getTitle(BuildContext context) {
    return title ??
        (titleText != null
            ? Text(
                titleText!,
                style: context.fluentTextTheme.title?.copyWith(
                  color:
                      titleTextColor ?? context.colorScheme.onPrimaryContainer,
                ),
              )
            : null);
  }

  Widget? _getContent(BuildContext context) {
    return fluent_ui.Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16,
      ),
      child: content ??
          ((contentText != null)
              ? Text(
                  contentText!,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onBackground,
                  ),
                )
              : null),
    );
  }

  List<Widget>? _getActions(BuildContext context) {
    List<Widget>? actionsButtons;
    if (withOkOptionButton) {
      actionsButtons = [];
      actionsButtons.add(
        fluent_ui.FilledButton(
          child: Text(
            context.localizations!.ok,
            style: context.fluentTextTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
    }

    if (actions != null) {
      actionsButtons ??= [];
      actionsButtons.addAll(actions!);
    }
    return actionsButtons;
  }
}
/*
*
*
*/
