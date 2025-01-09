import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/image_picker.dart';
import 'package:pro_icon/data/services/profile_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;
  ProfileCubit({required this.profileService}) : super(ProfileState());

  void onPickImage() async {
    final image = await ImagePickerHelper().pickImage();
    if (image != null) {
      emit(state.copyWith(selectedImagePath: image.path));
    }
  }

  void setStatus(ProfileStatus status) => emit(state.copyWith(status: status));
  void updateProfile({required Map<String, dynamic> body}) async {
    emit(state.copyWith(status: ProfileStatus.submitting));
    final result = await profileService.updateProfile(body: body);
    result.fold(
        (failure) => emit(state.copyWith(
              status: ProfileStatus.error,
              message: failure.message,
            )), (updatedUser) {
      // update user state with updated data
      getIt<UserStateCubit>().setUser(updatedUser);
      emit(state.copyWith(
        status: ProfileStatus.success,
        message: "updateProfile.successMessage".tr(),
      ));
    });
  }
}
