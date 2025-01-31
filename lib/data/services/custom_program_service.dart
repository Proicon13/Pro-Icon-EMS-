import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/mappers/program_entity_mapper.dart';
import 'package:pro_icon/data/models/add_custom_program_model.dart';
import 'package:pro_icon/data/models/category_model.dart';

import '../../Core/errors/failures.dart';
import '../../Core/networking/api_constants.dart';

class CustomProgramService {
  final BaseApiProvider _baseApiProvider;

  CustomProgramService({required BaseApiProvider baseApiProvider})
      : _baseApiProvider = baseApiProvider;

  Future<Either<Failure, ProgramEntity>> createCustomProgram(
      {required AddCustomProgramModel customProgramRequest}) async {
    final body = customProgramRequest.toJson();
    // prepare file path for submission
    if (body.containsKey("file") && (body["file"] as String).isNotEmpty) {
      body["file"] = await MultipartFile.fromFile(body["file"],
          filename: body["file"].split('/').last);
    }
    // prepare form data
    final formData = FormData.fromMap(body);
    final response = await _baseApiProvider.postMultipart<Map<String, dynamic>>(
        endpoint: ApiConstants.addCustomProgramEndpoint,
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }));
    if (response.isSuccess) {
      return Right(ProgramModelToEntityMapper.mapFromProgramModel(
          ProgramModel.fromJson(response.data!)));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, ProgramEntity>> updateCustomProgram(
      {required Map<String, dynamic> body, required int id}) async {
    if (body.containsKey("file")) {
      body["file"] = await MultipartFile.fromFile(body["file"],
          filename: body["file"].split('/').last);
    }
    final formData = FormData.fromMap(body);
    final response = await _baseApiProvider.putMultipart<Map<String, dynamic>>(
        endpoint: ApiConstants.updateCustomProgramEndpoint(id), data: formData);
    if (response.isSuccess) {
      return Right(ProgramModelToEntityMapper.mapFromProgramModel(
          ProgramModel.fromJson(response.data!)));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, String>> deleteCustomProgram({required int id}) async {
    final response = await _baseApiProvider.delete<Map<String, dynamic>>(
      endpoint: ApiConstants.deleteCustomProgramEndpoint(id),
    );
    if (response.isSuccess) {
      return Right(response.data!["message"]);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, AddProgramMuscleModel>> updateProgramMuscle(
      {required Map<String, dynamic> body, required int id}) async {
    final response = await _baseApiProvider.put<Map<String, dynamic>>(
        endpoint: ApiConstants.updateProgramMuscleEndpoint(id), data: body);
    if (response.isSuccess) {
      return Right(AddProgramMuscleModel.fromJson(response.data!));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, AddCycleModel>> updateProgramCycle(
      {required Map<String, dynamic> body, required int id}) async {
    final response = await _baseApiProvider.put<Map<String, dynamic>>(
        endpoint: ApiConstants.updateProgramCycle(id), data: body);
    if (response.isSuccess) {
      return Right(AddCycleModel.fromJson(response.data!));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
