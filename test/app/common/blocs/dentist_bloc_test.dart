import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/common/blocs/app_user_bloc/user_bloc.dart';
import 'package:clinic_v2/app/common/blocs/dentist_bloc/dentist_bloc.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDentistBloc extends MockBloc<UserEvent, UserState>
    implements DentistBloc {}

void main() {
  test('Should emit [UserThemeFetched] when calling [UserThemeRequested]',
      () async {
    final dentistBloc = MockDentistBloc();
    when(dentistBloc.add(UserThemeRequested())).thenReturn(
      dentistBloc.emit(
        const ThemeModeProvided(ThemeMode.system),
      ),
    );
    dentistBloc.add(UserThemeRequested());
    // expect(dentistBloc.state, DentistInitial());
    expectLater(
      dentistBloc.state,
      emitsInOrder([const ThemeModeProvided(ThemeMode.system)]),
    );
  });
  // blocTest<UserBloc, UserState>(
  //   'emits [MyState] when MyEvent is added.',
  //   build: () {
  //     when
  //     return DentistBloc(MockDentistRepository());
  //   },
  //   act: (bloc) => bloc.add(UserThemeRequested()),
  //   expect: () => const <DentistState>[],
  // );
}
