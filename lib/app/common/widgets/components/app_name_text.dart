import 'package:clinic_v2/app/base/responsive/responsive.dart';

class AppNameText extends Component {
  const AppNameText({Key? key, this.fontSize, this.fontColor})
      : super(key: key);
  final double? fontSize;
  final Color? fontColor;

  @override
  Widget builder(context, contextInfo) {
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
