import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';

class WindowsTile extends StatelessWidget {
  const WindowsTile({
    Key? key,
    required this.tileLabel,
    this.subtitleText,
    this.leading,
    this.subtitle,
    this.child,
    this.childSize,
  }) : super(key: key);

  final Widget? subtitle;
  final Widget? leading;
  final String tileLabel;
  final String? subtitleText;

  /// a widget which will be displayed based on its size
  /// along side or under the [subtitle]
  final Widget? child;
  final Size? childSize;

  double _getWidthWithoutChild(Size widgetSize) {
    if (childSize != null) {
      if (childSize!.width <= (widgetSize.width * .5)) {
        return widgetSize.width - (childSize?.width ?? 0);
      }
    }
    return double.infinity;
  }

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(builder: (context, WidgetInfo widgetInfo) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tileLabel,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Wrap(
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints.tightForFinite(
                    width: _getWidthWithoutChild(widgetInfo.widgetSize),
                  ), // constraints: BoxConstraints.tight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (leading != null) ...[
                        leading!,
                        const SizedBox(width: 16),
                      ],
                      if (subtitleText != null)
                        Expanded(
                          child: AutoSizeText(
                            subtitleText!,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.onBackground,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // const SizedBox(width: double.infinity),
                if (child != null)
                  ConstrainedBox(
                    constraints: childSize != null
                        ? BoxConstraints.loose(childSize!)
                        : const BoxConstraints.expand(),
                    child: child!,
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
