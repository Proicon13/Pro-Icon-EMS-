import 'package:pro_icon/Core/constants/app_constants.dart';

import '../../Core/errors/exceptions.dart';
import '../../Core/local_storage/local_storage_provider.dart';
import '../models/mad.dart';

class MadLocalService {
  final ExtendedLocalService localStorage;

  MadLocalService({required this.localStorage});

  /// Retrieve the list of MADs from local storage
  Future<List<Mad>> getLocalMads() async {
    try {
      final madList = await localStorage.getList<Mad>(AppConstants.madListKey);
      return madList;
    } on CacheException catch (_) {
      rethrow;
    }
  }

  Future<void> addMadToLocal(Mad mad) async {
    try {
      await localStorage.add<Mad>(AppConstants.madListKey, mad);
    } on CacheException catch (_) {
      rethrow;
    }
  }

  /// Update the local storage with a new list of MADs
  Future<void> updateLocalMad(Mad updatedMad, int index) async {
    try {
      await localStorage.putAt<Mad>(AppConstants.madListKey, index, updatedMad);
    } on CacheException catch (_) {
      rethrow;
    }
  }
}
