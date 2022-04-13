import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/main.dart';
import '../app/features/auth/auth_cubit_test.mocks.dart';

ClinicApp getClinicAppForTest({
  AppearancePreferencesCubit? preferencesCubit,
  AuthCubit? authCubit,
  BaseAuthRepository? authRepository,
  Widget? home,
}) {
  final mockAuthRepo = MockBaseAuthRepository();

  //

  return ClinicApp(
    preferencesCubit ?? AppearancePreferencesCubit(),
    authCubit ?? AuthCubit(authRepository ?? mockAuthRepo),
    authRepository ?? mockAuthRepo,
    home: home,
  );
}
