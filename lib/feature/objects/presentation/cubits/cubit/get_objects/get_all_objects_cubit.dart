import 'package:bloc/bloc.dart';
import 'package:flutter_objects_rest_apis/core/service_locator.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/objects_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/usecases/get_all_objects_usecase.dart';
import 'package:meta/meta.dart';

part 'get_all_objects_state.dart';

class GetAllObjectsCubit extends Cubit<GetAllObjectsState> {
  final GetAllObjectsUsecase getallObjects = locator<GetAllObjectsUsecase>();
  GetAllObjectsCubit() : super(GetAllObjectsInitial());

  getRequest() async {
    emit(GetAllObjectsLoading());
    final result = await getallObjects.call();
    result.fold(
      (failure) =>
          emit(GetAllObjectsFailure(errorMesssage: failure.errorMessage)),
      (success) => emit(GetAllObjectsSuccess(objects: success)),
    );
  }
}
