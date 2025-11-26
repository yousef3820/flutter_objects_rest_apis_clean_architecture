import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objects_rest_apis/feature/objects/presentation/cubits/cubit/get_objects/get_all_objects_cubit.dart';

class GetAllObjectsScreen extends StatelessWidget {
  const GetAllObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetAllObjectsCubit()..getRequest(),
      child: Scaffold(
        appBar: AppBar(title: const Text("All Objects")),
        body: BlocBuilder<GetAllObjectsCubit, GetAllObjectsState>(
          builder: (context, state) {
            if (state is GetAllObjectsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetAllObjectsFailure) {
              return Center(
                child: Text(
                  "Error: ${state.errorMesssage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is GetAllObjectsSuccess) {
              final objects = state.objects;

              return ListView.builder(
                itemCount: objects.length,
                itemBuilder: (context, index) {
                  final obj = objects[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(obj.name),
                      subtitle: obj.data == null
                          ? const Text("No Data")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: obj.data!.entries.map((e) {
                                return Text("${e.key}: ${e.value}");
                              }).toList(),
                            ),
                    ),
                  );
                },
              );
            }

            return const Center(child: Text("Press button to load objects"));
          },
        ),
      ),
    );
  }
}
