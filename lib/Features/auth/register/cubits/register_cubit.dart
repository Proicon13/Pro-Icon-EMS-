import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void setCountryCode(String phoneCode) =>
      emit(state.copyWith(phoneCode: phoneCode));
  void setErrorMessage(String errorMessage) =>
      emit(state.copyWith(errorMessage: errorMessage));
}
