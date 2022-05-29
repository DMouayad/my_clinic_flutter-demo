import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

class CustomDialog extends ResponsiveStatelessWidget {
  const CustomDialog({
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
  Widget windowsBuilder(BuildContext context, ContextInfo contextInfo) {
    return fluent_ui.ContentDialog(
      style: fluent_ui.ContentDialogThemeData(
        barrierColor: context.colorScheme.backgroundColor,
        // ac
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
                'Ok',
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

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return const AlertDialog();
  }
}
