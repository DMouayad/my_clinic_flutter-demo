import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';

abstract class BaseAuthProvider {
  late final BaseAuthRepository authRepository;
  bool hasLoggedInUser();
}
