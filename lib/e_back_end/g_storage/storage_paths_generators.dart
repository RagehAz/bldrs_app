import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class StoragePathGenerator {
  // -----------------------------------------------------------------------------

  const StoragePathGenerator();

  // -----------------------------------------------------------------------------

  /// USER STORAGE PATHS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateUserPicPath(String userID){

    if (userID == null){
      return null;
    }

    else {
      return '${StorageColl.users}/$userID/pic';
    }

  }
  // -----------------------------------------------------------------------------

  /// BZ STORAGE PATHS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateBzLogoPath(String bzID){

    if (bzID == null){
      return null;
    }

    else {
      return '${StorageColl.bzz}/$bzID/logo';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateAuthorPicPath({
    @required String bzID,
    @required String authorID,
  }){

    if (bzID == null || authorID == null){
      return null;
    }

    else {
      return '${StorageColl.bzz}/$bzID/$authorID';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateBzPostPicPath(String bzID){

    if (bzID == null){
      return null;
    }

    else {
      return '${StorageColl.bzz}/$bzID/poster';
    }

  }
  // -----------------------------------------------------------------------------

  /// FLYER STORAGE PATHS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateFlyerSlidePath({
    @required String flyerID,
    @required int slideIndex,
  }){

    if (flyerID == null || slideIndex == null){
      return null;
    }

    else {

      return '${StorageColl.flyers}/$flyerID/$slideIndex';

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateFlyerPosterPath(String flyerID){

    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID/poster';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateFlyerPDFPath(String flyerID){

    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID/pdf';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateTestPosterPath (String id){
    return '${StorageColl.posters}/tests/$id';
  }
  // -----------------------------------------------------------------------------
}

class BldrStorage {
  // -----------------------------------------------------------------------------

  const BldrStorage();
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED: WORKS PERFECT
  static const generateUserPicPath = StoragePathGenerator.generateUserPicPath;
  static const generateBzLogoPath = StoragePathGenerator.generateBzLogoPath;
  static const generateAuthorPicPath = StoragePathGenerator.generateAuthorPicPath;
  static const generateBzPostPicPath = StoragePathGenerator.generateBzPostPicPath;
  static const generateFlyerSlidePath = StoragePathGenerator.generateFlyerSlidePath;
  static const generateFlyerPosterPath = StoragePathGenerator.generateFlyerPosterPath;
  static const generateFlyerPDFPath = StoragePathGenerator.generateFlyerPDFPath;
  static const generateTestPosterPath = StoragePathGenerator.generateTestPosterPath;
  // -----------------------------------------------------------------------------
}
