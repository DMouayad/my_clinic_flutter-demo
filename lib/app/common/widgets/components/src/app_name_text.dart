import 'package:clinic_v2/app/base/responsive/responsive.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({Key? key, this.fontSize = 20, this.fontColor})
      : super(key: key);
  final double? fontSize;
  final Color? fontColor;

  @override
  Widget build(context) {
    return Text(
      'CLINIC',
      style: context.textTheme.headline6?.copyWith(
        letterSpacing: 1.2,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: fontColor ?? context.colorScheme.onBackground,
      ),
    );
  }
}
