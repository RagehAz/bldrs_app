// ignore_for_file: non_constant_identifier_names
import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class StoragePath {
  // -----------------------------------------------------------------------------

  const StoragePath();

  // -----------------------------------------------------------------------------

  /// USERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String users_userID_pic(String userID){

    if (userID == null){
      return null;
    }

    else {
      return '${StorageColl.users}/$userID/pic';
    }

  }
  // -----------------------------------------------------------------------------

  /// BZZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzz_bzID(String bzID){

    if (bzID == null){
      return null;
    }

    else {
      return '${StorageColl.bzz}/$bzID';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzz_bzID_logo(String bzID){

    if (bzID == null){
      return null;
    }

    else {
      return '${StorageColl.bzz}/$bzID/logo';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzz_bzID_authorID({
    @required String bzID,
    @required String authorID,
  }){

    if (bzID == null || authorID == null){
      return null;
    }

    else {
      /// IS AUTHOR PIC
      return '${StorageColl.bzz}/$bzID/$authorID';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bzz_bzID_poster(String bzID){

    if (bzID == null){
      return null;
    }

    else {
      return '${StorageColl.bzz}/$bzID/poster';
    }

  }
  // -----------------------------------------------------------------------------

  /// FLYERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String flyers_flyerID({
    @required String flyerID,
  }){
    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String flyers_flyerID_slideIndex({
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
  static String flyers_flyerID_poster(String flyerID){

    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID/poster';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String flyers_flyerID_pdf(String flyerID){

    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID/pdf';
    }

  }
  // -----------------------------------------------------------------------------
}
