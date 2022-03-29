import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/reusable_scaffold_with_appbar.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/components/user_preferences_list.dart';

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
        onUserCalendarChange: (userCalendar) {},
        onDentalServicesChange: (dentalServices) {},
      ),
    );
  }
}
