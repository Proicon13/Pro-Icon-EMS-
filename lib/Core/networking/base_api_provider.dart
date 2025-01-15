import 'package:dio/dio.dart';

import '../../data/models/api_response.dart';

abstract class BaseApiProvider {
  Future<ApiResponse<T>> get<T>(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Object? options});

  Future<ApiResponse<T>> post<T>(
      {required String endpoint, Map<String, dynamic>? data, Object? options});

  Future<ApiResponse<T>> put<T>(
      {required String endpoint, Map<String, dynamic>? data, Object? options});

  Future<ApiResponse<T>> putMultipart<T>(
      {required String endpoint, FormData? data, Object? options});
  Future<ApiResponse<T>> postMultipart<T>(
      {required String endpoint, FormData? data, Object? options});

  Future<ApiResponse<T>> delete<T>(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Object? options});
}
