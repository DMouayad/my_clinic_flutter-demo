part of dentist_contracts;

abstract class BaseDentistDataSource<T extends BaseDentist>
    extends BaseUserDataSource {
  T? currentDentist;
  Future<T?> getLocallyStoredDentist();
  Future<CustomResponse<T?>> getDentistFromServer();

  Future<CustomResponse<List<DentalService>>> getDentalServices();
  Future<CustomResponse<List<String>>> getMedicationsList();
  Future<CustomResponse<NoResult>> addDentalService(
    BaseDentalService dentalService,
  );
  Future<CustomResponse<NoResult>> deleteDentalService(
    BaseDentalService dentalService,
  );
  Future<CustomResponse<NoResult>> addMedication(String medicationName);
  Future<CustomResponse<NoResult>> updateDentalService(
    BaseDentalService dentalService,
  );
}
