import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class CacheOps {
  // -----------------------------------------------------------------------------

  const CacheOps();


  static Future<List<FileStat>> getTempDirFiles() async {

    final Directory directory = await getApplicationDocumentsDirectory();

    final List<FileSystemEntity> entities = directory.listSync(recursive: true, followLinks: true);

    final List<FileStat> stats = <FileStat>[];
    for (final FileSystemEntity entity in entities){
      stats.add(entity.statSync());
    }

    return stats;
  }

  // -----------------------------------------------------------------------------

  /// CLEARING CACHE

  // --------------------
  ///
  static void clearCache(){
    imageCache.clear();
  }
  // --------------------
  ///
  static void clearLiveImages(){
    imageCache.clearLiveImages();
  }
  // --------------------
  ///
  static void clearPaintingBindingImageCache(){
    PaintingBinding.instance.imageCache.clear();
  }
  // --------------------
  ///
  static Future<void> clearTempDirectoryCache() async {
    final Directory directory = await getTemporaryDirectory();
    await Directory(directory.path).delete(recursive: true);
  }
  // --------------------
  ///
  static Future<void> clearAppDocsDirectory() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    await Directory(directory.path).delete(recursive: true);
  }
  // --------------------
  ///
  static Future<void> clearCacheByManager() async {
    await DefaultCacheManager().emptyCache();
  }


  // --------------------
  Future<void> deleteAllCacheThereIsInThisHeavyLaggyAppThatSucksMemoryLikeABlackHole() async {

    await Future.wait(<Future>[

      getTemporaryDirectory().then((Directory directory) async {
        await Directory(directory.path).delete(recursive: true);
      }),

      getApplicationDocumentsDirectory().then((Directory directory) async {
        await Directory(directory.path).delete(recursive: true);
      }),

      DefaultCacheManager().emptyCache(),

    ]);

    imageCache.clear();
    imageCache.clearLiveImages();
    PaintingBinding.instance.imageCache.clear();

  }
// --------------------
}
