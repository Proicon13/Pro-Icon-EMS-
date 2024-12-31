import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pro_icon/data/services/auth_token_service.dart';

import 'api_constants.dart';

class AppInterceptor implements Interceptor {
  final AuthTokenService _authTokenService;

  AppInterceptor({required AuthTokenService authTokenService})
      : _authTokenService = authTokenService;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path != ApiConstants.currentUserEndpoint) {
      final token = await _authTokenService.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    log('REQUEST[${options.method}] => PATH: ${options.path} AND Query Paramters are : ${options.queryParameters} And headers are ${options.headers} ');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} => RESPONSE IS : ${response.data}');
    return handler.next(response);
  }
}
