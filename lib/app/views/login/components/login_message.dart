import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';

class LoginMessage extends StatelessWidget {
  const LoginMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.loginScreenMessage,
      textAlign: TextAlign.start,
      style: context.textTheme.headline6?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onBackground,
      ),
    );
  }
}
