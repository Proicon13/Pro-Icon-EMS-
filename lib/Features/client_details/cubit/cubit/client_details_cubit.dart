import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/utils/image_picker.dart';
import 'package:pro_icon/data/services/clients_service.dart';

import '../../../../Core/entities/client_entity.dart';
import '../../personal_info_view.dart';

part 'client_details_state.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  final ClientsService clientsService;
  ClientDetailsCubit({required this.clientsService})
      : super(const ClientDetailsState());

  void setClient(ClientEntity client) {
    emit(state.copyWith(status: ClientDetailsStatus.loading));
    emit(state.copyWith(client: client, status: ClientDetailsStatus.success));
  }

  void onSectionChanged(ClientSections section) {
    emit(state.copyWith(currentSection: section));
  }

  void updateClient(Map<String, dynamic> clientBody, int clientId) async {
    emit(state.copyWith(clientUpdateStatus: ClientDetailsStatus.loading));
    final response = await clientsService.updateClientDetails(
        body: clientBody, id: clientId);

    response.fold((failure) {
      emit(state.copyWith(
          clientUpdateStatus: ClientDetailsStatus.error,
          message: failure.message));
    }, (client) {
      emit(state.copyWith(
          clientUpdateStatus: ClientDetailsStatus.success,
          client: client,
          message: "client.updateSuccessMessage".tr()));
    });
  }

  void onUpdateProfile(int clientId) async {
    final image = await _pickImage();
    if (image != null) {
      _updateProfileImage(clientId, image.path);
    }
  }

  Future<XFile?> _pickImage() async {
    XFile? image;
    try {
      image = await ImagePickerHelper().pickImage();
    } on ImagePickerFailure catch (e) {
      emit(state.copyWith(
        clientUpdateStatus: ClientDetailsStatus.error,
        message: e.message,
      ));
    }
    return image;
  }

  void _updateProfileImage(int clientId, String imagePath) async {
    emit(state.copyWith(clientUpdateStatus: ClientDetailsStatus.loading));
    final response = await clientsService.updateProfileImage(
        id: clientId, imageFile: imagePath);

    response.fold((failure) {
      emit(state.copyWith(
          clientUpdateStatus: ClientDetailsStatus.error,
          message: failure.message));
    }, (client) {
      emit(state.copyWith(
          clientUpdateStatus: ClientDetailsStatus.success,
          client: client,
          message: "client.updateSuccessMessage".tr()));
    });
  }

  void getClientDetails(int clientId) async {
    emit(state.copyWith(status: ClientDetailsStatus.loading));
    final response = await clientsService.getClientById(id: clientId);

    response.fold((failure) {
      emit(state.copyWith(
          status: ClientDetailsStatus.error, message: failure.message));
    }, (client) {
      emit(state.copyWith(
          status: ClientDetailsStatus.success, client: client, message: ""));
    });
  }
}
