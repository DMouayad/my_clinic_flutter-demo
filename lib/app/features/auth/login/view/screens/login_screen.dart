import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/app_name_text.dart';
import 'package:clinic_v2/app/common/widgets/components/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/features/auth/login/view/components/login_form.dart';
import 'package:clinic_v2/app/features/auth/login/view/components/login_message.dart';

class LoginScreen extends ResponsiveScreen {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      title: AppNameText(
        fontColor: context.colorScheme.primary,
        fontSize: 32,
      ),
      centerTitle: true,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.horizontalMargins,
            vertical: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.horizontalMargins),
                child: const LoginMessage(),
              ),
              SizedBox(
                height: contextInfo.widgetSize!.height * .1,
              ),
              const Center(child: LoginForm()),
            ],
          ),
        ),
      ),
    );
  }
}
