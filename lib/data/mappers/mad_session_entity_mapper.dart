import 'package:pro_icon/Core/entities/mad_session_entity.dart';
import 'package:pro_icon/data/models/mad_session_model.dart';

class MadSessionEntityMapper {
  static MadSessionEntity toEntity(MadSessionModel model) {
    return MadSessionEntity(
      id: model.id,
      captainName: model.session?.createdBy?.fullname ?? "Not defined",
      date: model.session?.createdAt ?? DateTime.now(),
    );
  }
}
