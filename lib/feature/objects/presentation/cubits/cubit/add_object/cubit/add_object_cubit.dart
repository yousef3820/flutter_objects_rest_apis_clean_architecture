import 'package:bloc/bloc.dart';
import 'package:flutter_objects_rest_apis/core/service_locator.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_post_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_post_response_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/usecases/add_object_usecase.dart';
import 'package:meta/meta.dart';

part 'add_object_state.dart';

class AddObjectCubit extends Cubit<AddObjectState> {
  final AddObjectUsecase addObject = locator<AddObjectUsecase>();
  AddObjectCubit() : super(AddObjectInitial());

  postRequest(ObjectPostRequestModel object) async {
    emit(AddObjectLoading());
    final response = await addObject.call(object);
    response.fold(
      (failure) => emit(AddObjectFailure(errorMessage: failure.errorMessage)),
      (result) => emit(AddObjectSuccess(object: result)),
    );
  }
}
