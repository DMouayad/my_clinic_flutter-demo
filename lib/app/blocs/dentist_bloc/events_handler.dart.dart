import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:clinic_v2/common/features/users/data/dentist_data.dart';
import 'package:clinic_v2/common/features/users/domain/dentist_contracts.dart';
import 'package:dartz/dartz.dart';

import 'dentist_bloc.dart';

@protected
class DentistBlocEventsHandler {
  final BaseDentistRepository _dentistRepository;

  DentistBlocEventsHandler(this._dentistRepository);

  Future<DentistState> handleEvent(DentistEvent event) async {
    return await event.whenEvent(
      dentalServicesRequested: (event) async {
        return _getState(await _getDentalServices());
      },
      addingDentalServiceRequested: (event) async {
        return _getState(await _addDentalService(event.dentalService));
      },
      deleteDentalServiceRequested: (event) async {
        return _getState(await _deleteDentalService(event.dentalService));
      },
      addingDentalServicePriceRequested: (event) async {
        return _getState(
          await _addDentalServicePrice(event.dentalService, event.price),
        );
      },
      deleteDentalServicePriceRequested: (event) async {
        return _getState(
          await _deleteDentalServicePrice(event.dentalService, event.price),
        );
      },
      updatingDentalServicePriceRequested: (event) async {
        return _getState(await _updateDentalServicePrice(
          dentalService: event.dentalService,
          oldPrice: event.oldPrice,
          newPrice: event.newPrice,
        ));
      },
      medicationListRequested: (event) async {
        return _getState(await _getMedicationsList());
      },
      addingMedicationRequested: (event) async {
        return _getState(await _addMedication(event.medication));
      },
    );
  }

  Future<Either<DentistErrorState, DentalServicesFetched>>
      _getDentalServices() async {
    final response = await _dentistRepository.getDentalServices();
    if (response.success) {
      return Right(DentalServicesFetched(response.result!));
    } else {
      return Left(DentistErrorState(response.error!));
    }
  }

  Future<Either<DentistErrorState, DentalServiceAdded>> _addDentalService(
      DentalService dentalService) async {
    final response = await _dentistRepository.addDentalService(dentalService);
    if (response.success) {
      return Right(DentalServiceAdded());
    } else {
      return Left(DentistErrorState(response.error!));
    }
  }

  Future<Either<DentistErrorState, DentalServiceDeleted>> _deleteDentalService(
      DentalService dentalService) async {
    final response =
        await _dentistRepository.deleteDentalService(dentalService);
    if (response.success) {
      return Right(DentalServiceDeleted());
    } else {
      return Left(DentistErrorState(response.error!));
    }
  }

  Future<Either<DentistErrorState, DentalServicePriceAdded>>
      _addDentalServicePrice(
    DentalService dentalService,
    double price,
  ) async {
    dentalService.prices.add(price);
    final response = await _dentistRepository.updateDentalService(
      dentalService.copyWith(prices: dentalService.prices),
    );
    if (response.success) {
      return Right(DentalServicePriceAdded());
    } else {
      return Left(DentistErrorState(response.error!));
    }
  }

  Future<Either<DentistErrorState, DentalServicePriceDeleted>>
      _deleteDentalServicePrice(
    DentalService dentalService,
    double price,
  ) async {
    dentalService.prices.remove(price);
    final response = await _dentistRepository.updateDentalService(
      dentalService.copyWith(prices: dentalService.prices),
    );
    if (response.success) {
      return Right(DentalServicePriceDeleted());
    } else {
      return Left(DentistErrorState(response.error!));
    }
  }

  Future<Either<DentistErrorState, DentalServicePriceUpdated>>
      _updateDentalServicePrice({
    required DentalService dentalService,
    required double newPrice,
    required double oldPrice,
  }) async {
    final priceIndex = dentalService.prices.indexOf(oldPrice);
    dentalService.prices[priceIndex] = newPrice;
    final response = await _dentistRepository.updateDentalService(
      dentalService.copyWith(prices: dentalService.prices),
    );
    if (response.success) {
      return Right(DentalServicePriceUpdated());
    } else {
      return Left(DentistErrorState(response.error!));
    }
  }

  Future<Either<DentistErrorState, MedicationsFetched>>
      _getMedicationsList() async {
    final response = await _dentistRepository.getMedicationsList();
    if (response.success) {
      return Right(MedicationsFetched(response.result!));
    } else {
      return Left(DentistErrorState(response.error!));
    }
  }

  Future<Either<DentistErrorState, MedicationAdded>> _addMedication(
    String medication,
  ) async {
    final response = await _dentistRepository.addMedication(medication);
    if (response.success) {
      return Right(MedicationAdded());
    } else {
      return Left(DentistErrorState(response.error!));
    }
  }

  DentistState _getState(Either<DentistState, DentistState> eitherResult) {
    return eitherResult.fold((l) => l, (r) => r);
  }
}
