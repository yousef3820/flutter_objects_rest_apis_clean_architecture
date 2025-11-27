import 'package:dartz/dartz.dart';
import 'package:flutter_objects_rest_apis/core/errors/failure.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/objects_model.dart';

abstract class GetAllObjectsRepo {
  Future<Either<Failure,List<ObjectModel>>>getAllObjects();
}