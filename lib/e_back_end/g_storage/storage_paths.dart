
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
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
  static String getUserPicPath(String userID){

    if (userID == null){
      return null;
    }
    else {
      return '$users/$userID/pic';
    }

  }
  // --------------------
  static String getBzLogoPath(String bzID){

    if (bzID == null){
      return null;
    }
    else {
      return '$bzz/$bzID/logo';
    }

  }
  // --------------------
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
      final String slideID = SlideModel.generateSlideID(
          flyerID: flyerID,
          slideIndex: slideIndex
      );
      return '$flyers/$flyerID/$slideID';
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
