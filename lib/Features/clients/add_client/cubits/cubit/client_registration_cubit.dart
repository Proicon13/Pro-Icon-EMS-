import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/client_registration.dart';
import 'package:pro_icon/data/services/clients_service.dart';

part 'client_registration_state.dart';

class ClientRegistrationCubit extends Cubit<ClientRegistrationState> {
  final ClientsService clientsService;
  ClientRegistrationCubit({required this.clientsService})
      : super(const ClientRegistrationState());

  Future<void> registerClient(ClientRegistration clientData) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final result = await clientsService.addClient(body: clientData.toJson());
    result.fold(
      (failure) {
        emit(state.copyWith(
            requestStatus: RequestStatus.error, message: failure.message));
      },
      (success) {
        emit(state.copyWith(
            requestStatus: RequestStatus.success,
            message: "client.successMessage".tr()));
      },
    );
  }
}
