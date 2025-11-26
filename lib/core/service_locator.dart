import 'package:flutter_objects_rest_apis/core/network/network_manager.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/datasources/remote_data_source.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/repos/add_object_repo_impl.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/repos/update_object_repo_impl.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/repos/get_all_objects_repo_impl.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/usecases/add_object_usecase.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/usecases/get_all_objects_usecase.dart';
import 'package:flutter_objects_rest_apis/feature/objects/domain/usecases/update_object_usecase.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

init() {
  locator.registerLazySingleton<NetworkManager>(() => NetworkManager());

  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(networkManager: locator<NetworkManager>()),
  );

  locator.registerLazySingleton<GetAllObjectsRepoImpl>(
    () => GetAllObjectsRepoImpl(dataSource: locator<RemoteDataSource>()),
  );

  locator.registerLazySingleton<GetAllObjectsUsecase>(
    () => GetAllObjectsUsecase(repo: locator<GetAllObjectsRepoImpl>()),
  );

  locator.registerLazySingleton<AddObjectRepoImpl>(
    () => AddObjectRepoImpl(dataSource: locator<RemoteDataSource>()),
  );

  locator.registerLazySingleton<AddObjectUsecase>(
    () => AddObjectUsecase(addObject: locator<AddObjectRepoImpl>()),
  );

  locator.registerLazySingleton<UpdateObjectRepoImpl>(
    () => UpdateObjectRepoImpl(dataSource: locator<RemoteDataSource>()),
  );

  locator.registerLazySingleton<UpdateObjectUsecase>(
    () =>
        UpdateObjectUsecase(updateObjectRepo: locator<UpdateObjectRepoImpl>()),
  );
}
