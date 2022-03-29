import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/common/widgets/screens/two_sides_screen_layout.dart';
import 'package:clinic_v2/app/features/auth/login/view/components/login_form.dart';
import 'package:clinic_v2/app/features/auth/login/view/components/login_message.dart';

class LargeLoginScreen extends ResponsiveScreen {
  const LargeLoginScreen({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return TwoSidesScreenLayout(
      leftSide: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalMargins,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            LoginMessage(),
            SizedBox(height: 60),
            Center(child: LoginForm()),
          ],
        ),
      ),
      rightSide: Hero(
        tag: 'appName',
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: context.colorScheme.primary,
          alignment: Alignment.center,
          child: AppNameText(
            fontSize: 44,
            fontColor: context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
