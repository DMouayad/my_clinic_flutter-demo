import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

class AdaptiveListTile extends CustomStatelessWidget {
  const AdaptiveListTile({
    this.tileColor,
    this.shape,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.contentPadding = kDefaultContentPadding,
    this.dense = false,
    Key? key,
  }) : super(key: key);

  final Color? tileColor;

  final ShapeBorder? shape;

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool dense;
  final bool isThreeLine;

  final EdgeInsetsGeometry contentPadding;
  @override
  Widget? defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        leading: leading,
        dense: dense,
        shape: shape,
        title: title,
        trailing: trailing,
        subtitle: subtitle,
        isThreeLine: isThreeLine,
        tileColor: tileColor,
        contentPadding: contentPadding,
      ),
    );
  }

  @override
  Widget windowsBuilder(BuildContext context, ContextInfo contextInfo) {
    return fluent_ui.FluentTheme(
      data: context.fluentTheme,
      child: fluent_ui.ListTile(
        leading: leading,
        shape: shape,
        title: title,
        trailing: trailing,
        subtitle: subtitle,
        isThreeLine: isThreeLine,
        tileColor: tileColor,
        contentPadding: contentPadding,
      ),
    );
  }
}

const kDefaultContentPadding = EdgeInsets.symmetric(
  horizontal: 12.0,
  vertical: 6.0,
);
