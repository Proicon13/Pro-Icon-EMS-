import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/api_response.dart';

import '../../data/models/api_error_model.dart';
import '../constants/app_constants.dart';
import '../dependencies.dart';
import '../errors/status_code.dart';
import 'api_error_handler.dart';
import 'interceptor.dart';

class DioConsumer implements BaseApiProvider {
  final Dio dio;

  DioConsumer({required this.dio}) {
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.options
      ..baseUrl = AppConstants.baseUrl
      ..followRedirects = false
      ..validateStatus = ((status) {
        return status! < StatusCode.internalServerError;
      });

    dio.interceptors.add(getIt<AppInterceptor>());

    if (kDebugMode) {
      dio.interceptors.add(getIt<LogInterceptor>());
    }
  }

  @override
  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? options,
  }) {
    return _handleRequest<T>(
      () => dio.get(endpoint,
          queryParameters: queryParameters, options: options as Options?),
      (data) => data as T,
    );
  }

  @override
  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    Object? options,
  }) {
    return _handleRequest<T>(
      () => dio.post(endpoint, data: data, options: options as Options?),
      (data) => data as T,
    );
  }

  @override
  Future<ApiResponse<T>> put<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    Object? options,
  }) {
    return _handleRequest<T>(
      () => dio.put(endpoint, data: data, options: options as Options?),
      (data) => data as T,
    );
  }

  @override
  Future<ApiResponse<T>> putMultipart<T>(
      {required String endpoint, FormData? data, Object? options}) {
    return _handleRequest<T>(
      () => dio.put(endpoint, data: data, options: options as Options?),
      (data) => data as T,
    );
  }

  @override
  Future<ApiResponse<T>> delete<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? options,
  }) {
    return _handleRequest<T>(
      () => dio.delete(endpoint,
          queryParameters: queryParameters, options: options as Options?),
      (data) => data as T,
    );
  }

  Future<ApiResponse<T>> _handleRequest<T>(
    Future<Response> Function() request,
    T Function(dynamic) fromJson,
  ) async {
    try {
      final response = await request();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success response
        return ApiResponse.success(fromJson(response.data));
      } else {
        // Handle known server errors
        return _handleServerError(response);
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      return ApiResponse.failure(ApiErrorHandler.handleDioError(e));
    } catch (e) {
      // Handle unexpected errors
      return ApiResponse.failure(ApiErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Handle server-side errors
  ApiResponse<T> _handleServerError<T>(Response response) {
    if (response.data is Map<String, dynamic>) {
      // Parse error model if present
      final errorModel = APIErrorModel.fromJson(response.data);
      return ApiResponse.failure(
        ApiErrorHandler.handleServerError(
          statusCode: response.statusCode!,
          serverMessage: errorModel.message,
        ),
      );
    } else {
      // Generic error response if no error model
      return ApiResponse.failure(
        ApiErrorHandler.handleServerError(
          statusCode: response.statusCode!,
        ),
      );
    }
  }

  @override
  Future<ApiResponse<T>> postMultipart<T>(
      {required String endpoint, FormData? data, Object? options}) {
    return _handleRequest<T>(
      () => dio.post(endpoint, data: data, options: options as Options?),
      (data) => data as T,
    );
  }
}
