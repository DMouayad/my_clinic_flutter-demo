part of dentist_contracts;

abstract class BaseDentistRepository
    extends BaseAppUserRepository<BaseDentist> {
  late final BaseDentistDataSource dentistDataSource;

  Future<CustomResponse<List<BaseDentalService>>> getDentalServices();
  Future<CustomResponse<List<String>>> getMedicationsList();
  Future<CustomResponse<NoResult>> addDentalService(
      BaseDentalService dentalService);
  Future<CustomResponse<NoResult>> deleteDentalService(
      BaseDentalService dentalService);
  Future<CustomResponse<NoResult>> addMedication(String medicationName);
  Future<CustomResponse<NoResult>> updateDentalService(
      BaseDentalService dentalService);
}
