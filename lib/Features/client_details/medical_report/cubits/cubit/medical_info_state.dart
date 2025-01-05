part of 'medical_info_cubit.dart';

class MedicalInfoState extends Equatable {
  final List<HealthCondition> allInjuries;
  final List<HealthCondition> allDiseases;
  final List<HealthCondition> clientInjuries;
  final List<HealthCondition> clientDiseases;
  final bool isInjurySectionOpen;
  final bool isDiseaseSectionOpen;
  final ClientDetailsStatus status;
  final String message;

  const MedicalInfoState({
    this.allInjuries = const [],
    this.allDiseases = const [],
    this.clientInjuries = const [],
    this.clientDiseases = const [],
    this.isInjurySectionOpen = true,
    this.isDiseaseSectionOpen = true,
    this.status = ClientDetailsStatus.loading,
    this.message = '',
  });

  MedicalInfoState copyWith({
    List<HealthCondition>? allInjuries,
    List<HealthCondition>? allDiseases,
    List<HealthCondition>? clientInjuries,
    List<HealthCondition>? clientDiseases,
    bool? isInjurySectionOpen,
    bool? isDiseaseSectionOpen,
    ClientDetailsStatus? status,
    String? message,
  }) {
    return MedicalInfoState(
      allInjuries: allInjuries ?? this.allInjuries,
      allDiseases: allDiseases ?? this.allDiseases,
      clientInjuries: clientInjuries ?? this.clientInjuries,
      clientDiseases: clientDiseases ?? this.clientDiseases,
      isInjurySectionOpen: isInjurySectionOpen ?? this.isInjurySectionOpen,
      isDiseaseSectionOpen: isDiseaseSectionOpen ?? this.isDiseaseSectionOpen,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        allInjuries,
        allDiseases,
        clientInjuries,
        clientDiseases,
        isInjurySectionOpen,
        isDiseaseSectionOpen,
        status,
        message,
      ];
}
