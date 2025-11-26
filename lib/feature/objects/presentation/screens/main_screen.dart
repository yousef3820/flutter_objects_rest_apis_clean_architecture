import 'package:flutter/material.dart';
import 'package:flutter_objects_rest_apis/feature/objects/presentation/screens/add_object_screen.dart';
import 'package:flutter_objects_rest_apis/feature/objects/presentation/screens/update_object_screen.dart';
import 'get_all_objects_screen.dart';

class MainObjectsScreen extends StatelessWidget {
  const MainObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Objects Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GetAllObjectsScreen(),
                    ),
                  );
                },
                child: const Text("Get All Objects"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddObjectScreen()),
                  );
                },
                child: const Text("Add Object"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateObjectScreen(),
                    ),
                  );
                },
                child: const Text("Update Object"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Delete Object"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
