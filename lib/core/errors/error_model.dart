import 'package:dio/dio.dart';
import 'package:flutter_objects_rest_apis/core/errors/exceptions.dart';

class ErrorModel {
  final String status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromjson(Map<String, dynamic> json) {
    return ErrorModel(
      status: json["status"].toString(),
      errorMessage: json["errormessage"] ?? "unknown error",
    );
  }
}

String getMessageFromStatusCode(int? code) {
  switch (code) {
    case 400:
      return 'Bad Request — The server could not understand the request.';
    case 401:
      return 'Unauthorized — Authentication failed or missing.';
    case 403:
      return 'Forbidden — You don’t have permission to access this resource.';
    case 404:
      return 'Not Found — The requested resource doesn’t exist.';
    case 405:
      return 'Method Not Allowed — The request method is not supported.';
    case 408:
      return 'Request Timeout — The server took too long to respond.';
    case 409:
      return 'Conflict — The request could not be completed due to a conflict.';
    case 415:
      return 'Unsupported Media Type — The request format is not supported.';
    case 429:
      return 'Too Many Requests — You have sent too many requests.';
    case 500:
      return 'Internal Server Error — Something went wrong on the server.';
    case 502:
      return 'Bad Gateway — Invalid response from upstream server.';
    case 503:
      return 'Service Unavailable — The server is temporarily overloaded.';
    case 504:
      return 'Gateway Timeout — The server took too long to respond.';
    default:
      return 'Unexpected Error — Please try again later.';
  }
}

void handleExceptions(DioException e) {
  final response = e.response;

  if (response == null) {
    throw ServerException(
      errorModel: ErrorModel(
        status: 'No Response',
        errorMessage:
            e.message ?? 'No internet connection or server not reachable.',
      ),
    );
  }

  final data = response.data;
  final statusCode = response.statusCode;
  ErrorModel errorModel;

  if (data is Map<String, dynamic> && data.isNotEmpty) {
    errorModel = ErrorModel.fromjson(data);
  } else {
    errorModel = ErrorModel(
      status: statusCode?.toString() ?? 'Unknown',
      errorMessage: getMessageFromStatusCode(statusCode),
    );
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          status: 'Timeout',
          errorMessage: 'Connection timed out. Please check your internet.',
        ),
      );

    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          status: 'Timeout',
          errorMessage: 'Server took too long to respond.',
        ),
      );

    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      throw ServerException(
        errorModel: ErrorModel(
          status: 'Connection Error',
          errorMessage: 'Please check your network connection.',
        ),
      );

    case DioExceptionType.cancel:
      throw ServerException(
        errorModel: ErrorModel(
          status: 'Cancelled',
          errorMessage: 'Request was cancelled by the user.',
        ),
      );

    case DioExceptionType.badCertificate:
      throw ServerException(
        errorModel: ErrorModel(
          status: 'Bad Certificate',
          errorMessage: 'SSL certificate validation failed.',
        ),
      );

    case DioExceptionType.badResponse:
      throw ServerException(
        errorModel: ErrorModel(
          status: statusCode?.toString() ?? 'Unknown',
          errorMessage: errorModel.errorMessage.isNotEmpty
              ? errorModel.errorMessage
              : getMessageFromStatusCode(statusCode),
        ),
      );
  }
}
