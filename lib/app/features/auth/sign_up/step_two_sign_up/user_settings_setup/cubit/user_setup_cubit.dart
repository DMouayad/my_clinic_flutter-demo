import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_setup_state.dart';

class UserSetupCubit extends Cubit<UserSetupState> {
  UserSetupCubit() : super(UserSetupInitial());
}
