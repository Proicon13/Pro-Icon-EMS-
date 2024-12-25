import '../../Core/entities/client_entity.dart';
import '../../data/models/client_model.dart';

class ClientEntityMapper {
  /// Maps a [ClientModel] to a [ClientEntity].
  static ClientEntity fromModel(ClientModel model) {
    return ClientEntity(
      id: model.id,
      email: model.email,
      fullname: model.fullname,
      image: model.image,
      city: model.city,
      status: model.status,
      postalCode: model.postalCode,
      address: model.address,
      phone: model.phone,
      role: model.role,
      gender: model.gender,
      startDate: model.startDate?.toIso8601String(),
      endDate: model.endDate?.toIso8601String(),
      superVisor: model.user != null
          ? Supervisor(
              id: model.user!.id,
              email: model.user!.email,
              fullname: model.user!.fullname,
            )
          : null,
    );
  }
}
