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
  Future<CustomResponse<NoResult>> addDentalService(
      BaseDentalService dentalService) async {
    return await dentistDataSource.addDentalService(dentalService);
  }

  @override
  Future<CustomResponse<NoResult>> addMedication(String medicationName) async {
    return await dentistDataSource.addMedication(medicationName);
  }

  @override
  Future<CustomResponse<NoResult>> deleteDentalService(
      BaseDentalService dentalService) async {
    return await dentistDataSource.deleteDentalService(dentalService);
  }

  @override
  Future<CustomResponse<List<BaseDentalService>>> getDentalServices() async {
    return await dentistDataSource.getDentalServices();
  }

  @override
  Future<CustomResponse<List<String>>> getMedicationsList() async {
    return await dentistDataSource.getMedicationsList();
  }

  @override
  Future<CustomResponse<NoResult>> updateDentalService(
      BaseDentalService dentalService) async {
    return await dentistDataSource.updateDentalService(dentalService);
  }

  @override
  CustomResponse<Locale?> getSelectedLocale() {
    return dentistDataSource.getSelectedLocale();
  }

  @override
  CustomResponse<ThemeMode?> getSelectedTheme() {
    return dentistDataSource.getSelectedTheme();
  }

  @override
  Future<CustomResponse<NoResult>> updateSelectedLocal(Locale locale) async {
    return await dentistDataSource.updateSelectedLocal(locale);
  }

  @override
  Future<CustomResponse<NoResult>> updateSelectedTheme(ThemeMode mode) async {
    return await dentistDataSource.updateSelectedTheme(mode);
  }

  @override
  Future<BaseDentist?> getStoredAppUser() async {
    return await dentistDataSource.getLocallyStoredDentist();
  }

  @override
  Future<CustomResponse<NoResult>> saveLocally() async {
    return await dentistDataSource.saveLocally();
  }

  @override
  Future<CustomResponse<NoResult>> saveRemotely() async {
    return await dentistDataSource.saveRemotely();
  }

  @override
  Future<CustomResponse<NoResult>> deleteLocalData() async {
    return await dentistDataSource.deleteLocalData();
  }

  @override
  Future<CustomResponse<List<int>>> getNonWorkingDays() async {
    return await dentistDataSource.getNonWorkingDays();
  }

  @override
  Future<CustomResponse<List<TimeOfDay>>> getWorkHours(int day) async {
    return await dentistDataSource.getWorkHours(day);
  }

  @override
  Future<CustomResponse<NoResult>> updateDayWorkHours({
    required int day,
    required List<TimeOfDay> workHours,
  }) async {
    return await dentistDataSource.updateDayWorkHours(
        day: day, workHours: workHours);
  }

  @override
  Future<CustomResponse<NoResult>> updateNonWorkingDays(
      {required List<int> days}) async {
    return await dentistDataSource.updateNonWorkingDays(days: days);
  }
}
