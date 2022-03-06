// ignore_for_file: avoid_print

part of dentist_data;

/// Data source for a dentist,
/// uses [Parse] to connects to the database.
/// - Provides:
/// dentist clinic-data management, local storage, cloud storage.

class DentistParseDS implements BaseDentistDataSource<ParseDentist> {
  @override
  ParseDentist? currentDentist;

  @override
  Future<void> init() async {
    currentDentist = await getLocallyStoredDentist();
  }

  @override
  Future<CustomResponse<NoResult>> saveRemotely() async {
    if (currentDentist != null) {
      await currentDentist!.save();
      return CustomResponse.withNoResult(
          success: await currentDentist!.fetch() == currentDentist);
    } else {
      return CustomResponse.failure(
          errorMessage: 'Cannot save dentist data before it\'s defined');
    }
  }

  @override
  Future<CustomResponse<NoResult>> saveLocally() async {
    if (currentDentist != null) {
      await currentDentist!.saveInStorage(currentDentist!.objectId!);
      return CustomResponse.withNoResult(
          success: await getLocallyStoredDentist() == currentDentist);
    } else {
      return CustomResponse.failure(
          errorMessage: 'Cannot save dentist data before it\'s defined');
    }
  }

  @override
  Future<CustomResponse<ParseDentist>> getDentistFromServer() async {
    if (currentDentist != null) {
      final returnedDentist = await currentDentist!.fetch();
      return CustomResponse(
        result: returnedDentist as ParseDentist?,
        success: returnedDentist is ParseDentist,
      );
    } else {
      return CustomResponse.failure(errorMessage: 'user not found!');
    }
  }

  @override
  Future<CustomResponse<NoResult>> deleteLocalData() async {
    bool _deleteCompleted = false;
    if (currentDentist != null && currentDentist?.objectId != null) {
      ParseCoreData.instance.storage.remove(currentDentist!.objectId!);
      _deleteCompleted = await getLocallyStoredDentist() == null;
    }
    return CustomResponse(success: _deleteCompleted);
  }

  @override
  Future<ParseDentist?> getLocallyStoredDentist() async {
    return await ParseUser.currentUser(
      customUserObject: ParseObject('Dentist'),
    );
  }

  @override
  Future<CustomResponse<NoResult>> addDentalService(
      BaseDentalService dentalService) {
    // @override
    // Future<CustomResponse<NoResult>> updateDentalService(
    //     BaseDentalService newDentalService) async {
    //   final serviceIndex = _user?.dentalServices
    //       .indexWhere((t) => t.name == newDentalService.name);
    //   if (serviceIndex != null) {
    //     _user?.dentalServices[serviceIndex] = newDentalService;
    //     return await dataSource.updateUserData();
    //   }
    //   return CustomResponse.failure(
    //     errorMessage: 'Failed to update the following dental service:\n' +
    //         newDentalService.toJson().toString(),
    //   );
    // }
    // TODO: implement addDentalService
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> addMedication(String medicationName) {
    // TODO: implement addMedication
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> deleteDentalService(
      BaseDentalService dentalService) {
    // TODO: implement deleteDentalService
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<List<DentalService>>> getDentalServices() {
    // TODO: implement getDentalServices
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<List<String>>> getMedicationsList() {
    // TODO: implement getMedicationsList
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> updateDentalService(
      BaseDentalService dentalService) {
    // TODO: implement updateDentalService
    throw UnimplementedError();
  }

  @override
  CustomResponse<Locale?> getSelectedLocale() {
    // TODO: implement getSelectedLocale
    throw UnimplementedError();
  }

  @override
  CustomResponse<ThemeMode?> getSelectedTheme() {
    // TODO: implement getSelectedTheme
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> updateSelectedLocal(Locale locale) {
    // TODO: implement updateSelectedLocal
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> updateSelectedTheme(ThemeMode mode) {
    // TODO: implement updateSelectedTheme
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<List<int>>> getNonWorkingDays() {
    // TODO: implement getNonWorkingDays
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<List<TimeOfDay>>> getWorkHours(int day) {
    // TODO: implement getWorkHours
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> updateDayWorkHours({
    required int day,
    required List<TimeOfDay> workHours,
  }) {
    // TODO: implement updateDayWorkHours
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<NoResult>> updateNonWorkingDays(
      {required List<int> days}) {
    // TODO: implement updateNonWorkingDays
    throw UnimplementedError();
  }
}
