import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formvalidation/core/const/controller.dart';
import 'package:image_picker/image_picker.dart';

part 'addServices_event.dart';
part 'addServices_state.dart';

class AddServicesBloc extends Bloc<AddServicesEvent, AddServicesState> {
  ImagePicker imagePicker = ImagePicker();
  File? pickedImage;

  List vehicleType = [];

  List<CarTypeFormData> carFromDate = [];

  List serviceType = [];
  bool isAvailable = false;
  AddServicesBloc() : super(AddServicesInitial()) {
    on<PickImageEvent>(_onPickImageEvent);
    on<RemoveImageEvent>(_onRemoveImageEvent);
    on<ToggleSwitchEvent>(_onToggelSwitchEvent);
    on<VehicleTypeEvent>(_onSelectVehicleTypeEvent);
    on<ServiceTypeEvent>(_onServiceTypeEvent);
    // on<CarTypeSelectedEvent>(_onCarTypeEvent);
    on<PriceAndDuractionEvent>(_onCarTypeFromData);
  }
  _onPickImageEvent(PickImageEvent event, emit) async {
    emit(PickImageEventLoadingState());
    try {
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(PickImageEventSuccessState(images: File(pickedFile.path)));
      }
    } catch (e) {
      emit(PickImageEventErrorState(error: e.toString()));
    }
  }

  _onRemoveImageEvent(event, emit) {
    pickedImage = null;
    emit(AddServicesInitial());
  }

  _onToggelSwitchEvent(ToggleSwitchEvent event, emit) {
    isAvailable = event.newValue;
    emit(ToggleSwitchState(value: isAvailable));
  }

  _onSelectVehicleTypeEvent(VehicleTypeEvent event, emit) {
    if (vehicleType.contains(event.value)) {
      vehicleType.remove(event.value);
    } else {
      vehicleType.add(event.value);
    }

    emit(VehicleTypeState());
  }

  _onServiceTypeEvent(ServiceTypeEvent event, emit) {
    if (serviceType.contains(event.value)) {
      serviceType.remove(event.value);
    } else {
      serviceType.add(event.value);
    }
    emit(ServiceTypeState());
  }

  // _onCarTypeEvent(CarTypeSelectedEvent event, emit) {
  //   carType = event.selectedType;
  //   emit(CarTypeState(selectedType: carType!));
  // }

  _onCarTypeFromData(event, emit) {
    carFromDate.add(CarTypeFormData());
    emit(PriceAndDuractionState());
  }
}
