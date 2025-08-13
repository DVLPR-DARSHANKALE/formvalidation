import 'package:flutter/material.dart';

class CarTypeFormData {
  String? selectedCarType;

  TextEditingController garagePriceField = TextEditingController();
  TextEditingController garageDurationField = TextEditingController();
  TextEditingController doorstepPriceField = TextEditingController();
  TextEditingController doorstepDurationField = TextEditingController();

  dispose() {
    garageDurationField.dispose();
    garagePriceField.dispose();
    doorstepPriceField.dispose();
    doorstepDurationField.dispose();
  }
}
