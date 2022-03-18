import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_elevated_button.dart';

class SubmitButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const SubmitButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isTablet
          ? context.widthTransformer(reducedBy: .6)
          : context.widthTransformer(reducedBy: .8),
      height: 45,
      child: CustomElevatedButton(
        label: text,
        onPressed: onPressed,
        iconData: Icons.login,
      ),
    );
  }
}
