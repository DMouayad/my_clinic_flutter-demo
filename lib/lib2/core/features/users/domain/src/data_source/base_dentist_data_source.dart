import 'package:clinic_v2/common/features/users/domain/dentist_contracts.dart';

import 'base_user_data_source.dart';

abstract class BaseDentistDataSource<T extends BaseDentist>
    extends BaseUserDataSource {
  T? currentDentist;
  Future<T?> getLocallyStoredDentist();
  Future<Result<T?>> getDentistFromServer();

  Future<Result<List<BaseDentalService>>> getDentalServices();
  Future<Result<List<String>>> getMedicationsList();
  Future<Result<None>> addDentalService(
    BaseDentalService dentalService,
  );
  Future<Result<None>> deleteDentalService(
    BaseDentalService dentalService,
  );
  Future<Result<None>> addMedication(String medicationName);
  Future<Result<None>> updateDentalService(
    BaseDentalService dentalService,
  );
}
