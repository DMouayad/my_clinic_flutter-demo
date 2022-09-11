import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WindowsSettingTile extends CustomStatelessWidget {
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
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return InfoLabel(
      labelStyle: context.textTheme.titleMedium?.copyWith(
        color: context.colorScheme.onBackground,
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
              : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
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
            if (!contextInfo.isPortraitTablet) const Spacer(),
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
                          vertical: 12.0,
                          horizontal: 8.0,
                        )
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
