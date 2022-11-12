import 'package:flutter/material.dart';

/// ------------------------------------o

/*

  | => STORAGE DATA TREE ----------------------|
  |
  | - [admin]
  |     | - stuff ...
  |     | - ...
  |
  | --------------------------|
  |
  | - [users]
  |     | - {userID}
  |     |     | - pic.jpeg
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [bzz]
  |     | - {bzID}
  |     |     | - logo.jpeg
  |     |     | - poster.jpeg
  |     |     | - {authorID}.jpeg
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [flyers]
  |     | - {flyerID}
  |     |     | - attachment.pdf
  |     |     | - poster.jpg
  |     |     | - {slide_id}.jpeg
  |     |     | - ...
  |     |
  |     | - ...
  |
  | -------------------------------------------|

 */

/// ------------------------------------o

abstract class StorageColl{
  // -----------------------------------------------------------------------------

  const StorageColl();

  // -----------------------------------------------------------------------------

  /// COLL NAMES

  // --------------------
  static const String users         = 'users';
  static const String bzz           = 'bzz';
  static const String flyers        = 'flyers';
  // -----------------------------------------------------------------------------

  /// PATH GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateUserPicPath(String userID){

    if (userID == null){
      return null;
    }
    else {
      return '$users/$userID/pic';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateBzLogoPath(String bzID){

    if (bzID == null){
      return null;
    }
    else {
      return '$bzz/$bzID/logo';
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
      return '$bzz/$bzID/$authorID';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateBzPostPicPath(String bzID){

    if (bzID == null){
      return null;
    }
    else {
      return '$bzz/$bzID/poster';
    }

  }
  // --------------------
  static String generateFlyerSlidePath({
    @required String flyerID,
    @required int slideIndex,
  }){

    if (flyerID == null || slideIndex == null){
      return null;
    }
    else {
      // final String slideID = SlideModel.generateSlideID(
      //     flyerID: flyerID,
      //     slideIndex: slideIndex
      // );
      return '$flyers/$flyerID/$slideIndex';
    }

  }
  // --------------------
  static String generateFlyerPosterPath(String flyerID){

    if (flyerID == null){
      return null;
    }
    else {
      return '$flyers/$flyerID/poster';
    }

  }
  // --------------------
  static String generateFlyerPDFPath(String flyerID){

    if (flyerID == null){
      return null;
    }
    else {
      return '$flyers/$flyerID/pdf';
    }

  }
  // --------------------

  /// DEPRECATED LOCATIONS
  static const String logos         = 'logos';        /// storage/logos/{bzID}
  static const String slides        = 'slides';       /// storage/slides/{flyerID__XX} => XX is two digits for slideIndex
  static const String askPics       = 'askPics';      /// not used till now
  static const String posters       = 'posters';      /// storage/posters/{notiID}
  static const String authors       = 'authors';
  static const String flyersPDFs    = 'flyersPDFs'; /// storage/flyersPDFs/{flyerID}

  // --------------------
}
