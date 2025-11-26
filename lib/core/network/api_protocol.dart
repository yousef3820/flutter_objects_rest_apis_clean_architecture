import 'package:dio/dio.dart';
import 'package:flutter_objects_rest_apis/core/network/api_end_points.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/objects_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_post_response_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_update_response_model.dart';

enum RequsestType { getAllObjects , addObject , updateObject  }

abstract class RequestProtocol {
  String get path;
  String get baseUrl => ApiEndPoints.baseUrl;
  String get method;
  Map<String, dynamic>? get queryParameters;
  Object? get data;
  Map<String, dynamic> get headers => {"Content-type": "application/json"};
  T parseResponse<T>(Response response);
}

class ApiRequset<T> extends RequestProtocol {
  final RequsestType requsestType;
  final Object? body;
  final Map<String, dynamic>? extraParams;
  final int ?id;
  ApiRequset({required this.requsestType, this.body, this.extraParams , this.id});
  @override
  // TODO: implement data
  Object? get data => body;

  @override
  // TODO: implement method
  String get method => switch (requsestType) {
    // TODO: Handle this case.
    RequsestType.getAllObjects => "GET",
    RequsestType.addObject => "POST",
    
    // TODO: Handle this case.
    RequsestType.updateObject => "PATCH",
  };

  @override
  T parseResponse<T>(Response response) {
    final data = response.data;
    switch (requsestType) {
      case RequsestType.getAllObjects:
        final list = (data as List)
            .map((item) => ObjectModel.fromjson(item))
            .toList();
        return list as T;
      case RequsestType.addObject:
        return ObjectPostResponseModel.fromjson(data) as T;
      case RequsestType.updateObject:
        // TODO: Handle this case.
        return ObjectUpdateResponseModel.fromjson(data) as T;
    }
  }

  @override
  // TODO: implement path
  String get path => switch (requsestType) {
    // TODO: Handle this case.
    RequsestType.getAllObjects => "${ApiEndPoints.objects}",
    // TODO: Handle this case.
    RequsestType.addObject => "${ApiEndPoints.objects}",
    // TODO: Handle this case.
    RequsestType.updateObject => "${ApiEndPoints.objects}/$id",
  };

  @override
  // TODO: implement queryParameters
  Map<String, dynamic>? get queryParameters => extraParams;
}
