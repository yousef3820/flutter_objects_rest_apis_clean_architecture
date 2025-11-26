import 'package:bloc/bloc.dart';
import 'package:flutter_objects_rest_apis/core/service_locator.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_update_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_update_response_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/usecases/update_object_usecase.dart';
import 'package:meta/meta.dart';

part 'update_object_state.dart';

class UpdateObjectCubit extends Cubit<UpdateObjectState> {
  final UpdateObjectUsecase updatedObjectUseCase =
      locator<UpdateObjectUsecase>();
  UpdateObjectCubit() : super(UpdateObjectInitial());

  patchRequest(ObjectUpdateRequestModel updatedObject, int id) async {
    print("Cubit: Starting update for ID: $id");
    print("Cubit: Update data: ${updatedObject.tojson()}");

    emit(UpdateObjectLoading());
    final result = await updatedObjectUseCase.call(updatedObject, id);

    result.fold(
      (failure) {
        print("Cubit: Failure - ${failure.errorMessage}");
        emit(UpdateObjectFailure(errorMessage: failure.errorMessage));
      },
      (object) {
        print("Cubit: Success - ${object.id}");
        emit(UpdateObjectSuccess(updatedObject: object));
      },
    );
  }
}
