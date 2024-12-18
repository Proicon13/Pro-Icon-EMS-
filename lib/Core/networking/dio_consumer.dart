import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/api_response.dart';
import '../../data/models/api_error_model.dart';
import '../constants/app_constants.dart';
import '../dependencies.dart';

import '../errors/status_code.dart';
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
        // Return success response
        return ApiResponse.success(fromJson(response.data));
      } else {
        // Parse the error model and return failure response
        final errorModel = APIErrorModel.fromJson(response.data);
        return ApiResponse.failure(errorModel);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is Map<String, dynamic>) {
        // Parse error model and return failure response
        final errorModel = APIErrorModel.fromJson(e.response!.data);
        return ApiResponse.failure(errorModel);
      } else {
        // Handle connection error
        final connectionErrorModel = APIErrorModel(
          message: 'Connection error: ${e.message ?? "Unknown error"}',
        );
        return ApiResponse.failure(connectionErrorModel);
      }
    } catch (e) {
      final unexpectedErrorModel = APIErrorModel(
        message: 'Unexpected error: $e',
      );
      return ApiResponse.failure(unexpectedErrorModel);
    }
  }
}
