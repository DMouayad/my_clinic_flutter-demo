import 'package:clinic_v2/app/shared_widgets/custom_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WindowsTile extends CustomStatelessWidget {
  const WindowsTile({
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
  Widget customBuild(BuildContext context, WidgetInfo widgetInfo) {
    return InfoLabel(
      labelStyle: context.textTheme.titleMedium?.copyWith(
        color: context.colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      label: tileLabel,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Flex(
          direction: context.isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: context.isMobile
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 12),
              child: Row(
                children: [
                  leadingIcon,
                  const SizedBox(width: 16),
                  Text(
                    titleText,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              Container(
                alignment: context.isLTR
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
