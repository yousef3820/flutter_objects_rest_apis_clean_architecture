import 'package:flutter/material.dart';
import 'package:flutter_objects_rest_apis/core/service_locator.dart';
import 'package:flutter_objects_rest_apis/feature/objects/presentation/screens/main_screen.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainObjectsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
