import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/preferences/cubit/preferences_cubit.dart';
import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/main.dart';

import '../app/features/auth/auth_cubit_test.mocks.dart';

ClinicApp getClinicAppForTest({
  PreferencesCubit? preferencesCubit,
  AuthCubit? authCubit,
  BaseAuthRepository? authRepository,
  Widget? home,
}) {
  final mockAuthRepo = MockBaseAuthRepository();
  return ClinicApp(
    preferencesCubit ?? PreferencesCubit(),
    authCubit ?? AuthCubit(authRepository ?? mockAuthRepo),
    authRepository ?? mockAuthRepo,
    home: home,
  );
}
