import 'package:clinic_v2/app/base/responsive/responsive.dart';

class LoginMessage extends StatelessWidget {
  const LoginMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.loginScreenMessage,
      textAlign: TextAlign.start,
      style: context.textTheme.headline5?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
