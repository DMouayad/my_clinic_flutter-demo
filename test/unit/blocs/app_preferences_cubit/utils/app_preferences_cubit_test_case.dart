import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences_repository.dart';

import '../../../shared/base_bloc_test_case.dart';
import 'mock_user_preferences_repository_factory.dart';

class AppPreferencesCubitTestCase extends BlocTestCase<
    AppPreferencesState,
    AppPreferencesCubit,
    BaseUserPreferencesRepository,
    UserPreferencesRepositoryFactory> {
  const AppPreferencesCubitTestCase(
    super.description, {
    super.expectedStates,
    super.seed,
    super.verify,
    super.act,
    super.expect,
    super.waitAfterAct,
    super.setupRepository,
  });

  @override
  AppPreferencesCubit createBloc(repository) {
    return AppPreferencesCubit(repository, shouldLogCubitChange: false);
  }

  @override
  UserPreferencesRepositoryFactory get repositoryFactory =>
      UserPreferencesRepositoryFactory();
}
