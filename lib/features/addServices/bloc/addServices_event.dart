part of 'addServices_bloc.dart';

sealed class AddServicesEvent extends Equatable {
  const AddServicesEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends AddServicesEvent {}

class RemoveImageEvent extends AddServicesEvent {}

class ToggleSwitchEvent extends AddServicesEvent {
  final bool newValue;
  const ToggleSwitchEvent(this.newValue);

  @override
  List<Object> get props => [newValue];
}

class VehicleTypeEvent extends AddServicesEvent {
  final String value;
  final DateTime _dateTime = DateTime.now();

  VehicleTypeEvent({required this.value});
  @override
  List<Object> get props => [value, _dateTime];
}

class ServiceTypeEvent extends AddServicesEvent {
  final String value;
  final DateTime _dateTime = DateTime.now();

  ServiceTypeEvent({required this.value});
  @override
  List<Object> get props => [value, _dateTime];
}

class CarTypeSelectedEvent extends AddServicesEvent {
  final String selectedType;
  const CarTypeSelectedEvent(this.selectedType);
  @override
  List<Object> get props => [selectedType];
}

class PriceAndDuractionEvent extends AddServicesEvent {}
