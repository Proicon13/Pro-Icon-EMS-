// Abstract Repository for Session Management
import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/data/repos/mads_repo.dart';

import '../../Core/entities/control_panel_mad.dart';
import '../models/mad.dart';

abstract class SessionManagementRepository {
  /// Fetch and process raw Mads into a list of ControlPanelMad objects
  Future<Either<Failure, List<ControlPanelMad>>> getControlPanelMads(
      {required List<Mad> rawMads});
}

class SessionManagementRepositoryImpl implements SessionManagementRepository {
  final MadRepository madRepository;

  SessionManagementRepositoryImpl({required this.madRepository});

  @override
  Future<Either<Failure, List<ControlPanelMad>>> getControlPanelMads(
      {required List<Mad> rawMads}) async {
    // get raw Mads from user object
    // if empty return empty list
    if (rawMads.isEmpty) {
      return const Right([]);
    }
    final rawMadsResult = await madRepository.processMads(rawMads);

    return rawMadsResult.fold(
        (failure) => Left(
            CacheFailure(message: "Failed to process MADs:${failure.message}")),
        (rawMads) {
      // Map processed Mads to ControlPanelMad objects
      final controlPanelMads = rawMads.map((mad) {
        return ControlPanelMad.fromMad(mad);
      }).toList();

      return Right(controlPanelMads);
    });
  }
}
