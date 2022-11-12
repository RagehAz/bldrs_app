import 'package:bldrs/e_back_end/g_storage/foundation/storage_paths.dart';
import 'package:flutter/material.dart';

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
  static String generateFlyerPosterPath(String flyerID){

    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID/poster';
    }

  }
  // --------------------
  static String generateFlyerPDFPath(String flyerID){

    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID/pdf';
    }

  }
  // -----------------------------------------------------------------------------
}
