import '../../Core/errors/exceptions.dart';

class ApiResponse<T> {
  final T? data;
  final AppException? error;

  ApiResponse.success(this.data) : error = null;
  ApiResponse.failure(this.error) : data = null;

  bool get isSuccess => error == null;
}
