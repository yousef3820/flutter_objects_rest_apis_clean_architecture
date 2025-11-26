import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_post_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_post_response_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/repos/add_object_repo.dart';

class AddObjectUsecase {
  final AddObjectRepo addObject;

  AddObjectUsecase({required this.addObject});

  Future<Either<Failure, ObjectPostResponseModel>> call(
    ObjectPostRequestModel objcect,
  ) {
    return addObject.addObject(objcect);
  }
}
