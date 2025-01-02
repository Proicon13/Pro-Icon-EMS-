part of 'client_details_cubit.dart';

enum ClientDetailsStatus { loading, success, error }

enum ClientSections {
  personalInfo,
  medicalInfo,
  historyInfo,
  startegyInfo,
  scoreInfo
}

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
