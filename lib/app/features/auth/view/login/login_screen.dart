import 'package:animate_do/animate_do.dart';
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
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalMargins,
          vertical: 25,
        ),
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
          _loginMessageText(context),
          const LoginForm(),
        ],
      ),
    );
  }

  Widget _loginMessageText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.loginScreenMessage,
      textAlign: TextAlign.start,
      style: context.textTheme.headline5?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  @override
  Widget desktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SlideInRight(
              from: 30,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.horizontalMargins,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _loginMessageText(context),
                    const SizedBox(height: 60),
                    const Center(child: LoginForm()),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Hero(
              tag: 'appName',
              child: Container(
                constraints: const BoxConstraints.expand(),
                color: AppColorScheme.primary(context),
                alignment: Alignment.center,
                child: AppNameText(
                  fontSize: 44,
                  fontColor: AppColorScheme.onPrimary(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
