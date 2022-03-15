import 'package:clinic_v2/app/base/responsive/responsive.dart';

class LogInButton extends ResponsiveScreen {
  final void Function() onPressed;

  const LogInButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isTablet
          ? context.widthTransformer(reducedBy: .6)
          : context.widthTransformer(reducedBy: .8),
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(4.0),
          backgroundColor: MaterialStateProperty.all<Color>(
            AppColorScheme.backgroundColor(context)!,
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)?.login ?? 'Login',
          style: context.textTheme.button?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
