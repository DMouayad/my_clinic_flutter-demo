import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'startup_cubit_test.mocks.dart';
import 'startup_cubit_test_helpers.dart';

@GenerateMocks([StartupCubit])
void main() {
  final connectionError = CustomError(
    message: 'No internet connection found!',
    code: ErrorCode.connectionNotFound.name,
  );
  group('StartupCubit tests', () {
    final MockStartupCubit startupCubit = MockStartupCubit();
    group('Startup failing tests', () {
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
        expect: () => <StartupState>[
          StartupInProgress(),
          StartupFailure(connectionError)
        ],
      );
      test(
          'when startup fails due to connection error, should retry to initialize server connection if connection was restored',
          () async {
        // SETUP
        setupStartupCubitForStartupFailure(
          startupCubit,
          connectionError,
          withRetryThenSuccess: true,
        );
        // ACT
        startupCubit.initServerConnection();
        // EXPECT
        verify(startupCubit.retryToInitWhenConnectionIsRestored());
      });
      test(
          'when startup fails due to connection error, expect [StartupSuccess] after connection was restored',
          () async {
        // SETUP
        setupStartupCubitForStartupFailure(
          startupCubit,
          connectionError,
          withRetryThenSuccess: true,
        );

        // ACT
        await startupCubit.initServerConnection();
        // EXPECT
        verify(startupCubit.retryToInitWhenConnectionIsRestored());
        await expectLater(startupCubit.state, StartupSuccess());

        await expectLater(
          startupCubit.stream,
          emitsInOrder(<StartupState>[
            StartupInProgress(),
            StartupFailure(connectionError),
            StartupInProgress(),
            StartupSuccess()
          ]),
        );
      });
    });

    blocTest<StartupCubit, StartupState>(
      'should emits [StartupSuccess] when [initServerConnection] was successful',
      setUp: () => setupStartupCubitForStartupSuccess(startupCubit),
      build: () => startupCubit,
      act: (cubit) {
        return cubit.initServerConnection();
      },
      expect: () => <StartupState>[StartupInProgress(), StartupSuccess()],
    );
  });
}
