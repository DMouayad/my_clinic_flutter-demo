import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_v2/app/base/responsive/responsive.dart';

class ErrorCard extends ResponsiveStatelessWidget {
  const ErrorCard({
    required this.errorText,
    this.errorIcon,
    this.color,
    this.actionButton,
    Key? key,
  }) : super(key: key);
  final String errorText;
  final Color? color;
  final Widget? errorIcon;
  final Widget? actionButton;

  Widget _title(BuildContext context) {
    return AutoSizeText(
      errorText,
      textAlign: TextAlign.center,
      minFontSize: 10,
      style: context.textTheme.bodyLarge?.copyWith(
        color: AppColorScheme.of(context).onError,
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
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return SizedBox(
      width: _getCardWidth(contextInfo.widgetSize!.width),
      height: 55,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: color ?? AppColorScheme.of(context).errorColor,
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
  }
}
