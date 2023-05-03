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
      case BzAccountType.standard:  return Standards.maxFlyerSlidesFreeAccount;     break;
      case BzAccountType.pro: return Standards.maxFlyerSlidesPremiumAccount;  break;
      case BzAccountType.master:  return Standards.maxFlyerSlidesFreeSuper;       break;
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
  static const double logoWidthPixels = 500;
  static const double userPictureWidthPixels = 500;
  static const double authorPictureWidthPixels = 500;
  static const double slideWidthPixels = 1080;
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
}
