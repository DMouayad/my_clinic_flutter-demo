part of dentist_data;

class ParseDentistRepository implements BaseDentistRepository {
  @override
  late final BaseDentistDataSource<BaseDentist> dentistDataSource;

  @override
  Future<void> onInit() async {
    dentistDataSource = DentistParseDS();
    await dentistDataSource.init();
  }

  @override
  Future<Result<None>> addDentalService(BaseDentalService dentalService) async {
    return await dentistDataSource.addDentalService(dentalService);
  }

  @override
  Future<Result<None>> addMedication(String medicationName) async {
    return await dentistDataSource.addMedication(medicationName);
  }

  @override
  Future<Result<None>> deleteDentalService(
      BaseDentalService dentalService) async {
    return await dentistDataSource.deleteDentalService(dentalService);
  }

  @override
  Future<Result<List<BaseDentalService>>> getDentalServices() async {
    return await dentistDataSource.getDentalServices();
  }

  @override
  Future<Result<List<String>>> getMedicationsList() async {
    return await dentistDataSource.getMedicationsList();
  }

  @override
  Future<Result<None>> updateDentalService(
      BaseDentalService dentalService) async {
    return await dentistDataSource.updateDentalService(dentalService);
  }

  @override
  Result<Locale?> getSelectedLocale() {
    return dentistDataSource.getSelectedLocale();
  }

  @override
  Result<ThemeMode?> getSelectedTheme() {
    return dentistDataSource.getSelectedTheme();
  }

  @override
  Future<Result<None>> updateSelectedLocal(Locale locale) async {
    return await dentistDataSource.updateSelectedLocal(locale);
  }

  @override
  Future<Result<None>> updateSelectedTheme(ThemeMode mode) async {
    return await dentistDataSource.updateSelectedTheme(mode);
  }

  @override
  Future<BaseDentist?> getStoredAppUser() async {
    return await dentistDataSource.getLocallyStoredDentist();
  }

  @override
  Future<Result<None>> saveLocally() async {
    return await dentistDataSource.saveLocally();
  }

  @override
  Future<Result<None>> saveRemotely() async {
    return await dentistDataSource.saveRemotely();
  }

  @override
  Future<Result<None>> deleteLocalData() async {
    return await dentistDataSource.deleteLocalData();
  }

  @override
  Future<Result<List<int>>> getNonWorkingDays() async {
    return await dentistDataSource.getNonWorkingDays();
  }

  @override
  Future<Result<List<TimeOfDay>>> getWorkHours(int day) async {
    return await dentistDataSource.getWorkHours(day);
  }

  @override
  Future<Result<None>> updateDayWorkHours({
    required int day,
    required List<TimeOfDay> workHours,
  }) async {
    return await dentistDataSource.updateDayWorkHours(
        day: day, workHours: workHours);
  }

  @override
  Future<Result<None>> updateNonWorkingDays({required List<int> days}) async {
    return await dentistDataSource.updateNonWorkingDays(days: days);
  }
}
