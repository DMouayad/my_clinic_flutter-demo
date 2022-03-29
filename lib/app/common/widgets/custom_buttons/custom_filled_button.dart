import 'package:clinic_v2/app/base/responsive/responsive.dart';

class CustomFilledButton extends Component {
  const CustomFilledButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.iconData,
    this.backgroundColor,
    this.labelColor,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;
  final IconData iconData;
  final Color? backgroundColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size.fromHeight(40)),
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(16, 2, 24, 2)),
        backgroundColor: MaterialStateProperty.all(
          backgroundColor ??
              (context.isDarkMode
                  ? const Color(0xFF485860)
                  // : const Color(0xFF95bcb7)
                  : context.colorScheme.secondaryContainer),
        ),
        textStyle: MaterialStateProperty.all(
          context.textTheme.subtitle2?.copyWith(
            color: labelColor ?? context.colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          labelColor ?? (context.colorScheme.onSecondaryContainer),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      label: Text(
        label,
      ),
      onPressed: onPressed,
      icon: Icon(
        iconData,
        size: 20,
      ),
    );
  }
}
