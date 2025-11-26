import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/exceptions.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/datasources/remote_data_source.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_update_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_update_response_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/repos/update_object_repo.dart';

class UpdateObjectRepoImpl extends UpdateObjectRepo {
  final RemoteDataSource dataSource;

  UpdateObjectRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, ObjectUpdateResponseModel>> updateObject(
    ObjectUpdateRequestModel object,
    int id,
  ) async {
    try {
      final result = await dataSource.updateObject(object, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
