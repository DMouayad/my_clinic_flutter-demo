import 'package:clinic_v2/core/features/users/data/dentist_data.dart';
import 'package:clinic_v2/core/features/users/domain/dentist_contracts.dart';

import 'app_user_use_cases.dart';

abstract class DentistUseCases extends UserUseCases<BaseDentist> {
  final BaseDentistRepository dentistRepository;

  DentistUseCases(this.dentistRepository);

  Future<List<DentalService>> getDentalServices();
  Future<void> addDentalService(DentalService dentalService);
  Future<void> addDentalServicePrice(DentalService dentalService, double price);
  Future<void> deleteDentalServicePrice(
      DentalService dentalService, double price);
  Future<void> updateDentalServicePrice({
    required DentalService dentalService,
    required double newPrice,
    required double oldPrice,
  });
  Future<void> deleteDentalService(DentalService dentalService);
  Future<List<String>> getMedicationsList();
  Future<void> addMedication(String value);
}
