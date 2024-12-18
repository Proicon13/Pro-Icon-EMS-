import 'api_error_model.dart';

class ApiResponse<T> {
  final T? data;
  final APIErrorModel? error;

  ApiResponse.success(this.data) : error = null;
  ApiResponse.failure(this.error) : data = null;

  bool get isSuccess => error == null;
}
