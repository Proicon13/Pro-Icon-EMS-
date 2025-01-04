part of 'client_details_cubit.dart';

enum ClientDetailsStatus { loading, success, error }

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
  ClientSections.medicalInfo: const SizedBox(),
  ClientSections.historyInfo: const SizedBox(),
  ClientSections.startegyInfo: const SizedBox(),
  ClientSections.scoreInfo: const SizedBox(),
};

class ClientDetailsState extends Equatable {
  final ClientDetailsStatus status;
  final ClientEntity? client;
  final String? message;
  final ClientSections currentSection;

  const ClientDetailsState(
      {this.status = ClientDetailsStatus.loading,
      this.client = const ClientEntity(),
      this.message = "",
      this.currentSection = ClientSections.personalInfo});

  ClientDetailsState copyWith({
    ClientDetailsStatus? status,
    ClientEntity? client,
    String? message,
    ClientSections? currentSection,
  }) {
    return ClientDetailsState(
      status: status ?? this.status,
      client: client ?? this.client,
      message: message ?? this.message,
      currentSection: currentSection ?? this.currentSection,
    );
  }

  @override
  List<Object> get props => [status, client!, message!, currentSection];
}
