// ignore_for_file: constant_identifier_names
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';

/// ------------------------------------o

// FIRE DATA TREE

/*

  | => FIRE DATA TREE -------------------------|
  |
  | - [admin]
  |     | - stuff
  |     | - ...
  |
  | --------------------------|
  |
  | - [users]
  |     | - {userID}
  |     |     | - [notes]
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [bzz]
  |     | - {bzID}
  |     |     | - [notes]
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [flyers]
  |     | - {flyerID}
  |     |     | - [reviews]
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [keywords]
  |     | - [map]
  |     |
  |     | - [langCode]
  |     |...  |
  |
  | -------------------------------------------|

 */

abstract class FireColl{

  const FireColl();

  static const String users = 'users';

  static const String bzz = 'bzz';

  static const String flyers = 'flyers';

  static const String admin = 'admin';

  static const String phrases_cities = 'phrases_cities';

  static const String keywords = 'keywords';

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getPartyCollName(PartyType? partyType){
    return partyType == PartyType.user ?
    FireColl.users
        :
    FireColl.bzz;
  }
  // --------------------
}
/// -----------------------
abstract class FireDoc {

  static const String admin_backups = 'backups';
  static const String admin_appState = 'appState';

  static const String keywords_map = 'map';

}
/// -----------------------
abstract class FireSubColl {

  static const String admin_backups_phrases = 'phrases';
  static const String admin_backups_chains = 'chains';
  static const String admin_backups_currencies = 'currencies';

  static const String noteReceiver_receiver_notes = 'notes';


  static const String bzz_bz_chats = 'chats';
  static const String bzz_bz_credits = 'credits';

  static const String flyers_flyer_reviews = 'reviews';

}
/// -----------------------
abstract class FireSubDoc{

  static const String flyers_flyer_counters_counters = 'counters';
  static const String bzz_bz_counters_counters = 'counters';
  static const String bzz_bz_credits_log = 'log';
  static const String bzz_bz_credits_balance = 'balance';

  static const String admin_backups_phrases_ar = 'ar';
  static const String admin_backups_phrases_en = 'en';
  static const String admin_backups_phrases_lastUpdateTime = 'last_update_time';

  static const String admin_backups_chains_keywords = 'keywords';
  static const String admin_backups_chains_specs = 'specs';
  static const String admin_backups_chains_lastUpdateTime = 'last_update_time';

  static const String admin_backups_currencies_currencies = 'currencies';
}
/// ------------------------------------o
