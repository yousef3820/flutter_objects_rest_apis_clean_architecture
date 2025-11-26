import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/entities/object_entity.dart';

abstract class GetAllObjectsRepo {
  Future<Either<Failure,List<ObjectEntity>>>getAllObjects();
}