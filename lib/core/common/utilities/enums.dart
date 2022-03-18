enum PaymentStatus {
  pending,
  paid,
}

enum ApptStatus {
  missed,
  upcoming,
  finished,
}
enum UserRole { admin, dentist, secretary }
enum SettingsType {
  appearance,
  language,
}

enum PatientGender { male, female, unknown }
enum TreatmentCategory { newTreatment, previousTreatment }
enum TreatmentStatus { planned, completed }

enum DentalServiceType {
  consultation,
  checkUp,
  periodontal,
  fillings,
  extractions,
  rootCanal,
  dentalCrowns,
  dentalImplants,
  cosmetic,
}
