import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:mediators/mediators.dart';
import 'package:devicer/devicer.dart';
import 'package:flutter/material.dart';

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
  /// TASK : bldrs_app_publish_link add android and ios app store link : and do bldrs web as well
  static const String iosAppStoreURL = 'www.apple.com';
  static const String androidAppStoreURL = 'www.google.com';
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBldrsAppUpdateLink(BuildContext context){

    String _url;

    if (DeviceChecker.deviceIsIOS() == true){
      _url = iosAppStoreURL;
    }
    else if (DeviceChecker.deviceIsAndroid() == true){
      _url = androidAppStoreURL;
    }

    return _url;
  }
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
  static const int maxFlyerSlidesFreeAccount = 50;
  static const int maxFlyerSlidesPremiumAccount = 7;
  static const int maxFlyerSlidesFreeSuper = 25;
  // --------------------
  static const int flyerMaxDaysToUpdate = 3; // 3 days to update flyer
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getMaxSlidesCount({
    @required BzAccountType bzAccountType,
  }) {
    switch (bzAccountType) {
      case BzAccountType.basic:  return Standards.maxFlyerSlidesFreeAccount;     break;
      case BzAccountType.advanced: return Standards.maxFlyerSlidesPremiumAccount;  break;
      case BzAccountType.premium:  return Standards.maxFlyerSlidesFreeSuper;       break;
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
  // -----------------------------------------------------------------------------

  /// OTHER STANDARDS

  // --------------------
  static const int maxTrigramLength = 7;
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



  static const int ldbWipeIntervalInHours = 1;



  // -----------------------------------------------------------------------------

  /// IMAGES WIDTHS

  // --------------------
  static const double logoWidthPixels = 250;
  static const double userPictureWidthPixels = 250;
  static const double authorPictureWidthPixels = 250;
  static const double slideWidthPixels = 750;
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
  /// BLDRS NAME
  static const String bldrsNamePicPath = 'storage/bldrs/bldrs_name.png';
  static const String bldrsNamePicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_name.png?alt=media&token=e9c0e758-52ed-4709-a165-1044b2bf647a';
  // --------------------
  /// BLDRS APP ICON
  static const String bldrsAppIconPath = 'storage/bldrs/bldrs_app_icon.png';
  static const String bldrsAppIconURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_app_icon.png?alt=media&token=a8c7d599-e296-4604-9e2e-33e94088ddc2';
  // --------------------
  /// BLDRS NOTIFICATION ICON
  static const String bldrsNotificationSenderID = 'Bldrs.net';
  static const String bldrsNotificationIconPath = 'storage/bldrs/bldrs_notification_icon.png';
  static const String bldrsNotificationIconURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_notification_icon.png?alt=media&token=705340f3-0c6f-4764-8197-9d35f220f906';
  // --------------------
  /// EMAIL SIGNATURES
  static const String ragehBzCardPicPath = 'storage/bldrs/rageh_bz_card.png';
  static const String ragehBzCardPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Frageh_bz_card.png?alt=media&token=44db04c4-f38a-4528-b227-80564a828eef';
  // --------------------
  /// ON GOOGLE PLAY STORE
  static const String onGooglePlayStoreLabelPicPath = 'storage/bldrs/on_google_play_store_badge.png';
  static const String onGooglePlayStoreLabelPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fon_google_play_store_badge.png?alt=media&token=cac0123d-d3dd-44a2-bff8-bc4789e52726';
  // --------------------
  /// ON APP STORE
  static const String onAppleStoreLabelPicPath = 'storage/bldrs/on_app_store_badge.png';
  static const String onAppleStoreLabelPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fon_app_store_badge.png?alt=media&token=61035387-ffcb-4f08-a382-25d980eca95e';
  // --------------------
  /// ANONYMOUS USER
  static const String anonymousUserPicPath = 'storage/bldrs/anonymous_user_pic.png';
  static const String anonymousUserPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fanonymous_user_pic.png?alt=media&token=61005a82-e697-4d28-bfcc-e8e5d831a54b';
  // -----------------------------------------------------------------------------
}
