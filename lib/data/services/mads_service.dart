import 'package:pro_icon/Core/constants/app_constants.dart';

import '../../Core/errors/exceptions.dart';
import '../../Core/local_storage/local_storage_provider.dart';
import '../models/mad.dart';

class MadLocalService {
  final BaseLocalService localStorage;

  MadLocalService({required this.localStorage});

  /// Retrieve the list of MADs from local storage
  Future<List<Mad>> getLocalMads() async {
    try {
      final madList =
          await localStorage.get<List<Mad>>(AppConstants.madListKey);
      return madList ?? []; // Return an empty list if no data exists
    } on CacheException catch (_) {
      rethrow;
    }
  }

  /// Update the local storage with a new list of MADs
  Future<void> updateLocalMadsList(List<Mad> mads) async {
    try {
      await localStorage.put<List<Mad>>(AppConstants.madListKey, mads);
    } on CacheException catch (_) {
      rethrow;
    }
  }
}
