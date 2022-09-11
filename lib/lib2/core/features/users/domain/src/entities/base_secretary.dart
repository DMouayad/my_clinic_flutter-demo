import 'package:clinic_v2/common/common/utilities/enums.dart';
import 'package:clinic_v2/common/features/users/domain/src/entities/base_app_user.dart';

abstract class BaseSecretary extends BaseAppUser {
  BaseSecretary({
    required String id,
  }) : super(
          id: id,
          role: UserRole.secretary,
        );
}
