import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/screens/two_sides_screen_layout.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LargeStepTwoSignUpScreen extends ResponsiveScreen {
  const LargeStepTwoSignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TwoSidesScreenLayout(
          leftSideBlurred: state is SignUpInProgress,
          leftSide: const _StepTowLeftSide(),
          rightSide: const _StepTowRightSide(),
        );
      },
    );
  }
}

class _StepTowRightSide extends ResponsiveScreen {
  const _StepTowRightSide({Key? key}) : super(key: key);
  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return Container();
  }
}

class _StepTowLeftSide extends ResponsiveScreen {
  const _StepTowLeftSide({Key? key}) : super(key: key);
  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return Container();
  }
}
