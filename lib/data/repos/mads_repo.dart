import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/errors/failures.dart';

import '../models/mad.dart';
import '../services/mads_service.dart';

class MadRepository {
  final MadLocalService madLocalService;

  MadRepository({required this.madLocalService});

  /// Processes MADs by combining API and local storage data
  Future<Either<Failure, List<Mad>>> processMads(List<Mad> serverMads) async {
    try {
      // Step 1: Retrieve local MADs
      final localMads = await _getLocalMads();

      // Step 2: Create a map of local MADs for quick lookup by ID
      final localMadMap = {for (var mad in localMads) mad.id: mad};

      // Step 3: Merge server MADs with local MADs
      final processedMads = serverMads.map((serverMad) {
        final localMad = localMadMap[serverMad.id];
        return localMad != null
            ? serverMad.copyWith(isActive: localMad.isActive)
            : serverMad;
      }).toList();

      // Step 4: add elemnts to local storage
      for (var mad in processedMads) {
        await _addLocalMad(mad);
      }

      return Right(processedMads);
    } catch (e) {
      return Left(
          CacheFailure(message: "Failed to process MADs: ${e.toString()}"));
    }
  }

  /// Change the status of a specific MAD in local storage
  Future<Either<Failure, void>> changeMadStatus({
    required int index,
    required bool status,
  }) async {
    try {
      //TODO: remove cache when logout
      // Retrieve the current list of MADs
      final localMads = await _getLocalMads();
      final updatedMad = localMads[index].copyWith(isActive: status);

      // Update the MAD status in local storage
      await _updateMadToLocal(updatedMad, index);

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(
          message: "Failed to change MAD status: ${e.toString()}"));
    }
  }

  /// Helper to retrieve MADs from local storage
  Future<List<Mad>> _getLocalMads() async {
    return await madLocalService.getLocalMads();
  }

  /// Helper to update MADs in local storage
  Future<void> _addLocalMad(Mad mad) async {
    await madLocalService.addMadToLocal(mad);
  }

  Future<void> _updateMadToLocal(Mad mad, int index) async {
    await madLocalService.updateLocalMad(mad, index);
  }
}
