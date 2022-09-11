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
  Future<Result<None>> saveRemotely() async {
    if (currentDentist != null) {
      await currentDentist!.save();
      return Result.withNoResult(
          success: await currentDentist!.fetch() == currentDentist);
    } else {
      return Result.failure(
          errorMessage: 'Cannot save dentist data before it\'s defined');
    }
  }

  @override
  Future<Result<None>> saveLocally() async {
    if (currentDentist != null) {
      await currentDentist!.saveInStorage(currentDentist!.objectId!);
      return Result.withNoResult(
          success: await getLocallyStoredDentist() == currentDentist);
    } else {
      return Result.failure(
          errorMessage: 'Cannot save dentist data before it\'s defined');
    }
  }

  @override
  Future<Result<ParseDentist>> getDentistFromServer() async {
    if (currentDentist != null) {
      final returnedDentist = await currentDentist!.fetch();
      return Result(
        result: returnedDentist as ParseDentist?,
        success: returnedDentist is ParseDentist,
      );
    } else {
      return Result.failure(errorMessage: 'user not found!');
    }
  }

  @override
  Future<Result<None>> deleteLocalData() async {
    bool _deleteCompleted = false;
    if (currentDentist != null && currentDentist?.objectId != null) {
      ParseCoreData.instance.storage.remove(currentDentist!.objectId!);
      _deleteCompleted = await getLocallyStoredDentist() == null;
    }
    return SuccessResult: _deleteCompleted);
  }

  @override
  Future<ParseDentist?> getLocallyStoredDentist() async {
    return await ParseUser.currentUser(
      customUserObject: ParseObject('Dentist'),
    );
  }

  @override
  Future<Result<None>> addDentalService(BaseDentalService dentalService) {
    // @override
    // Future<Result<None>> updateDentalService(
    //     BaseDentalService newDentalService) async {
    //   final serviceIndex = _user?.dentalServices
    //       .indexWhere((t) => t.name == newDentalService.name);
    //   if (serviceIndex != null) {
    //     _user?.dentalServices[serviceIndex] = newDentalService;
    //     return await dataSource.updateUserData();
    //   }
    //   return Result.failure(
    //     errorMessage: 'Failed to update the following dental service:\n' +
    //         newDentalService.toJson().toString(),
    //   );
    // }
    // TODO: implement addDentalService
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> addMedication(String medicationName) {
    // TODO: implement addMedication
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> deleteDentalService(BaseDentalService dentalService) {
    // TODO: implement deleteDentalService
    throw UnimplementedError();
  }

  @override
  Future<Result<List<DentalService>>> getDentalServices() {
    // TODO: implement getDentalServices
    throw UnimplementedError();
  }

  @override
  Future<Result<List<String>>> getMedicationsList() {
    // TODO: implement getMedicationsList
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> updateDentalService(BaseDentalService dentalService) {
    // TODO: implement updateDentalService
    throw UnimplementedError();
  }

  @override
  Result<Locale?> getSelectedLocale() {
    // TODO: implement getSelectedLocale
    throw UnimplementedError();
  }

  @override
  Result<ThemeMode?> getSelectedTheme() {
    // TODO: implement getSelectedTheme
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> updateSelectedLocal(Locale locale) {
    // TODO: implement updateSelectedLocal
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> updateSelectedTheme(ThemeMode mode) {
    // TODO: implement updateSelectedTheme
    throw UnimplementedError();
  }

  @override
  Future<Result<List<int>>> getNonWorkingDays() {
    // TODO: implement getNonWorkingDays
    throw UnimplementedError();
  }

  @override
  Future<Result<List<TimeOfDay>>> getWorkHours(int day) {
    // TODO: implement getWorkHours
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> updateDayWorkHours({
    required int day,
    required List<TimeOfDay> workHours,
  }) {
    // TODO: implement updateDayWorkHours
    throw UnimplementedError();
  }

  @override
  Future<Result<None>> updateNonWorkingDays({required List<int> days}) {
    // TODO: implement updateNonWorkingDays
    throw UnimplementedError();
  }
}
