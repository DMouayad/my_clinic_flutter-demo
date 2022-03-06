part of 'dentist_bloc.dart';

class DentistState extends UserState {
  const DentistState();
}

class DentistInitial extends DentistState {}

class DentistErrorState extends DentistState {
  final CustomError error;
  const DentistErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class DentalServicesFetched extends DentistState {
  final List<BaseDentalService> dentalServices;

  const DentalServicesFetched(this.dentalServices);
  @override
  List<Object> get props => [dentalServices];
}

class DentalServiceAdded extends DentistState {}

class DentalServiceDeleted extends DentistState {}

class DentalServicePriceAdded extends DentistState {}

class DentalServicePriceDeleted extends DentistState {}

class DentalServicePriceUpdated extends DentistState {}

class MedicationsFetched extends DentistState {
  final List<String> medications;

  const MedicationsFetched(this.medications);
  @override
  List<Object> get props => [medications];
}

class MedicationAdded extends DentistState {}
