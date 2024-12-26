import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'phone_register_state.dart';

class PhoneRegistrationCubit extends Cubit<PhoneRegistrationState> {
  PhoneRegistrationCubit() : super(const PhoneRegistrationState());

  void setCountryCode(String phoneCode) =>
      emit(state.copyWith(phoneCode: phoneCode));
  void setErrorMessage(String errorMessage) =>
      emit(state.copyWith(errorMessage: errorMessage));
}
