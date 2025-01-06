import 'package:dartz/dartz.dart';

import 'package:pro_icon/Core/errors/exceptions.dart';
import 'package:pro_icon/Core/errors/failures.dart';

import 'package:pro_icon/data/services/auth_service.dart';
import 'package:pro_icon/data/services/reset_password_service.dart';

import '../models/app_user_model.dart';
import '../models/login_request_.dart';
import '../models/reset_password_request.dart';
import '../models/sign_up_request.dart';
import '../services/user_service.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> login({required LoginRequest loginRequest});
  Future<Either<Failure, AppUserModel>> registerUser(
      {required SignupRequest signUpRequest});

  Future<Either<Failure, String>> forgetPassword({required String email});

  Future<Either<Failure, String>> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest});

  Future<Either<Failure, void>> logout();
}

class AuthRepoImpl implements AuthRepo {
  final AuthService _authService;
  final ResetPasswordService _resetPasswordService;

  final UserService _userService;

  AuthRepoImpl(
      {required AuthService authService,
      required UserService userService,
      required ResetPasswordService resetPasswordService})
      : _authService = authService,
        _userService = userService,
        _resetPasswordService = resetPasswordService;
  @override
  Future<Either<Failure, String>> forgetPassword(
      {required String email}) async {
    final response = await _resetPasswordService.forgotPassword(email: email);
    if (response.isSuccess) {
      return Right(response.data!);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required LoginRequest loginRequest,
  }) async {
    // Send login request
    final loginResponse = await _authService.login(loginRequest: loginRequest);
    if (loginResponse.isSuccess) {
      late String token;
      // success response
      token = loginResponse.data!.accessToken;
      // get user by token
      final userResponse = await _userService.getUserByToken(token: token);

      if (userResponse.isSuccess) {
        try {
          // Save token to secured local storage
          await _userService.saveToken(token);

          return const Right(null);
        } on CacheException catch (e) {
          // on local storage error
          return Left(CacheFailure(message: e.message));
        }
      } else {
        // USER response failure
        return Left(ServerFailure(message: userResponse.error!.message));
      }
    } else {
      // LOGIN response failure
      return Left(ServerFailure(message: loginResponse.error!.message));
    }
  }

  @override
  Future<Either<Failure, AppUserModel>> registerUser(
      {required SignupRequest signUpRequest}) async {
    // send register user request
    final response = await _authService.register(signUpRequest: signUpRequest);
    if (response.isSuccess) {
      return Right(response.data!);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest}) async {
    final response = await _resetPasswordService.resetPassword(
        resetPasswordRequest: resetPasswordRequest);
    if (response.isSuccess) {
      return Right(response.data!);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _authService.logout();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
