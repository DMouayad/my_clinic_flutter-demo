import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/shared_widgets//scaffold_with_appbar.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_back_button.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/sign_up_components.dart';
import '../components/account_info_form.dart';

class StepOneSignUpScreen extends CustomStatelessWidget {
  const StepOneSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return ScaffoldWithAppBar(
          showLoadingIndicator: state is SignUpInProgress,
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
      },
    );
  }
}
