import 'package:flutter_objects_rest_apis/core/network/api_end_points.dart';

class ObjectPostRequestModel {
  final String name;
  final Map<String,dynamic>? data;

  ObjectPostRequestModel({required this.name, this.data});

  Map<String,dynamic> tojson(){
    return {
      ApiKeys.name : name,
      ApiKeys.data : data
    };
  }
}