part of 'add_object_cubit.dart';

@immutable
sealed class AddObjectState {}

final class AddObjectInitial extends AddObjectState {}

final class AddObjectLoading extends AddObjectState {}

final class AddObjectSuccess extends AddObjectState {
  final ObjectPostResponseModel object;

  AddObjectSuccess({required this.object});
}

final class AddObjectFailure extends AddObjectState {
  final String errorMessage;

  AddObjectFailure({required this.errorMessage});
}
