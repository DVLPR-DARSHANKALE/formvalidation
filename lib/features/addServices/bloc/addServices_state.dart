part of 'addServices_bloc.dart';

sealed class AddServicesState extends Equatable {
  const AddServicesState();

  @override
  List<Object> get props => [];
}

final class AddServicesInitial extends AddServicesState {}

class PickImageEventStates extends AddServicesState {}

class PickImageEventLoadingState extends PickImageEventStates {}

class PickImageEventSuccessState extends PickImageEventStates {
  final File images;

  PickImageEventSuccessState({required this.images});
  @override
  List<Object> get props => [images];
}

class PickImageEventErrorState extends PickImageEventStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  PickImageEventErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}

class ToggleSwitchState extends AddServicesState {
  final bool value;

  const ToggleSwitchState({required this.value});
  @override
  List<Object> get props => [value];
}

class VehicleTypeState extends AddServicesState {
  final DateTime _dateTime = DateTime.now();
  @override
  // TODO: implement props
  List<Object> get props => [_dateTime];
}

class ServiceTypeState extends AddServicesState {
  final DateTime _dateTime = DateTime.now();
  @override
  // TODO: implement props
  List<Object> get props => [_dateTime];
}

class CarTypeState extends AddServicesState {
  final String selectedType;

  const CarTypeState({required this.selectedType});

  @override
  //
  List<Object> get props => [selectedType];
}

class PriceAndDuractionState extends AddServicesState {
  final DateTime _dateTime = DateTime.now();

  @override
  // TODO: implement props
  List<Object> get props => [_dateTime];
}
