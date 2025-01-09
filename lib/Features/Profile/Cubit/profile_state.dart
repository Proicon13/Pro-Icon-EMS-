part of 'profile_cubit.dart';

enum ProfileStatus { initial, submitting, success, error }

extension ProfileStatusExtension on ProfileState {
  bool get isLoading => this.status == ProfileStatus.submitting;

  /// Check if the profile state is successful
  bool get isSuccess => this.status == ProfileStatus.success;

  /// Check if the profile state has an error
  bool get isError => this.status == ProfileStatus.error;

  /// Check if the profile state is in the initial state
  bool get isInitial => this.status == ProfileStatus.initial;
}

class ProfileState extends Equatable {
  final ProfileStatus? status;
  final String? message;
  final String? selectedImagePath;

  ProfileState(
      {this.message = "",
      this.selectedImagePath = "",
      this.status = ProfileStatus.initial});

  ProfileState copyWith({
    ProfileStatus? status,
    String? message,
    String? selectedImagePath,
  }) {
    return ProfileState(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
    );
  }

  @override
  List<Object?> get props => [status, message, selectedImagePath];
}
