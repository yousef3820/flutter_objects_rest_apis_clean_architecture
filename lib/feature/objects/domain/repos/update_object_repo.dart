import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_update_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_update_response_model.dart';

abstract class UpdateObjectRepo {
  Future<Either<Failure, ObjectUpdateResponseModel>> updateObject(
    ObjectUpdateRequestModel object,
    int id
  );
}
