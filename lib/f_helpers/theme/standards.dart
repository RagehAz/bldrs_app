import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';

/// TASK : should be saved on firestore to be able to edit them from dashboard
class Standards {
  // -----------------------------------------------------------------------------

  const Standards();

  // -----------------------------------------------------------------------------

  /// APP STANDARDS

  // --------------------
  static const String appVersion = bldrsAppVersion;
  static const String androidPackageName = 'com.bldrs.net';
  static const String iosBundleID = 'com.bldrs.net';
  static const String appStoreID = '161803398875';
  // static const String iosTeamID = '6ADZTHNZN9';
  static const String databaseURL = 'https://bldrsnet.firebaseio.com';
  static const String storageBucket = 'bldrsnet.appspot.com';
  static const String projectID = 'bldrsnet';
  // --------------------
  /// const String fcmSenderID = '439018969330';
  static const String fcmServerKey = 'AAAAZjeR2PI:APA91bFKc1fNq9zROuwRGnbTXWj-1REB9XDW9nIvWjAeM2dGtAORsJ-GrIMmppkUVWRgcGIAccZxMqABTQb6_ECkBKZeaWH81TBAXvvC74DiTJAuSmgIkbhkM224etLFLCnYiMzMTlcz';
  // --------------------
  /// APP CHECK
  // -------
  // static const String androidSha256CertificateFingerprint = '87:94:db:51:e4:e1:05:ab:e1:c2:fd:9f:14:84:eb:da:a3:d1:88:94:1d:bc:46:b4:f7:9e:c3:a6:db:e0:ec:7c';
  static const String recaptchaSiteKey = '6Lel0dUiAAAAAEsveTwOOHn5vy6YQgIupaSQyRhb';
  // static const String recaptchaSecretKey = '6Lel0dUiAAAAAGr34tOOmo823XhChFZVds2wgY8K';
  // --------------------
  /// ?
  // -------
  // static const String txt = 'google-site-verification=wxjFdASVfSXbvutUts55hGKlLCfazk2Tyv_TlG_vCv8';
  // --------------------
  /// ANDROID KEY THING
  // -------
  // static const String appKeyDetails = 'CN=Rageh Azzazi, OU=Bldrs.net, O=Bldrs.net, L=Cairo, ST=Cairo, C=eg';
  // --------------------
  /// IOS PUSH NOTIFICATIONS
  // -------
  // static String bldrsPushKeyID = 'PA59ZYRS79';
  // --------------------
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
  static const int flyerHeadlineMaxLength = 50;
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
  static const String ipRegistryAPIKey = '89i23ivki8p5tsqj';
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  static const int minSearchChar = 3;
  // -----------------------------------------------------------------------------

  /// FILE SIZES

  // --------------------
  static const int maxFileSizeLimit = 3; // in Mb
  // -----------------------------------------------------------------------------



  static const int dailyLDBWipeIntervalInHours = 24;



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
