// import 'package:bloc_test/bloc_test.dart';
// import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class MockStartupCubit extends Mock implements StartupCubit {}

// void main() {
//   group(
//     'StartupCubit tests',
//     () {
//       late final MockStartupCubit startupCubit;
//       setUp(() => startupCubit = MockStartupCubit());
//       tearDown(() => startupCubit.close());
//       test(
//         'Should emit StartupSuccess after ParseServer is initialized',
//         () async {
//           // ARRANGE
//           whenListen(
//             startupCubit,
//             Stream.fromIterable([
//               StartupSuccess(),
//             ]),
//             initialState: StartupInProgress(),
//           );

//           // act
//           await startupCubit.initParse();
//           // expect
//           await expectLater(startupCubit.stream,
//               emitsInOrder([StartupInProgress(), StartupSuccess()]));
//         },
//       );
//     },
//   );
// }
