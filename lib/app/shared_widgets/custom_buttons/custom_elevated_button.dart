import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';

class CustomElevatedButton extends CustomStatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.iconData,
    this.backgroundColor,
    this.labelColor,
    this.elevation = 2,
  }) : super(key: key);

  final String label;
  final void Function() onPressed;
  final IconData iconData;
  final Color? backgroundColor;
  final Color? labelColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(elevation),
        fixedSize: MaterialStateProperty.all(const Size.fromHeight(40)),
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(16, 2, 24, 2)),
        backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? context.colorScheme.primary),
        textStyle: MaterialStateProperty.all(
          context.textTheme.subtitle2?.copyWith(
            color: context.colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          labelColor ?? (context.colorScheme.onPrimary),
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
