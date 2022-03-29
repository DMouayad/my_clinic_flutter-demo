import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/features/auth/login/view/components/login_form.dart';

import 'package:clinic_v2/app/features/auth/login/view/components/login_message.dart';

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
                fontColor: context.colorScheme.secondary,
              ),
            ),
          ),
          const LoginMessage(),
          const LoginForm(),
        ],
      ),
    );
  }
}
