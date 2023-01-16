import 'package:auto_size_text/auto_size_text.dart';

import '../../presentation/shared_widgets/material_with_utils.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    required this.errorText,
    this.errorIcon,
    this.color,
    this.actionButton,
    Key? key,
  }) : super(key: key);
  final String? errorText;
  final Color? color;
  final Widget? errorIcon;
  final Widget? actionButton;

  Widget _title(BuildContext context) {
    return AutoSizeText(
      errorText ?? 'An error occurred',
      textAlign: TextAlign.center,
      minFontSize: 10,
      style: context.textTheme.titleMedium?.copyWith(
        color: context.colorScheme.onError,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  double _getCardWidth(double widgetWidth) {
    return widgetWidth > 600
        ? widgetWidth * .6
        : widgetWidth < 400
            ? widgetWidth * .9
            : widgetWidth * .7;
  }

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(builder: (context, widgetInfo) {
      return SizedBox(
        width: _getCardWidth(widgetInfo.widgetSize.width),
        height: context.isMobile
            ? 55
            : context.isTablet
                ? 65
                : 75,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          decoration: BoxDecoration(
            color: color ?? context.colorScheme.errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 2, child: _title(context)),
              if (actionButton != null)
                Expanded(
                  child: actionButton!,
                ),
            ],
          ),
        ),
      );
    });
  }
}
