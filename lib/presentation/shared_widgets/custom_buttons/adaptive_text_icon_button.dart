import '../../../presentation/shared_widgets/material_with_utils.dart';

class AdaptiveTextIconButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Widget iconWidget;
  final double labelFontSize;
  final Color? labelColor;
  final Size? size;
  final Color? foregroundColor;
  final String tooltipMessage;
  final EdgeInsets? margins;

  const AdaptiveTextIconButton({
    required this.label,
    required this.onPressed,
    required this.iconWidget,
    required this.tooltipMessage,
    this.labelFontSize = 16,
    this.labelColor,
    this.size,
    this.foregroundColor,
    this.margins,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margins ?? EdgeInsets.zero,
      child: Tooltip(
        message: tooltipMessage,
        waitDuration: const Duration(milliseconds: 300),
        child: TextButton.icon(
          onPressed: onPressed,
          label: Text(label),
          icon: iconWidget,
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(size),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              return foregroundColor ?? context.colorScheme.secondary;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return foregroundColor?.withAlpha(40);
              }
              if (states.contains(MaterialState.hovered)) {
                return foregroundColor?.withAlpha(30);
              }
            }),
            textStyle: MaterialStateProperty.all(
              context.textTheme.titleSmall?.copyWith(
                color: labelColor,
                fontSize: labelFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
