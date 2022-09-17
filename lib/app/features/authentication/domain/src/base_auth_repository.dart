import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';

import 'base_server_user.dart';

abstract class BaseAuthRepository<U extends BaseServerUser> {
  U? currentUser;
  void setCurrentUser(U user);

  Stream<bool> get hasLoggedInUser;

  Future<Result<U, BasicError>> onInit();

  Future<Result<VoidResult, BasicError>> register({
    required String email,
    required String name,
    required String password,
    required ThemeMode themeModePreference,
    required Locale localePreference,
  });
  Future<Result<U, BasicError>> login({
    required String email,
    required String password,
  });
  Future<Result<VoidResult, BasicError>> requestPasswordReset(
    String emailAddress,
  );
  Future<Result<VoidResult, BasicError>> requestVerificationEmail();
  Future<Result<VoidResult, BasicError>> logout();
}
