import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/models/user_preferences_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';

class UserPreferencesList extends Component {
  const UserPreferencesList({
    required this.onAppearanceTileTapped,
    required this.onDentalServicesTileTapped,
    required this.onCalendarTileTapped,
    Key? key,
  }) : super(key: key);
  //
  final void Function() onAppearanceTileTapped;
  final void Function() onDentalServicesTileTapped;
  final void Function() onCalendarTileTapped;
  // final void Function(UserCalendar userCalendar) onUserCalendarChange;
  // final void Function(List<DentalService> dentalServices)
  // onDentalServicesChange;

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    final userIsDentist =
        (context.read<SignUpCubit>().state as SignUpStepTwo).serverUser.role ==
            UserRole.dentist;
    final _appPreferencesItems = [
      UserPreferencesItem(
        name: AppLocalizations.of(context)!.calendar,
        icon: Icons.calendar_today_outlined,
        onTap: onCalendarTileTapped,
      ),
      UserPreferencesItem(
        name: AppLocalizations.of(context)!.appearance,
        icon: Icons.devices,
        onTap: onAppearanceTileTapped,
      ),
      if (userIsDentist)
        UserPreferencesItem(
          name: 'Dental services',
          // name: AppLocalizations.of(context)!.dentalServices,
          icon: Icons.medical_services_outlined,
          onTap: onDentalServicesTileTapped,
        ),
    ];
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _appPreferencesItems[index];
      },
    );
  }
}
