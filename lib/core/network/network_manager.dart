import 'package:dio/dio.dart';
import 'package:flutter_objects_rest_apis/core/errors/error_model.dart';
import 'package:flutter_objects_rest_apis/core/network/api_protocol.dart';

class NetworkManager {
  final Dio _dio = Dio();
  Future<T> perform<T>(ApiRequset<T> apiRequset) async {
    final url = "${apiRequset.baseUrl}${apiRequset.path}";
    try {
      final response = await _dio.request(
        url,
        data: apiRequset.data,
        queryParameters: apiRequset.queryParameters,
        options: Options(
          headers: apiRequset.headers,
          method: apiRequset.method,
          responseType: ResponseType.json,
        ),
      );
      return apiRequset.parseResponse(response);
    } on DioException catch (e) {
      handleExceptions(e);
      rethrow;
    }
  }
}
