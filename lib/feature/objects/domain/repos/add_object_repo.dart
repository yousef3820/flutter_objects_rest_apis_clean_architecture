import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_post_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_post_response_model.dart';

abstract class AddObjectRepo {
  Future<Either<Failure,ObjectPostResponseModel>>addObject(ObjectPostRequestModel object);
}