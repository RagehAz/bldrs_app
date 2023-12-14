// ignore_for_file: non_constant_identifier_names
import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
/// => TAMAM
class StoragePath {
  // -----------------------------------------------------------------------------

  const StoragePath();
  // -----------------------------------------------------------------------------

  /// PHIDS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? phids_phid(String? phid){

    if (phid == null){
      return null;
    }

    else {
      return '${StorageColl.phids}/$phid';
    }

  }
  // -----------------------------------------------------------------------------

  /// USERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? users_userID_pic(String? userID){

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
  static String? bzz_bzID(String? bzID){

    if (bzID == null){
      return null;
    }

    else {
      return '${StorageColl.bzz}/$bzID';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? bzz_bzID_logo(String? bzID){

    if (bzID == null){
      return null;
    }

    else {
      return '${StorageColl.bzz}/$bzID/logo';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? bzz_bzID_authorID({
    required String? bzID,
    required String? authorID,
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
  static String? bzz_bzID_poster(String? bzID){

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
  static String? flyers_flyerID({
    required String? flyerID,
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
  static String? flyers_flyerID_index_big({
    required String? flyerID,
    required int? slideIndex,
  }){

    if (flyerID == null || slideIndex == null){
      return null;
    }

    else {

      return '${StorageColl.flyers}/$flyerID/${slideIndex}_big';

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? flyers_flyerID_index_med({
    required String? flyerID,
    required int? slideIndex,
  }){

    if (flyerID == null || slideIndex == null){
      return null;
    }

    else {

      return '${StorageColl.flyers}/$flyerID/${slideIndex}_med';

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? flyers_flyerID_index_small({
    required String? flyerID,
    required int? slideIndex,
  }){

    if (flyerID == null || slideIndex == null){
      return null;
    }

    else {

      return '${StorageColl.flyers}/$flyerID/${slideIndex}_small';

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? flyers_flyerID_index_back({
    required String? flyerID,
    required int? slideIndex,
  }){

    if (flyerID == null || slideIndex == null){
      return null;
    }

    else {

      return '${StorageColl.flyers}/$flyerID/${slideIndex}_back';

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? flyers_flyerID_poster(String? flyerID){

    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID/poster';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? flyers_flyerID_pdf(String? flyerID){

    if (flyerID == null){
      return null;
    }

    else {
      return '${StorageColl.flyers}/$flyerID/pdf';
    }

  }
  // -----------------------------------------------------------------------------
}
