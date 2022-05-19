import 'package:clinic_v2/app/base/responsive/responsive.dart';

class AppNameText extends Component {
  const AppNameText({
    Key? key,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
  }) : super(key: key);
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  @override
  Widget builder(context, contextInfo) {
    return Text(
      AppLocalizations.of(context)!.clinic,
      style: context.textTheme.headline6?.copyWith(
        letterSpacing: 1.2,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: fontColor ?? context.colorScheme.onBackground,
      ),
    );
  }
}
