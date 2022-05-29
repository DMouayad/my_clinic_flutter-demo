import 'package:clinic_v2/app/base/responsive/responsive.dart';

class HourDigitCard extends StatelessWidget {
  const HourDigitCard({
    this.label,
    this.labelText,
    required this.cardColor,
    Key? key,
  })  : assert(label != null || labelText != null),
        super(key: key);

  final String? labelText;
  final Widget? label;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(context.isWindowsPlatform ? 4 : 12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: label ??
          Text(
            labelText!,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSecondaryContainer,
            ),
          ),
    );
  }
}
