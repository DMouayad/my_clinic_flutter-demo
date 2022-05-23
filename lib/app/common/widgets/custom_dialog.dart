import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

class CustomDialog extends Component {
  const CustomDialog({
    required this.titleText,
    required this.contentText,
    this.actions = const [],
    this.withOkOptionButton = false,
    Key? key,
  }) : super(key: key);
  final String titleText;
  final String contentText;
  final List<Widget> actions;
  final bool withOkOptionButton;

  @override
  Widget? windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return fluent_ui.ContentDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [
        if (withOkOptionButton)
          fluent_ui.FilledButton(
              child: Text(
                'Done',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ...actions,
      ],
    );
  }

  @override
  Widget builder(BuildContext context, contextInfo) {
    return AlertDialog();
  }
}
