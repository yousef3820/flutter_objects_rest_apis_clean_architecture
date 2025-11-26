import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/exceptions.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/datasources/remote_data_source.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/entities/object_entity.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/repos/get_all_objects_repo.dart';

class GetAllObjectsRepoImpl extends GetAllObjectsRepo {
  final RemoteDataSource dataSource;

  GetAllObjectsRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<ObjectEntity>>> getAllObjects() async {
    try {
      final result = await dataSource.getAllObjects();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
