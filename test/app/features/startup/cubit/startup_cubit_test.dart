import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'startup_cubit_test.mocks.dart';
import 'startup_cubit_test_helpers.dart';

@GenerateMocks([StartupCubit])
void main() {
  final connectionError = CustomError(
    message: 'No internet connection found!',
  );
  group('StartupCubit tests', () {
    final MockStartupCubit startupCubit = MockStartupCubit();

    blocTest<StartupCubit, StartupState>(
      'should emit [StartupFailure] when [initServerConnection] was not successful due to connection exception',
      setUp: () => setupStartupCubitForStartupFailure(
        startupCubit,
        connectionError,
      ),
      build: () => startupCubit,
      act: (cubit) {
        return cubit.initServerConnection();
      },
      expect: () =>
          <StartupState>[StartupInProgress(), StartupFailure(connectionError)],
    );
    blocTest<StartupCubit, StartupState>(
      'should emits [StartupSuccess] when [initServerConnection] was  successful',
      setUp: () => setupStartupCubitForStartupSuccess(startupCubit),
      build: () => startupCubit,
      act: (cubit) {
        return cubit.initServerConnection();
      },
      expect: () => <StartupState>[StartupInProgress(), StartupSuccess()],
    );
  });
}
