part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthHasLoggedInUser extends AuthState {
  final BaseServerUser currentUser;
  const AuthHasLoggedInUser(this.currentUser);
  @override
  List<Object> get props => [currentUser];
  @override
  String toString() {
    return '''<$runtimeType>
                 ${currentUser.runtimeType}
                    [id:    ${currentUser.id}
                    email: ${currentUser.email}
                    role:  ${currentUser.role}] ''';
  }
}

class AuthHasNoLoggedInUser extends AuthState {
  const AuthHasNoLoggedInUser();
}

class AuthErrorState extends AuthState {
  final BasicError error;
  const AuthErrorState(this.error);

  @override
  List<Object> get props => [error];
}
