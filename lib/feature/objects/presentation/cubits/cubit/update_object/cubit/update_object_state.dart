part of 'update_object_cubit.dart';

@immutable
sealed class UpdateObjectState {}

final class UpdateObjectInitial extends UpdateObjectState {}

final class UpdateObjectLoading extends UpdateObjectState {}

final class UpdateObjectSuccess extends UpdateObjectState {
  final ObjectUpdateResponseModel updatedObject;

  UpdateObjectSuccess({required this.updatedObject});
}

final class UpdateObjectFailure extends UpdateObjectState {
  final String errorMessage;

  UpdateObjectFailure({required this.errorMessage});
}
