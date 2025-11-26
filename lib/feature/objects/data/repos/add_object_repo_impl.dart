import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/exceptions.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/datasources/remote_data_source.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_post_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_post_response_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/repos/add_object_repo.dart';

class AddObjectRepoImpl extends AddObjectRepo {
  final RemoteDataSource dataSource;

  AddObjectRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, ObjectPostResponseModel>> addObject(
    ObjectPostRequestModel object,
  ) async {
    try {
      final response = await dataSource.addObject(object);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
