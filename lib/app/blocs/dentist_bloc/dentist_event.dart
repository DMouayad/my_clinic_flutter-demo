part of 'dentist_bloc.dart';

abstract class DentistEvent extends UserEvent {
  const DentistEvent();

  Future<DentistState> whenEvent({
    required Future<DentistState> Function(DentalServicesRequested)
        dentalServicesRequested,
    required Future<DentistState> Function(AddingDentalServiceRequested)
        addingDentalServiceRequested,
    required Future<DentistState> Function(DeleteDentalServiceRequested)
        deleteDentalServiceRequested,
    required Future<DentistState> Function(AddingDentalServicePriceRequested)
        addingDentalServicePriceRequested,
    required Future<DentistState> Function(DeleteDentalServicePriceRequested)
        deleteDentalServicePriceRequested,
    required Future<DentistState> Function(UpdatingDentalServicePriceRequested)
        updatingDentalServicePriceRequested,
    required Future<DentistState> Function(MedicationListRequested)
        medicationListRequested,
    required Future<DentistState> Function(AddingMedicationRequested)
        addingMedicationRequested,
  }) async {
    if (this is AddingDentalServiceRequested) {
      return await addingDentalServiceRequested
          .call(this as AddingDentalServiceRequested);
    }
    if (this is DeleteDentalServiceRequested) {
      return await deleteDentalServiceRequested
          .call(this as DeleteDentalServiceRequested);
    }
    if (this is AddingDentalServicePriceRequested) {
      return await addingDentalServicePriceRequested
          .call(this as AddingDentalServicePriceRequested);
    }
    if (this is DeleteDentalServicePriceRequested) {
      return await deleteDentalServicePriceRequested
          .call(this as DeleteDentalServicePriceRequested);
    }
    if (this is UpdatingDentalServicePriceRequested) {
      return await updatingDentalServicePriceRequested
          .call(this as UpdatingDentalServicePriceRequested);
    }
    if (this is MedicationListRequested) {
      return await medicationListRequested
          .call(this as MedicationListRequested);
    }
    if (this is AddingMedicationRequested) {
      return await addingMedicationRequested
          .call(this as AddingMedicationRequested);
    }
    throw UnimplementedError(
      'Dentist event "$this" of type $runtimeType is not handled',
    );
  }
}

class DentalServicesRequested extends DentistEvent {}

class AddingDentalServiceRequested extends DentistEvent {
  final DentalService dentalService;

  const AddingDentalServiceRequested(this.dentalService);

  @override
  List<Object> get props => [dentalService];
}

class DeleteDentalServiceRequested extends DentistEvent {
  final DentalService dentalService;

  const DeleteDentalServiceRequested(this.dentalService);

  @override
  List<Object> get props => [dentalService];
}

class AddingDentalServicePriceRequested extends DentistEvent {
  final DentalService dentalService;
  final double price;
  const AddingDentalServicePriceRequested({
    required this.dentalService,
    required this.price,
  });

  @override
  List<Object> get props => [dentalService, price];
}

class DeleteDentalServicePriceRequested extends DentistEvent {
  final DentalService dentalService;
  final double price;
  const DeleteDentalServicePriceRequested({
    required this.dentalService,
    required this.price,
  });

  @override
  List<Object> get props => [dentalService, price];
}

class UpdatingDentalServicePriceRequested extends DentistEvent {
  final DentalService dentalService;
  final double oldPrice;
  final double newPrice;
  const UpdatingDentalServicePriceRequested({
    required this.dentalService,
    required this.oldPrice,
    required this.newPrice,
  });

  @override
  List<Object> get props => [dentalService, oldPrice, newPrice];
}

class MedicationListRequested extends DentistEvent {}

class AddingMedicationRequested extends DentistEvent {
  final String medication;

  const AddingMedicationRequested(this.medication);

  @override
  List<Object> get props => [medication];
}
