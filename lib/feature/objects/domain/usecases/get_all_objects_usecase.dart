import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/entities/object_entity.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/repos/get_all_objects_repo.dart';

class GetAllObjectsUsecase {
  final GetAllObjectsRepo repo;

  GetAllObjectsUsecase({required this.repo});

  Future<Either<Failure,List<ObjectEntity>>>call()
  {
    return repo.getAllObjects();
  }
}