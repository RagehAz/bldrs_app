import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:bldrs/bldrs_keys.dart';

class Standards {
  // -----------------------------------------------------------------------------

  const Standards();

  // -----------------------------------------------------------------------------
  /// WEB SITE
  // -------
  static String bldrsWebSiteURL = 'https://www.bldrs.net';
  // -------
  /// TERMS - PRIVACY URLs
  // -------
  static String termsAndRegulationsURL = 'https://www.bldrs.net/#/terms';
  static String privacyPolicyURL = 'https://www.bldrs.net/#/privacy';
  static String deleteMyDataURL = 'https://www.bldrs.net/#/deletemydata';
  // --------------------
  /// APP LINKS
  // -------
  static const String iosAppStoreURL = 'https://apps.apple.com/eg/app/bldrs-net/id${BldrsKeys.appStoreID}?l=en';
  static const String androidAppStoreURL = 'https://play.google.com/store/apps/details?id=net.bldrs.app';
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBldrsStoreLink(){

    String? _url;

    if (DeviceChecker.deviceIsIOS() == true){
      _url = iosAppStoreURL;
    }
    else if (DeviceChecker.deviceIsAndroid() == true){
      _url = androidAppStoreURL;
    }

    return _url;
  }
  // -----------------------------------------------------------------------------

  /// LOADING SCREEN

  // --------------------
  static const int loadingScreenTimeOut = 55;
  // -----------------------------------------------------------------------------

  /// EDITORS STANDARDS

  // --------------------
  static const int minUserNameLength = 5;
  static const int minJobTitleLength = 2;
  static const int minCompanyNameLength = 2;
  // -----------------------------------------------------------------------------

  /// FLYER STANDARDS

  // --------------------
  /// MAX SLIDES PER BZ ACCOUNT TYPE
  static const int maxFlyerSlidesFreeAccount = 3;
  static const int maxFlyerSlidesPremiumAccount = 5;
  static const int maxFlyerSlidesFreeSuper = 7;
  // --------------------
  static const int flyerMaxDaysToUpdate = 3; // 3 days to update flyer
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getMaxSlidesCount({
    required BzAccountType? bzAccountType,
  }) {
    switch (bzAccountType) {
      case BzAccountType.basic:  return Standards.maxFlyerSlidesFreeAccount;
      case BzAccountType.advanced: return Standards.maxFlyerSlidesPremiumAccount;
      case BzAccountType.premium:  return Standards.maxFlyerSlidesFreeSuper;
      default:  return Standards.maxFlyerSlidesFreeAccount;
    }
  }
  // --------------------
  /// FLYER HEADLINE LENGTH
  static const int flyerHeadlineMaxLength = 180;
  static const int flyerHeadlineMinLength = 5;
  // -----------------------------------------------------------------------------

  /// BZ STANDARDS

  // --------------------
  static const int maxUserBzz = 10;
  static const int maxAuthorsPerBz = 20;
  // -----------------------------------------------------------------------------

  /// USER RECORDS STANDARDS

  // --------------------
  static const int maxUserFollows = 500;
  static const int maxUserSavedFlyers = 1000;
  // --------------------
  static const int countersRefreshTimeDurationInMinutes = 10;
  // -----------------------------------------------------------------------------

  /// CONTACTS STANDARDS

  // --------------------
  static bool bzPhoneIsMandatory = false;
  static bool bzWebsiteIsMandatory = false;
  // --------------------
  static bool authorPhoneIsMandatory = false;
  // -----------------------------------------------------------------------------

  /// OTHER STANDARDS

  // --------------------
  static const int maxTrigramLength = 5;
  static const int maxLocationFetchSeconds = 10;

  /// THIS IS USED TO TRIM PHID TEXT ON SCREEN TO AVOID OVERFLOW
  static const int maxPhidCharLengthBeforeTrim = 27;
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  static const int minSearchChar = 3;
  // -----------------------------------------------------------------------------

  /// FILE SIZES

  // --------------------
  static const int maxFileSizeLimit = 3; // in Mb
  // -----------------------------------------------------------------------------



  static const int ldbWipeIntervalInMinutes = 55;



  // -----------------------------------------------------------------------------

  /// IMAGES WIDTHS & QUALITIES

  // --------------------
  static const double bzLogoPicWidth = 350;
  static const int bzLogoPicQuality = 80;
  // --------------------
  static const double userPicWidth = 160;
  static const int userPicQuality = 80;
  // --------------------
  static const double authorPicWidth = 160;
  static const int authorPicQuality = 80;
  // --------------------
  static const double slideSmallWidth = 250;
  static const int slideSmallQuality = 75;
  // --------------------
  static const double slideMediumWidth = 495;
  static const int slideMediumQuality = 80;
  // --------------------
  static const double slideBigWidth = 1000;
  static const int slideBigQuality = 80;
  // -----------------------------------------------------------------------------

  /// POSTER SIZE

  // --------------------
  static const Dimensions posterDimensions = Dimensions(
    width: 720,
    height: 360,
  );
  // --------
  /*
  static const Dimensions oldSize = Dimensions(
    width: 360,
    height: 240,
  );
  // --------
  static const Dimensions iosMaxSize = Dimensions(
    width: 1038,
    height: 1038,
  );
  // --------
  // static const double notePosterWidthPixels = 1000; // NotePosterBox.standardSize.width
   */
  // -----------------------------------------------------------------------------

  /// BLDRS

  // --------------------
  /// BLDRS NAME SQUARE
  static const String bldrsNameSquarePicPath = 'storage/bldrs/bldrs_name.png';
  static const String bldrsNameSquarePicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_name.png?alt=media&token=1c23af54-b92a-4882-8139-5271f4d8c8ec';
  // --------------------
  /// BLDRS NAME
  static const String bldrsNamePosterPicPath = 'storage/bldrs/bldrs_name_poster.png';
  static const String bldrsNamePosterPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_name_poster.png?alt=media&token=70e6913b-e062-400d-84d3-08b6685ca037';
  // --------------------
  /// BLDRS APP ICON
  static const String bldrsAppIconPath = 'storage/bldrs/bldrs_app_icon.png';
  static const String bldrsAppIconURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_app_icon.png?alt=media&token=60403e98-27f2-4dd3-9d30-1e0035608692';
  // --------------------
  /// BLDRS NOTIFICATION ICON
  static const String bldrsNotificationSenderID = 'Bldrs.net';
  static const String bldrsNotificationIconPath = 'storage/bldrs/bldrs_notification_icon.png';
  static const String bldrsNotificationIconURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_notification_icon.png?alt=media&token=a398fa73-3856-4472-966f-8e15d0d8b27c';
  // --------------------
  /// EMAIL SIGNATURES
  static const String ragehBzCardPicPath = 'storage/bldrs/rageh_bz_card.png';
  static const String ragehBzCardPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Frageh_bz_card.png?alt=media&token=6a4d0520-cf4c-48eb-8361-c05da7d4f96e';
  // --------------------
  /// ON GOOGLE PLAY STORE
  static const String onGooglePlayStoreLabelPicPath = 'storage/bldrs/on_google_play_store_badge.png';
  static const String onGooglePlayStoreLabelPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fon_google_play_store_badge.png?alt=media&token=221fb970-0e24-4b77-b7f1-7c57b3cdde0e';
  // --------------------
  /// ON APP STORE
  static const String onAppleStoreLabelPicPath = 'storage/bldrs/on_app_store_badge.png';
  static const String onAppleStoreLabelPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fon_app_store_badge.png?alt=media&token=4738626b-db32-4694-8b0e-22de48d8ecef';
  // --------------------
  /// ANONYMOUS USER
  static const String anonymousUserPicPath = 'storage/bldrs/anonymous_user_pic.png';
  static const String anonymousUserPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fanonymous_user_pic.png?alt=media&token=619c4819-582f-45fe-a884-b8fee86965ac';
  // -----------------------------------------------------------------------------
}

const List<String> badWords = <String>[
  'fuck',
  'bitch',
  'whore',
  'kos',
  'omak',
];
