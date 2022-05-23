part of dentist_contracts;

/// - App User of type Dentist
abstract class BaseDentist extends BaseAppUser {
  /// - the dental services which the doctor provides
  List<BaseDentalService> dentalServices;

  /// - list of medication that the doctor usually prescribe in addition to other popular medication.
  List<String> medicationsList;

  BaseDentist({
    required String id,
    required bool isLoggedIn,
    required DentistCalendar userCalendar,
    required this.dentalServices,
    required this.medicationsList,
  }) : super(
          id: id,
          isLoggedIn: isLoggedIn,
          role: UserRole.dentist,
          userCalendar: userCalendar,
        );
}
