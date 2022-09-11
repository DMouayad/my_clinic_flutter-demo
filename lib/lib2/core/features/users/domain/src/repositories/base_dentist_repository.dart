part of dentist_contracts;

abstract class BaseDentistRepository
    extends BaseAppUserRepository<BaseDentist> {
  late final BaseDentistDataSource dentistDataSource;

  Future<Result<List<BaseDentalService>>> getDentalServices();
  Future<Result<List<String>>> getMedicationsList();
  Future<Result<None>> addDentalService(BaseDentalService dentalService);
  Future<Result<None>> deleteDentalService(BaseDentalService dentalService);
  Future<Result<None>> addMedication(String medicationName);
  Future<Result<None>> updateDentalService(BaseDentalService dentalService);
  Future<Result<None>> updateCalendar(WorkSchedule calendar);
}
