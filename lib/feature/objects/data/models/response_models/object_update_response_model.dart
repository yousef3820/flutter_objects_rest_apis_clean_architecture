import 'package:flutter_objects_rest_apis/core/network/api_end_points.dart';

class ObjectUpdateResponseModel {
  final String id;
  final String name;
  final Map<String, dynamic> data;
  final String updatedAt;

  ObjectUpdateResponseModel({
    required this.id,
    required this.name,
    required this.data,
    required this.updatedAt,
  });

  factory ObjectUpdateResponseModel.fromjson(Map<String, dynamic> json) {
    return ObjectUpdateResponseModel(
      id: json[ApiKeys.id],
      name: json[ApiKeys.name],
      data: Map<String, dynamic>.from(json[ApiKeys.data]),
      updatedAt: json[ApiKeys.updatedAt],
    );
  }
}
