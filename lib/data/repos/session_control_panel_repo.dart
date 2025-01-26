// Abstract Repository for Session Management
import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/data/repos/mads_repo.dart';
import 'package:pro_icon/data/services/muscles_service.dart';

import '../../Core/entities/control_panel_mad.dart';
import '../models/mad.dart';

abstract class SessionManagementRepository {
  /// Fetch and process raw Mads into a list of ControlPanelMad objects
  Future<Either<Failure, List<ControlPanelMad>>> getControlPanelMads(
      {required List<Mad> rawMads});
}

class SessionManagementRepositoryImpl implements SessionManagementRepository {
  final MadRepository madRepository;
  final MusclesService musclesService;

  SessionManagementRepositoryImpl({
    required this.madRepository,
    required this.musclesService,
  });

  @override
  Future<Either<Failure, List<ControlPanelMad>>> getControlPanelMads(
      {required List<Mad> rawMads}) async {
    // Step 1: Return empty list if rawMads is empty
    if (rawMads.isEmpty) {
      return const Right([]);
    }

    // Step 2: Fetch muscles
    final musclesResult = await musclesService.getMuscles();

    if (musclesResult.isLeft()) {
      return const Left(ServerFailure(message: "Failed to fetch muscles."));
    }

    final musclesList = musclesResult.getOrElse(() => []);

    // Step 3: Check if muscles list is empty
    if (musclesList.isEmpty) {
      return const Right([]); // Return empty list if no muscles found
    }

    // Step 4: Fetch and process raw Mads
    final rawMadsResult = await madRepository.processMads(rawMads);

    return rawMadsResult.fold(
        (failure) => Left(CacheFailure(
            message: "Failed to process MADs: ${failure.message}")), (rawMads) {
      // Map processed Mads to ControlPanelMad objects with muscles
      final activeMads = rawMads.where((mad) => mad.isActive).toList();
      final controlPanelMads = activeMads.map((mad) {
        final muscleMap = {
          for (var muscle in musclesList)
            muscle.name!: 0 // Initialize muscle values to 0
        };

        return ControlPanelMad(
          madNo: mad.serialNo,
          musclesPercentage: muscleMap,
        );
      }).toList();

      return Right(controlPanelMads);
    });
  }
}
