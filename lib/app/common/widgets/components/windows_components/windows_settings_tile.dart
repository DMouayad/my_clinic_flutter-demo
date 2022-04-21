import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WindowsSettingTile extends StatelessWidget {
  const WindowsSettingTile({
    Key? key,
    required this.tileLabel,
    required this.titleText,
    required this.leadingIcon,
    this.subtitle,
    this.trailing,
  }) : super(key: key);

  final Widget? subtitle;
  final Widget? trailing;
  final Widget leadingIcon;
  final String tileLabel;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      labelStyle: context.textTheme.titleMedium?.copyWith(
        color: context.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ),
      label: tileLabel,
      child: ListTile(
        isThreeLine: true,
        leading: leadingIcon,
        title: Text(titleText),
        trailing: trailing,
        subtitle: subtitle,
      ),
    );
  }
}
