import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pro_icon/data/services/user_service.dart';

class AppInterceptor implements Interceptor {
  final UserService _userService;

  AppInterceptor({required UserService userService})
      : _userService = userService;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _userService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
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
