import 'package:pro_icon/Core/errors/exceptions.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/create_session_request.dart';
import 'package:pro_icon/data/models/session_details_model.dart';

import '../../Core/networking/api_constants.dart';

class SessionManagmentService {
  final BaseApiProvider _baseApiProvider;

  SessionManagmentService({required BaseApiProvider baseApiProvider})
      : _baseApiProvider = baseApiProvider;

  Future<SessionDetailsModel> createSession(
      {required CreateSessionRequest request}) async {
    final response = await _baseApiProvider.post<Map<String, dynamic>>(
        endpoint: ApiConstants.createSessionEndpoint, data: request.toJson());
    if (response.isSuccess) {
      return SessionDetailsModel.fromJson(response.data!);
    } else {
      throw ServerException(response.error!.message);
    }
  }
}
