import 'package:flutter_objects_rest_apis/core/network/api_end_points.dart';
import 'package:flutter_objects_rest_apis/core/network/api_protocol.dart';
import 'package:flutter_objects_rest_apis/core/network/network_manager.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/objects_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_post_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/request_models/object_update_request_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_post_response_model.dart';
import 'package:flutter_objects_rest_apis/feature/objects/data/models/response_models/object_update_response_model.dart';

class RemoteDataSource {
  final NetworkManager networkManager;

  RemoteDataSource({required this.networkManager});

  Future<List<ObjectModel>> getAllObjects() async {
    final objects = await networkManager.perform<List<ObjectModel>>(
      ApiRequset<List<ObjectModel>>(requsestType: RequsestType.getAllObjects),
    );
    return objects;
  }

  Future<ObjectPostResponseModel> addObject(
    ObjectPostRequestModel objectRequest,
  ) async {
    return await networkManager.perform<ObjectPostResponseModel>(
      ApiRequset(
        requsestType: RequsestType.addObject,
        body: objectRequest.tojson(),
      ),
    );
  }

  Future<ObjectUpdateResponseModel> updateObject(
    ObjectUpdateRequestModel object,
    int id,
  ) async {
    print("🔧 UPDATE OBJECT REQUEST:");
    print("ID: $id");
    print("Full URL: ${ApiEndPoints.baseUrl}${ApiEndPoints.objects}/$id");
    print("Method: PATCH");

    final requestBody = object.tojson();
    print("Request Body: $requestBody");

    try {
      final response = await networkManager.perform<ObjectUpdateResponseModel>(
        ApiRequset<ObjectUpdateResponseModel>(
          requsestType: RequsestType.updateObject,
          body: requestBody,
          id: id,
        ),
      );

      print("✅ UPDATE SUCCESS: $response");
      return response;
    } catch (e) {
      print("❌ UPDATE ERROR: $e");
      rethrow;
    }
  }
}
