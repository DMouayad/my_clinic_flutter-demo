import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/core/common/models/user_calendar.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
import 'package:clinic_v2/core/features/users/data/dentist_data.dart';

import 'app_preferences_settings.dart';
import 'dental_services_setup.dart';
import 'user_calendar_setup.dart';

class UserPreferencesList extends Component {
  const UserPreferencesList({
    required this.onDentalServicesChange,
    required this.onUserCalendarChange,
    Key? key,
  }) : super(key: key);

  final void Function(UserCalendar userCalendar) onUserCalendarChange;
  final void Function(List<DentalService> dentalServices)
      onDentalServicesChange;

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    final userIsDentist =
        (context.read<SignUpCubit>().state as SignUpStepTwo).serverUser.role ==
            UserRole.dentist;
    return ListView(
      children: [
        UserCalendarSettings(
          onUserCalendarChange: onUserCalendarChange,
        ),
        if (userIsDentist)
          DentalServicesSettings(
            onDentalServicesChange: onDentalServicesChange,
          ),
        const AppPreferencesSettings(),
      ],
    );
  }
}
