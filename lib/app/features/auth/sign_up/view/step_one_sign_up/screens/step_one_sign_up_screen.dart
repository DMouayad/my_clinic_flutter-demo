import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/components/sign_up_components.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_one_sign_up/components/account_info_form.dart';

class StepOneSignUpScreen extends ResponsiveScreen {
  const StepOneSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    print(contextInfo);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalMargins,
          vertical: 25,
        ),
        child: Column(
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
            const SignUpMessage(),
            SignUpStepIndicator(
              title: AppLocalizations.of(context)!.stepOne,
            ),
            const SignUpAccountInfoForm(),
          ],
        ),
      ),
    );
  }
}
