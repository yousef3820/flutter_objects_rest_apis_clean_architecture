import 'package:flutter_objects_rest_apis/core/network/api_end_points.dart';

class ObjectPostResponseModel {
  final String id;
  final String name;
  final Map<String, dynamic>? data;
  final String createdAt;

  ObjectPostResponseModel({
    required this.id,
    required this.name,
    this.data,
    required this.createdAt,
  });

  factory ObjectPostResponseModel.fromjson(Map<String, dynamic> json) {
    return ObjectPostResponseModel(
      id: json[ApiKeys.id],
      name: json[ApiKeys.name],
      data: json[ApiKeys.data] != null
          ? Map<String, dynamic>.from(json[ApiKeys.data])
          : null,
      createdAt: json[ApiKeys.createdAt],
    );
  }
}
