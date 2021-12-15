// ignore_for_file: constant_identifier_names

abstract class FireColl{

  static const String users = 'users';

  static const String questions = 'questions';

  static const String bzz = 'bzz';

  static const String flyers = 'flyers';
  static const String flyersPromotions = 'flyersPromotions';

  static const String feedbacks = 'feedbacks';
  static const String admin = 'admin';

  static const String zones = 'zones';

  static const String keys = 'keys';

}
// -----------------------------------------------------------------------------
abstract class FireDoc {

  static const String admin_statistics = 'statistics';
  static const String admin_appState = 'appState';

  static const String zones_cities = 'cities';
  static const String zones_countries = 'countries';
  static const String zones_continents = 'continents';
  static const String zones_usa = 'usa'; /// TASK : temp
  static const String zones_currencies = 'currencies';

  static const String keys_stats = 'stats';
  static const String keys_specs = 'specs';
  static const String keys_propertiesKeywords = 'propertiesKeywords';
  static const String keys_designsKeywords = 'designKeywords';
  static const String keys_craftsKeywords = 'craftsKeywords';
  static const String keys_productsKeywords = 'productsKeywords';
  static const String keys_equipmentKeywords = 'equipmentKeywords';

}
// -----------------------------------------------------------------------------
abstract class FireSubColl {

  static const String users_user_asks = 'asks' ;
  static const String users_user_records = 'records';
  static const String users_user_records_bzz = 'follows';
  static const String users_user_records_flyers = 'saves';
  static const String users_user_notifications = 'notifications';

  static const String questions_question_chats = 'chats';
  static const String questions_question_counters = 'counters';

  static const String bzz_bz_counters = 'counters';
  static const String bzz_bz_follows = 'follows';
  static const String bzz_bz_calls = 'calls';
  static const String bzz_bz_chats = 'chats';
  static const String bzz_bz_notifications = 'notifications';
  static const String bzz_bz_credits = 'credits';

  static const String flyers_flyer_counters = 'counters';
  static const String flyers_flyer_saves = 'saves';
  static const String flyers_flyer_shares = 'shares';
  static const String flyers_flyer_views = 'views';
  static const String flyers_flyer_reviews = 'reviews';

  static const String zones_cities_cities = 'cities';
  static const String zones_countries_countries = 'countries';

}
// -----------------------------------------------------------------------------
abstract class FireSubDoc{

  static const String flyers_flyer_counters_counters = 'counters';
  static const String bzz_bz_counters_counters = 'counters';
  static const String bzz_bz_credits_log = 'log';
  static const String bzz_bz_credits_balance = 'balance';

}
// -----------------------------------------------------------------------------
abstract class StorageDoc{

  static const String users         = 'users';        /// storage/users/{userID}
  static const String logos         = 'logos';        /// storage/logos/{bzID}
  static const String slides        = 'slides';       /// storage/slides/{flyerID__XX} => XX is two digits for slideIndex
  static const String askPics       = 'askPics';      /// not used till now
  static const String notiBanners   = 'notiBanners';  /// storage/notiBanners/{notiID}
  static const String authors       = 'authors';

}
// -----------------------------------------------------------------------------
