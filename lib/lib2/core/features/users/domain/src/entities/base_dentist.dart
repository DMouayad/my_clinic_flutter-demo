part of dentist_contracts;

/// - App User of type Dentist
abstract class BaseDentist extends BaseAppUser {
  /// - the dental services which the doctor provides
  List<BaseDentalService> dentalServices;

  /// - list of medication that the doctor usually prescribe in addition to other popular medication.
  List<String> medicationsList;
  WorkSchedule calendar;

  BaseDentist({
    required String id,
    required bool isLoggedIn,
    required this.dentalServices,
    required this.medicationsList,
    required this.calendar,
  }) : super(
          id: id,
          isLoggedIn: isLoggedIn,
          role: UserRole.dentist,
        );
}
