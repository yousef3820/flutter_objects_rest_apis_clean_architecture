import 'package:flutter_objects_rest_apis/core/errors/error_model.dart';

class ServerException implements Exception{
  final ErrorModel errorModel;

  ServerException({required  this.errorModel});

}