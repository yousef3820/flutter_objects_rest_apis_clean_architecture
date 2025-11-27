part of 'get_all_objects_cubit.dart';

@immutable
sealed class GetAllObjectsState {}

final class GetAllObjectsInitial extends GetAllObjectsState {}
final class GetAllObjectsLoading extends GetAllObjectsState {}
final class GetAllObjectsSuccess extends GetAllObjectsState {
  final List<ObjectModel> objects;

  GetAllObjectsSuccess({required this.objects});
}
final class GetAllObjectsFailure extends GetAllObjectsState {
  final String errorMesssage;

  GetAllObjectsFailure({required this.errorMesssage});

}