import 'package:dio/dio.dart';

import '../../data/models/api_error_model.dart';

class ApiErrorHandler {
  /// Map server errors based on status code
  static APIErrorModel handleServerError({
    required int statusCode,
    String? serverMessage,
  }) {
    final message = serverMessage ?? _getDefaultErrorMessage(statusCode);
    return APIErrorModel(message: message);
  }

  /// Handle Dio-specific errors
  static APIErrorModel handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return APIErrorModel(
            message: "Connection timed out. Please try again.");
      case DioExceptionType.receiveTimeout:
        return APIErrorModel(
            message:
                "Server took too long to respond. Please try again later.");
      case DioExceptionType.connectionError:
        return APIErrorModel(
            message: "No network connection. Please check your internet.");
      default:
        return APIErrorModel(message: "An unexpected network error occurred.");
    }
  }

  /// Handle unexpected errors
  static APIErrorModel handleUnexpectedError(Object error) {
    return APIErrorModel(message: 'Unexpected error: $error');
  }

  static String _getDefaultErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please try again.";
      case 401:
        return "Unauthorized. Please log in again.";
      case 403:
        return "Forbidden. You don't have permission to access this resource.";
      case 404:
        return "Resource not found. Please check the URL or try again later.";
      case 500:
        return "Server error. Please try again later.";
      case 503:
        return "Service unavailable. Please try again later.";
      default:
        return "An unexpected error occurred.";
    }
  }
}
