import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences_repository.dart';

import '../../../shared/base_bloc_test_case.dart';
import 'mock_user_preferences_repository_factory.dart';

class AppPreferencesCubitTestCase extends BlocTestCase<
    AppPreferencesCubit,
    AppPreferencesState,
    BaseUserPreferencesRepository,
    UserPreferencesRepositoryFactory> {
  AppPreferencesCubitTestCase(
    super.description, {
    super.expectedStates,
    super.seed,
    super.verify,
    super.act,
    super.expect,
    super.waitAfterAct,
    super.setupRepository,
  }) : super(repositoryFactory: UserPreferencesRepositoryFactory());

  @override
  AppPreferencesCubit createBloc(repository) {
    return AppPreferencesCubit(repository, shouldLogCubitChange: false);
  }
}
