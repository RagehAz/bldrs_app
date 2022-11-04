import 'package:flutter/material.dart';

/// ------------------------------------o


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
  static String getUserPicPath(String userID){

    if (userID == null){
      return null;
    }
    else {
      return '$users/$userID/pic';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzLogoPath(String bzID){

    if (bzID == null){
      return null;
    }
    else {
      return '$bzz/$bzID/logo';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getAuthorPicPath({
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
  static String getBzPosterPath(String bzID){

    if (bzID == null){
      return null;
    }
    else {
      return '$bzz/$bzID/poster';
    }

  }
  // --------------------
  static String getFlyerSlidePath({
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
  static String getFlyerPosterPath(String flyerID){

    if (flyerID == null){
      return null;
    }
    else {
      return '$flyers/$flyerID/poster';
    }

  }
  // --------------------
  static String getFlyerPDFPath(String flyerID){

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
