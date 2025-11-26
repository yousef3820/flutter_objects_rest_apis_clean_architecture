import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_update_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_update_response_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/repos/update_object_repo.dart';

class UpdateObjectUsecase {
  final UpdateObjectRepo updateObjectRepo;

  UpdateObjectUsecase({required this.updateObjectRepo});

  Future<Either<Failure, ObjectUpdateResponseModel>> call(
    ObjectUpdateRequestModel object,
    int id
  ) {
    return updateObjectRepo.updateObject(object , id);
  }
}
