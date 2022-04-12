import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_filled_button.dart';

class SubmitButton extends Component {
  final void Function() onPressed;
  final String text;
  final IconData iconData;
  final bool expandInWidth;
  final double? height;

  const SubmitButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.iconData,
    this.expandInWidth = false,
    this.height,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, contextInfo) {
    return SizedBox(
      width: expandInWidth
          ? contextInfo.widgetSize!.width
          : contextInfo.widgetSize!.width * .8,
      height: height ?? 45,
      child: contextInfo.isDesktop
          ? CustomFilledButton(
              label: text,
              onPressed: onPressed,
              iconData: iconData,
              backgroundColor: context.colorScheme.primary,
              labelColor: context.colorScheme.onPrimary,
            )
          : CustomElevatedButton(
              label: text,
              onPressed: onPressed,
              iconData: iconData,
            ),
    );
  }
}
