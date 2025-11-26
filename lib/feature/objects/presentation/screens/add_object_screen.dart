import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_post_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/presentation/cubits/cubit/add_object/cubit/add_object_cubit.dart';

class AddObjectScreen extends StatefulWidget {
  const AddObjectScreen({super.key});

  @override
  State<AddObjectScreen> createState() => _AddObjectScreenState();
}

class _AddObjectScreenState extends State<AddObjectScreen> {
  final TextEditingController nameController = TextEditingController();

  /// list of key/value dynamic fields
  List<MapEntry<TextEditingController, TextEditingController>> fields = [
    MapEntry(TextEditingController(), TextEditingController()),
  ];

  void addNewField() {
    setState(() {
      fields.add(MapEntry(TextEditingController(), TextEditingController()));
    });
  }

  void removeField(int index) {
    if (fields.length == 1) return;
    setState(() {
      fields.removeAt(index);
    });
  }

  Map<String, dynamic> buildDataMap() {
    final map = <String, dynamic>{};
    for (var entry in fields) {
      final key = entry.key.text.trim();
      final value = entry.value.text.trim();

      if (key.isNotEmpty) {
        map[key] = value;
      }
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddObjectCubit(),
      child: BlocConsumer<AddObjectCubit, AddObjectState>(
        listener: (context, state) {
          if (state is AddObjectLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is AddObjectSuccess) {
            Navigator.pop(context); // close dialog
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Object Added Successfully!")),
            );
            print("Response from backend:");
            print("ID: ${state.object.id}");
            print("Name: ${state.object.name}");
            print("CreatedAt: ${state.object.createdAt}");
            print("Data: ${state.object.data}");
          }

          if (state is AddObjectFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Add Object")),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// NAME FIELD
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Object Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// DYNAMIC FIELDS
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: fields.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: fields[index].key,
                              decoration: const InputDecoration(
                                labelText: "Key",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: fields[index].value,
                              decoration: const InputDecoration(
                                labelText: "Value",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => removeField(index),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      );
                    },
                  ),

                  /// Add new Field Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: addNewField,
                      child: const Text("+ Add Field"),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// ADD BUTTON
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final dataMap = buildDataMap();

                      final request = ObjectPostRequestModel(
                        name: name,
                        data: dataMap.isEmpty ? null : dataMap,
                      );

                      context.read<AddObjectCubit>().postRequest(request);
                    },
                    child: const Text("Add Object"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
