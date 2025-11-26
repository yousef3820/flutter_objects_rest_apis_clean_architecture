import 'package:flutter_objects_rest_apis/core/network/api_end_points.dart';

class ObjectUpdateRequestModel {
  final String? name;
  final Map<String, dynamic>? data;

  ObjectUpdateRequestModel({this.name, this.data});

  Map<String, dynamic> tojson() {
    final map = <String, dynamic>{};
    if (name != null && name!.isNotEmpty) map[ApiKeys.name] = name;
    if (data != null && data!.isNotEmpty) map[ApiKeys.data] = data;
    return map;
  }
}
