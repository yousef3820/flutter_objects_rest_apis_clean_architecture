import 'package:flutter_objects_rest_apis/core/network/api_end_points.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/entities/object_entity.dart';

class ObjectModel extends ObjectEntity {
  final String id;
  ObjectModel({required super.name, required this.id, super.data});

  factory ObjectModel.fromjson(Map<String, dynamic> json) {
    return ObjectModel(
      name: json[ApiKeys.name],
      id: json[ApiKeys.id],
      data: json[ApiKeys.data] != null
          ? Map<String, dynamic>.from(json[ApiKeys.data])
          : null,
    );
  }
}
