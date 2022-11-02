import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class CacheOps {
  // -----------------------------------------------------------------------------

  const CacheOps();

  // -----------------------------------------------------------------------------

  /// GET DIRECTORY FILES

  // --------------------
  /// TESTED
  static Future<List<FileStat>> getAppDocDirFiles() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final List<FileStat> stats = _getFilesStatesFromDirectory(directory);
    return stats;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FileStat>> getTempDirFiles() async {
    final Directory directory = await getTemporaryDirectory();
    final List<FileStat> stats = _getFilesStatesFromDirectory(directory);
    return stats;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FileStat> _getFilesStatesFromDirectory(Directory directory){
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
  /// TESTED : WORKS PERFECT
  static void clearCache(){
    imageCache.clear();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void clearLiveImages(){
    imageCache.clearLiveImages();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void clearPaintingBindingImageCache(){
    PaintingBinding.instance.imageCache.clear();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> clearTempDirectoryCache() async {
    final Directory directory = await getTemporaryDirectory();
    await Directory(directory.path).delete(recursive: true);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> clearAppDocsDirectory() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    await Directory(directory.path).delete(recursive: true);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> clearCacheByManager() async {
    await DefaultCacheManager().emptyCache();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeCaches() async {

    await Future.wait(<Future>[
      CacheOps.clearTempDirectoryCache(),
      CacheOps.clearAppDocsDirectory(),
      CacheOps.clearCacheByManager(),
    ]);

    CacheOps.clearCache();
    CacheOps.clearLiveImages();
    CacheOps.clearPaintingBindingImageCache();

  }
// --------------------
}
