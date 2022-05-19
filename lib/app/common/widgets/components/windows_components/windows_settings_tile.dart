import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WindowsSettingTile extends Component {
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
  Widget builder(BuildContext context, contextInfo) {
    return InfoLabel(
      labelStyle: context.textTheme.titleMedium?.copyWith(
        color: context.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ),
      label: tileLabel,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Flex(
          direction:
              contextInfo.isPortraitTablet ? Axis.vertical : Axis.horizontal,
          // mainAxisAlignment: contextInfo.isDesktop
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: contextInfo.isPortraitTablet
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  leadingIcon,
                  const SizedBox(width: 16),
                  Text(titleText),
                ],
              ),
            ),
            if (trailing != null)
              Expanded(
                flex: contextInfo.isPortraitTablet
                    ? 0
                    : contextInfo.widgetSize!.width > 485
                        ? 0
                        : 1,
                child: Padding(
                  padding: contextInfo.isPortraitTablet
                      ? const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0)
                      : EdgeInsets.zero,
                  child: trailing!,
                ),
              ),

            // Flex(
            //   direction: Axis.horizontal,
            //   children: [
            //     Expanded(child: Text(titleText)),
            //     if (trailing != null) Expanded(child: trailing!),
            //   ],
            // ),
          ],
          // isThreeLine: true,
          // leading: leadingIcon,
          // title: Text(titleText),
          // trailing: trailing,
          // subtitle: subtitle,
        ),
      ),
    );
  }
}
