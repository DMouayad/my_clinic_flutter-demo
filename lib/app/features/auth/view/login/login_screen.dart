import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/features/auth/view/login/widgets/login_form.dart';

class LoginScreen extends ResponsiveScreen {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget mobileBuilder(BuildContext context, ContextInfo contextInfo) {
    print(contextInfo);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 45.0, bottom: 70),
              child: AppNameText(
                fontSize: 26,
                fontColor: AppColorScheme.secondary(context),
              ),
            ),
          ),
          Text(
            'Login to your account',
            textAlign: TextAlign.start,
            style: context.textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const LoginForm(),
        ],
      ),
    );
  }

  @override
  Widget desktopBuilder(BuildContext context, ContextInfo contextInfo) {
    print('-----');
    print(contextInfo);

    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: LoginForm()),
          Expanded(
            child: Container(color: AppColorScheme.primary(context)),
          ),
        ],
      ),
    );
  }
}
