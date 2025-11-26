import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_update_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/presentation/cubits/cubit/update_object/cubit/update_object_cubit.dart';

class UpdateObjectScreen extends StatefulWidget {
  const UpdateObjectScreen({super.key});

  @override
  State<UpdateObjectScreen> createState() => _UpdateObjectScreenState();
}

class _UpdateObjectScreenState extends State<UpdateObjectScreen> {
  final TextEditingController nameController = TextEditingController();
  late TextEditingController idController = TextEditingController();

  /// Dynamic fields
  List<MapEntry<TextEditingController, TextEditingController>> fields = [];

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
      if (key.isNotEmpty) map[key] = value;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateObjectCubit(),
      child: BlocConsumer<UpdateObjectCubit, UpdateObjectState>(
        listener: (context, state) {
          if (state is UpdateObjectLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is UpdateObjectSuccess) {
            Navigator.pop(context); // close loading
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Object Updated Successfully!")),
            );
            print("/////////////////////////////////////////////////");
            print(state.updatedObject.id);
            print(state.updatedObject.name);
            print(state.updatedObject.data);
            print("/////////////////////////////////////////////////");
          }

          if (state is UpdateObjectFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Update Object")),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// ID (Read only)
                  TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(
                      labelText: "Object ID",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// NAME
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Object Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Dynamic Fields
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

                  /// Add New Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: addNewField,
                      child: const Text("+ Add Field"),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// SUBMIT BUTTON
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final data = buildDataMap();

                      final request = ObjectUpdateRequestModel(
                        name: name,
                        data: data.isEmpty ? null : data,
                      );

                      context.read<UpdateObjectCubit>().patchRequest(
                        request,
                        int.parse(idController.text.trim()),
                      );
                      print(int.parse(idController.text.trim()));
                    },
                    child: const Text("Update Object"),
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
