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

class PriceAndDuractionEvent extends AddServicesEvent {}

class UpdateCarTypeItemEvent extends AddServicesEvent {
  final int index;
  final String? selectedCarType;
  final String? garagePrice;
  final String? garageDuration;
  final String? doorstepPrice;
  final String? doorstepDuration;

  const UpdateCarTypeItemEvent({
    required this.index,
    this.selectedCarType,
    this.garagePrice,
    this.garageDuration,
    this.doorstepPrice,
    this.doorstepDuration,
  });

  @override
  List<Object> get props => [
    index,
    selectedCarType ?? '',
    garagePrice ?? '',
    garageDuration ?? '',
    doorstepPrice ?? '',
    doorstepDuration ?? '',
  ];
}

class DeleteCarTypeItemEvent extends AddServicesEvent {
  final int index;
  const DeleteCarTypeItemEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class SubmitAddServiceEvent extends AddServicesEvent {
  final String title;
  final String description;

  const SubmitAddServiceEvent({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
