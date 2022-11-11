import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/x_utilities/link_model.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:flutter/material.dart';

/// TASK : should be saved on firestore to be able to edit them from dashboard
class Standards {
  // -----------------------------------------------------------------------------

  const Standards();

  // -----------------------------------------------------------------------------

  /// APP STANDARDS

  // --------------------
  static const String androidPackageName = 'com.bldrs.net';
  static const String iosBundleID = 'com.bldrs.net';
  static const String iosTeamID = '6ADZTHNZN9';
  static const String databaseURL = 'https://bldrsnet.firebaseio.com';
  static const String storageBucket = 'bldrsnet.appspot.com';
  static const String projectID = 'bldrsnet';
  static const String dynamicLinksPrefix = 'https://bldrs.page.link';
  // --------------------
  static const String ragehImageURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/users%2FXvwGvt42RFhvcz5CYr8xFujzI5F2.jpg?alt=media&token=99b37689-c553-4eed-a14f-b6530a393b45';
  // --------------------
  /// const String fcmSenderID = '439018969330';
  static const String fcmServerKey = 'AAAAZjeR2PI:APA91bFKc1fNq9zROuwRGnbTXWj-1REB9XDW9nIvWjAeM2dGtAORsJ-GrIMmppkUVWRgcGIAccZxMqABTQb6_ECkBKZeaWH81TBAXvvC74DiTJAuSmgIkbhkM224etLFLCnYiMzMTlcz';
  // --------------------
  /// APP CHECK
  // -------
  static const String androidSha256CertificateFingerprint = '87:94:db:51:e4:e1:05:ab:e1:c2:fd:9f:14:84:eb:da:a3:d1:88:94:1d:bc:46:b4:f7:9e:c3:a6:db:e0:ec:7c';
  static const String recaptchaSiteKey = '6Lel0dUiAAAAAEsveTwOOHn5vy6YQgIupaSQyRhb';
  static const String recaptchaSecretKey = '6Lel0dUiAAAAAGr34tOOmo823XhChFZVds2wgY8K';


  // --------------------
  static String getBldrsAppUpdateLink(BuildContext context){

    String _url;

    if (DeviceChecker.deviceIsIOS() == true){
      _url = 'www.apple.com';
    }
    else if (DeviceChecker.deviceIsAndroid() == true){
      _url = 'www.google.com';
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
  static int getMaxSlidesCount({
    @required BzAccountType bzAccountType,
  }) {
    switch (bzAccountType) {
      case BzAccountType.normal:  return Standards.maxFlyerSlidesFreeAccount;     break;
      case BzAccountType.premium: return Standards.maxFlyerSlidesPremiumAccount;  break;
      case BzAccountType.sphinx:  return Standards.maxFlyerSlidesFreeSuper;       break;
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
  static const double maxFileSizeLimit = 3; // in Mb
  // -----------------------------------------------------------------------------



  static const int dailyLDBWipeIntervalInHours = 24;



  // -----------------------------------------------------------------------------

  /// IMAGES WIDTHS

  // --------------------
  static const double logoWidthPixels = 500;
  static const double userPictureWidthPixels = 500;
  static const double authorPictureWidthPixels = 500;
  static const double slideWidthPixels = 1080;
  static const double notePosterWidthPixels = 1000;
  // -----------------------------------------------------------------------------

  /// STANDARD BLDRS LINKS

  // --------------------
  static const LinkModel bldrsWebSiteLink = LinkModel(
    url: 'www.bldrs.net',
    description: 'Download Bldrs.net App',
  );
  // --------------------
  static const LinkModel bldrsAppStoreLink = LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
  // --------------------
  static const LinkModel bldrsPlayStoreLink = LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
}
