import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_back_button.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/components/sign_up_components.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_one_sign_up/components/account_info_form.dart';

class StepOneSignUpScreen extends ResponsiveScreen {
  const StepOneSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      title: const SignUpMessage(),
      leading: const CustomBackButton(),
      actions: [
        SignUpStepIndicator(
          title: AppLocalizations.of(context)!.stepOne,
        ),
      ],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalMargins,
          vertical: 25,
        ),
        child: const Center(
          child: SingleChildScrollView(
            child: SignUpAccountInfoForm(),
          ),
        ),
      ),
    );
  }
}
