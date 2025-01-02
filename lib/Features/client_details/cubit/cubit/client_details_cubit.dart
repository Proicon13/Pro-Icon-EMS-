import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/region_cubit/region_cubit.dart';
import 'package:pro_icon/data/services/clients_service.dart';

import '../../../../Core/entities/client_entity.dart';

part 'client_details_state.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  final ClientsService clientsService;
  ClientDetailsCubit({required this.clientsService})
      : super(const ClientDetailsState());

  void setClient(ClientEntity client) {
    emit(state.copyWith(status: RequestStatus.loading));
    emit(state.copyWith(client: client, status: RequestStatus.success));
  }

  void onSectionChanged(ClientSections section) {
    emit(state.copyWith(currentSection: section));
  }

  void updateClient(Map<String, dynamic> clientBody, int clientId) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await clientsService.updateClientDetails(
        body: clientBody, id: clientId);

    response.fold((failure) {
      emit(state.copyWith(
          status: RequestStatus.error, message: failure.message));
    }, (client) {
      emit(state.copyWith(
          status: RequestStatus.success,
          client: client,
          message: "client.updateSuccessMessage".tr()));
    });
  }

  void getClientDetails(int clientId) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await clientsService.getClientById(id: clientId);

    response.fold((failure) {
      emit(state.copyWith(
          status: RequestStatus.error, message: failure.message));
    }, (client) {
      emit(state.copyWith(
          status: RequestStatus.success, client: client, message: ""));
    });
  }
}
