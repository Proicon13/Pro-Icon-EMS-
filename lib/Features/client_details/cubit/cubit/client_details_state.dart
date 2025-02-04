part of 'client_details_cubit.dart';

enum ClientDetailsStatus { intial, loading, success, error }

enum ClientSections {
  personalInfo,
  medicalInfo,
  historyInfo,
  startegyInfo,
  scoreInfo
}

extension ClientSectionsX on ClientSections {
  String get name {
    switch (this) {
      case ClientSections.personalInfo:
        return "personalInfo.title".tr();
      case ClientSections.medicalInfo:
        return "medicalInfo.title".tr();
      case ClientSections.historyInfo:
        return "historyInfo.title".tr();
      case ClientSections.startegyInfo:
        return "strategyInfo.title".tr();
      case ClientSections.scoreInfo:
        return "scoreInfo.title".tr();
    }
  }
}

final clientSectionsToViewsMap = {
  ClientSections.personalInfo: const PersonalInfoView(),
  ClientSections.medicalInfo: const MedicalInfoView(),
  ClientSections.historyInfo: const HistoryInfoView(),
  ClientSections.startegyInfo: const StrategyView(),
  ClientSections.scoreInfo: const ScoreView(),
};

class ClientDetailsState extends Equatable {
  final ClientDetailsStatus? status;
  final ClientDetailsStatus? clientUpdateStatus;
  final ClientEntity? client;
  final String? message;
  final ClientSections currentSection;

  const ClientDetailsState(
      {this.status = ClientDetailsStatus.loading,
      this.clientUpdateStatus = ClientDetailsStatus.intial,
      this.client = const ClientEntity(),
      this.message = "",
      this.currentSection = ClientSections.personalInfo});

  ClientDetailsState copyWith({
    ClientDetailsStatus? status,
    ClientDetailsStatus? clientUpdateStatus,
    ClientEntity? client,
    String? message,
    ClientSections? currentSection,
  }) {
    return ClientDetailsState(
      clientUpdateStatus: clientUpdateStatus ?? this.clientUpdateStatus,
      status: status ?? this.status,
      client: client ?? this.client,
      message: message ?? this.message,
      currentSection: currentSection ?? this.currentSection,
    );
  }

  @override
  List<Object> get props =>
      [clientUpdateStatus!, status!, client!, message!, currentSection];
}
