import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formvalidation/core/const/controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';

part 'addServices_event.dart';
part 'addServices_state.dart';

class AddServicesBloc extends Bloc<AddServicesEvent, AddServicesState> {
  ImagePicker imagePicker = ImagePicker();
  File? pickedImage;

  Logger logger = Logger();

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
    on<UpdateCarTypeItemEvent>(_updateCarTypeItem);
    on<DeleteCarTypeItemEvent>(_deleteCarTypeItem);
    on<SubmitAddServiceEvent>(_submitAddService);

    on<PriceAndDuractionEvent>(_onCarTypeFromData);
  }
  _onPickImageEvent(PickImageEvent event, emit) async {
    emit(PickImageEventLoadingState());
    try {
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
        emit(PickImageEventSuccessState(images: pickedImage!));
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

  _onCarTypeFromData(event, emit) {
    carFromDate.add(CarTypeFormData());
    emit(PriceAndDuractionState());
  }

  _updateCarTypeItem(
    UpdateCarTypeItemEvent event,
    Emitter<AddServicesState> emit,
  ) {
    final updatedList = List<CarTypeFormData>.from(carFromDate);

    final carData = updatedList[event.index];

    if (event.selectedCarType != null) {
      carData.selectedCarType = event.selectedCarType;
    }
    if (event.garagePrice != null) {
      carData.garagePriceField.text = event.garagePrice!;
    }
    if (event.garageDuration != null) {
      carData.garageDurationField.text = event.garageDuration!;
    }
    if (event.doorstepPrice != null) {
      carData.doorstepPriceField.text = event.doorstepPrice!;
    }
    if (event.doorstepDuration != null) {
      carData.doorstepDurationField.text = event.doorstepDuration!;
    }

    carFromDate = updatedList;

    emit(PriceAndDuractionState());
  }

  _deleteCarTypeItem(
    DeleteCarTypeItemEvent event,
    Emitter<AddServicesState> emit,
  ) {
    final updatedList = List<CarTypeFormData>.from(carFromDate);
    if (event.index >= 0 && event.index < updatedList.length) {
      updatedList.removeAt(event.index);
    }
    carFromDate = updatedList;

    emit(PriceAndDuractionState());
  }

  void _submitAddService(
    SubmitAddServiceEvent event,
    Emitter<AddServicesState> emit,
  ) async {
    emit(SubmitAddServiceLoadingState());

    try {
      final title = event.title;
      final description = event.description;
      final isAvailable = this.isAvailable;
      final vehicleTypes = List<String>.from(vehicleType);
      final serviceTypes = List<String>.from(serviceType);
      final cars = List<CarTypeFormData>.from(carFromDate);
      final image = pickedImage;

      List<Map<String, dynamic>> carsJson = cars.map((car) {
        return {
          'selectedCarType': car.selectedCarType,

          'garagePriceField': car.garagePriceField.text,
          'garageDurationField': car.garageDurationField.text,
          'doorstepPriceField': car.doorstepPriceField.text,
          'doorstepDurationField': car.doorstepDurationField.text,
        };
      }).toList();

      Map<String, dynamic> dataMap = {
        'title': title,
        'description': description,
        'isAvailable': isAvailable,
        'vehicleTypes': vehicleTypes,
        'serviceTypes': serviceTypes,
        'cars': carsJson,
        'pickedImagePath': image?.path,
      };

      String jsonData = const JsonEncoder.withIndent('  ').convert(dataMap);

      logger.d(jsonData);

      emit(SubmitAddServiceSuccessState());
    } catch (e, s) {
      logger.e("SUBMIT ADDSERVICE API =>", error: e, stackTrace: s);
      emit(SubmitAddServiceErrorState(error: e.toString()));
    }
  }
}
