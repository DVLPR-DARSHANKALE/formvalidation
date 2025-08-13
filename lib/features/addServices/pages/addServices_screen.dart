import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formvalidation/features/addServices/bloc/addServices_bloc.dart';

class AddServicesScreen extends StatelessWidget {
  AddServicesScreen({super.key});

  final List<String> carTypes = [
    "Hatchback",
    "Sedan",
    "SUV",
    "MUV",
    "Coupe",
    "Convertible",
    "Pickup Truck",
    "Van",
    "Jeep",
    "Sports Car",
    "Luxury Car",
    "Electric Car",
    "Hybrid Car",
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController titleField = TextEditingController();
    TextEditingController descField = TextEditingController();
    final GlobalKey<FormState> formkey = GlobalKey();

    final bloc = context.read<AddServicesBloc>();

    return Scaffold(
      appBar: AppBar(title: Text("Add new services")),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              // Image Picker section
              BlocBuilder<AddServicesBloc, AddServicesState>(
                builder: (context, state) {
                  if (state is PickImageEventLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is PickImageEventSuccessState) {
                    return GestureDetector(
                      onTap: () {
                        // bloc.add(PickImageEvent());
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 150,
                            width: 330,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                state.images,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            left: -3,
                            child: FilledButton.icon(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.black,
                                ),
                              ),
                              onPressed: () {
                                bloc.add(RemoveImageEvent());
                              },
                              label: Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      bloc.add(PickImageEvent());
                    },
                    child: Container(
                      height: 100,
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.cloud_upload,
                            size: 40,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Upload Image",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 10),

              // Form Title & Description
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      controller: titleField,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descField,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Available Switch
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Available",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    BlocBuilder<AddServicesBloc, AddServicesState>(
                      buildWhen: (previous, current) =>
                          current is ToggleSwitchState,
                      builder: (context, state) {
                        bool switchValue = false;
                        if (state is ToggleSwitchState) {
                          switchValue = state.value;
                        }

                        return Switch(
                          activeColor: Colors.white,
                          activeTrackColor: Colors.black,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                          value: switchValue,
                          onChanged: (val) {
                            context.read<AddServicesBloc>().add(
                              ToggleSwitchEvent(val),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Vehicle Type Checkboxes
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Vehicle Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<AddServicesBloc, AddServicesState>(
                      buildWhen: (previous, current) =>
                          current is VehicleTypeState,
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: bloc.vehicleType.contains(
                                      "Four Wheeler",
                                    ),
                                    onChanged: (value) {
                                      bloc.add(
                                        VehicleTypeEvent(value: "Four Wheeler"),
                                      );
                                    },
                                  ),
                                  Text("Four Wheeler"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: bloc.vehicleType.contains(
                                      "Two Wheeler",
                                    ),
                                    onChanged: (value) {
                                      bloc.add(
                                        VehicleTypeEvent(value: "Two Wheeler"),
                                      );
                                    },
                                  ),
                                  Text("Two Wheeler"),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Service Type Checkboxes
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Service Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<AddServicesBloc, AddServicesState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: bloc.serviceType.contains(
                                      "Doorstep",
                                    ),
                                    onChanged: (value) {
                                      bloc.add(
                                        ServiceTypeEvent(value: "Doorstep"),
                                      );
                                    },
                                  ),
                                  Text("Doorstep"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: bloc.serviceType.contains("Garrage"),
                                    onChanged: (value) {
                                      bloc.add(
                                        ServiceTypeEvent(value: "Garrage"),
                                      );
                                    },
                                  ),
                                  Text("Garrage"),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Four Wheeler Type List
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Four Wheeler Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    BlocBuilder<AddServicesBloc, AddServicesState>(
                      builder: (context, state) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 10),
                          shrinkWrap: true,
                          itemCount: bloc.carFromDate.length,
                          itemBuilder: (context, index) =>
                              cartTypeform(bloc, index),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          bloc.add(PriceAndDuractionEvent());
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(Icons.add, size: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      bloc.add(
                        SubmitAddServiceEvent(
                          title: titleField.text,
                          description: descField.text,
                        ),
                      );
                    }
                  },
                  child: Text("Add Service"),
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartTypeform(AddServicesBloc bloc, int index) {
    final carData = bloc.carFromDate[index];
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${index + 1}. Type"),
              IconButton(
                onPressed: () {
                  bloc.add(DeleteCarTypeItemEvent(index: index));
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
          DropdownButton<String>(
            hint: const Text("Select Car Type"),
            value: bloc.carFromDate[index].selectedCarType,
            items: carTypes
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                bloc.add(
                  UpdateCarTypeItemEvent(index: index, selectedCarType: value),
                );
              }
            },
          ),
          const SizedBox(height: 8),
          Text("at Garrage"),
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: carData.garagePriceField,
                    decoration: InputDecoration(
                      hintText: "Price",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: carData.garageDurationField,
                    decoration: InputDecoration(
                      hintText: "Duration",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<AddServicesBloc, AddServicesState>(
            builder: (context, state) {
              if (bloc.serviceType.contains("Doorstep")) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text("at Doorstep"),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: carData.doorstepPriceField,
                            decoration: InputDecoration(
                              hintText: "Price",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: carData.doorstepDurationField,
                            decoration: InputDecoration(
                              hintText: "Duration",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
