import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/components/user_preferences_list.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepTwoSignUpScreen extends StatefulWidget {
  const StepTwoSignUpScreen({Key? key}) : super(key: key);
  @override
  State<StepTwoSignUpScreen> createState() => _StepTwoSignUpScreenState();
}

class _StepTwoSignUpScreenState
    extends StateWithResponsiveBuilder<StepTwoSignUpScreen> {
  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      body: UserPreferencesList(
        onAppearanceTileTapped: () {},
        onCalendarTileTapped: () {},
        showDentalServicesTile:
            (context.read<SignUpCubit>().state as SignUpStepTwo)
                    .serverUser
                    .role ==
                UserRole.dentist,
      ),
    );
  }
}
