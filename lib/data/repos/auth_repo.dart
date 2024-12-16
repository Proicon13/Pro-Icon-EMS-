import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/constants/app_constants.dart';
import 'package:pro_icon/Core/errors/exceptions.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/local_storage/local_storage_provider.dart';
import 'package:pro_icon/data/services/auth_service.dart';
import 'package:pro_icon/data/services/reset_password_service.dart';

import '../models/app_user_model.dart';
import '../models/login_request_.dart';
import '../models/reset_password_request.dart';
import '../models/sign_up_request.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> login({required LoginRequest loginRequest});
  Future<Either<Failure, AppUserModel>> registerUser(
      {required SignupRequest signUpRequest});

  Future<Either<Failure, String>> forgetPassword({required String email});

  Future<Either<Failure, String>> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest});
}

class AuthRepoImpl implements AuthRepo {
  final AuthService _authService;
  final ResetPasswordService _resetPasswordService;
  final BaseLocalService _localService;

  AuthRepoImpl(
      {required AuthService authService,
      required BaseLocalService localService,
      required ResetPasswordService resetPasswordService})
      : _authService = authService,
        _localService = localService,
        _resetPasswordService = resetPasswordService;
  @override
  Future<Either<Failure, String>> forgetPassword(
      {required String email}) async {
    try {
      // send email to reset password
      final response = await _resetPasswordService.forgotPassword(email: email);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required LoginRequest loginRequest,
  }) async {
    try {
      // Send login request
      final response = await _authService.login(loginRequest: loginRequest);
      final token = response.accessToken;

      // Save token to secured local storage
      await _localService.put(AppConstants.tokenLocalKey, token);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AppUserModel>> registerUser(
      {required SignupRequest signUpRequest}) async {
    try {
      // send register user request
      final response =
          await _authService.register(signUpRequest: signUpRequest);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest}) async {
    try {
      // send reset password request
      final response = await _resetPasswordService.resetPassword(
          resetPasswordRequest: resetPasswordRequest);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
