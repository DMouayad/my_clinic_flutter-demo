import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/login/view/screens/login_screen.dart';
import 'package:clinic_v2/app/features/home_screen/view/home_screen.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:clinic_v2/app/features/startup/view/startup_screen.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../auth/auth_cubit_test.mocks.dart';
import '../../auth/auth_cubit_test_helpers.dart';
import '../cubit/startup_cubit_test.mocks.dart';
import '../cubit/startup_cubit_test_helpers.dart';

void main() {
  final connectionError = CustomError(
    message: 'No internet connection found!',
  );
  group('StartupScreen tests', () {
    AuthCubit? authCubit;
    MockStartupCubit? startupCubit;
    late MockBaseAuthRepository mockAuthRepository;
    late Widget startupScreenMock;

    setUp(() async {
      if (startupCubit != null) {
        await startupCubit!.close();
      }
      if (authCubit != null) {
        await authCubit!.close();
      }
      mockAuthRepository = MockBaseAuthRepository();
      startupCubit = MockStartupCubit();
      authCubit = AuthCubit(mockAuthRepository);

      startupScreenMock = WidgetsApp(
        color: Colors.red,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<StartupCubit>.value(value: startupCubit!),
                  BlocProvider<AuthCubit>.value(value: authCubit!),
                ],
                child: const StartupScreen(),
              );
            },
          );
        },
      );
    });

    tearDown(() async {
      await authCubit!.close();
      await startupCubit!.close();
    });

    group('Startup failing scenario', () {
      setUp(() {
        setupStartupCubitForStartupFailure(startupCubit!, connectionError);
      });

      testWidgets(
        'should find [ErrorStartingAppScreen] when [StartupCubit] emits [StartupFailure]',
        (WidgetTester tester) async {
          // act
          await tester.pumpWidget(startupScreenMock);

          // expect StartupCubit state to be StartupFailure
          expect(startupCubit!.state, StartupFailure(connectionError));

          await tester.pumpWidget(startupScreenMock);
          // expect ErrorStartingAppScreen to be returned as a result to StartupCubit's state
          expect(find.byType(ErrorStartingAppScreen), findsOneWidget);
        },
      );
    });
  });

  group('Startup success scenario', () {
    AuthCubit? authCubit;
    MockStartupCubit? startupCubit;
    late MockBaseAuthRepository authRepository;

    // in this test group [ClinicApp] is needed to verify the correct route is pushed based on
    // [AuthCubit] state
    late ClinicApp clinicApp;
    setUp(
      () async {
        if (startupCubit != null) {
          await startupCubit!.close();
        }
        authRepository = MockBaseAuthRepository();
        startupCubit = MockStartupCubit();
        authCubit = AuthCubit(authRepository);

        setupStartupCubitForStartupSuccess(startupCubit!);

        clinicApp = ClinicApp(
          AppearancePreferencesCubit(),
          authCubit!,
          authRepository,
          home: BlocProvider<StartupCubit>.value(
            value: startupCubit!,
            child: Builder(builder: (context) {
              return const StartupScreen();
            }),
          ),
        );
      },
    );

    testWidgets(
      'should navigate to [HomeScreen] when [StartupCubit] state is'
      'success and [AuthCubit] state is [AuthHasLoggedInUser]',
      (WidgetTester tester) async {
        // arrange
        setupMockedAuthRepoWithLoggedInUser(authRepository);

        // act
        await tester.pumpWidget(clinicApp);

        await tester.pumpAndSettle();

        // expect
        expect(find.byType(HomeScreen), findsOneWidget);
        expect(find.byType(StartupScreen), findsNothing);
      },
    );
    testWidgets(
      'should navigate to [LoginScreen] when [StartupCubit] state is'
      'success and [AuthCubit] state is [AuthHasNoLoggedInUser]',
      (WidgetTester tester) async {
        // arrange
        setupMockedAuthRepoWithNoLoggedInUser(authRepository);

        // act
        await tester.pumpWidget(clinicApp);
        await tester.pumpAndSettle();

        // expect
        expect(find.byType(LoginScreen), findsOneWidget);
        expect(find.byType(StartupScreen), findsNothing);
      },
    );
  });
}
