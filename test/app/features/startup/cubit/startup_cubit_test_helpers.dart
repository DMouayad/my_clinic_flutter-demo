import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/core/common/models/custom_response.dart';
import 'package:mockito/mockito.dart';

void setupStartupCubitForStartupSuccess(StartupCubit startupCubit) {
  when(startupCubit.state).thenReturn(StartupSuccess());

  when(startupCubit.stream).thenAnswer(
    (_) => Stream<StartupState>.fromIterable(
      [StartupInProgress(), StartupSuccess()],
    ),
  );
  when(startupCubit.initServerConnection())
      .thenAnswer((_) async => const CustomResponse(success: true));
}

void setupStartupCubitForStartupFailure(
    StartupCubit startupCubit, CustomError startupError,
    {bool withRetryThenSuccess = false}) {
  if (withRetryThenSuccess) {
    when(startupCubit.stream).thenAnswer(
      (_) => Stream<StartupState>.fromIterable(
        [
          StartupInProgress(),
          StartupFailure(startupError),
          StartupInProgress(),
          StartupSuccess(),
        ],
      ),
    );
    when(startupCubit.state).thenReturn(StartupSuccess());
    //
    when(startupCubit.initServerConnection()).thenAnswer((_) async {
      startupCubit.retryToInitWhenConnectionIsRestored();
    });
  } else {
    final startupFailureState = StartupFailure(startupError);
    when(startupCubit.state).thenReturn(startupFailureState);

    when(startupCubit.stream).thenAnswer(
      (_) => Stream<StartupState>.fromIterable(
        [StartupInProgress(), startupFailureState],
      ),
    );
    when(startupCubit.initServerConnection()).thenAnswer(
      (_) async {
        CustomResponse(success: false, error: startupError);
      },
    );
  }
}
