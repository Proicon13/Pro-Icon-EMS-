part of 'manage_custom_session_cubit.dart';

enum ManageCustomSessionStatus { intial, loading, success, error }

class ManageCustomSessionState extends Equatable {
  final ManageCustomSessionStatus? getProgramsStatus;
  final ManageCustomSessionStatus? addSessionStatus;
  final ManageCustomSessionStatus? editSessionStatus;
  final List<ProgramEntity> programs;
  final List<SessionProgram> sessionPrograms;
  final bool? isEditMode;
  final String? message;
  const ManageCustomSessionState(
      {this.getProgramsStatus = ManageCustomSessionStatus.loading,
      this.addSessionStatus = ManageCustomSessionStatus.intial,
      this.editSessionStatus = ManageCustomSessionStatus.intial,
      this.isEditMode = false,
      this.programs = const [],
      this.sessionPrograms = const [],
      this.message = ""});

  ManageCustomSessionState copyWith({
    ManageCustomSessionStatus? getProgramsStatus,
    ManageCustomSessionStatus? addSessionStatus,
    ManageCustomSessionStatus? editSessionStatus,
    bool? isEditMode,
    List<ProgramEntity>? programs,
    List<SessionProgram>? sessionPrograms,
    String? message,
  }) =>
      ManageCustomSessionState(
          getProgramsStatus: getProgramsStatus ?? this.getProgramsStatus,
          addSessionStatus: addSessionStatus ?? this.addSessionStatus,
          editSessionStatus: editSessionStatus ?? this.editSessionStatus,
          isEditMode: isEditMode ?? this.isEditMode,
          programs: programs ?? this.programs,
          sessionPrograms: sessionPrograms ?? this.sessionPrograms,
          message: message ?? this.message);

  @override
  List<Object> get props => [
        addSessionStatus!,
        editSessionStatus!,
        programs,
        isEditMode!,
        message!,
        getProgramsStatus!,
        sessionPrograms
      ];
}
