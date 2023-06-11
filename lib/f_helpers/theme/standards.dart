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

  /// EXCHANGE RATES KEY

  // --------------------
  static String exchangeRateAppID = 'e34ede10438a4c22aa21cedb190ebae1';
  // -----------------------------------------------------------------------------

  /// GOOGLE MAPS KEYS

  // --------------------
  static String googleMapsAPIKey = 'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI';
  static String googleMapsPlatformAPIKey = 'AIzaSyDp6MMLw2LJflspqJ0x2uZCmQuZ32vS3XU';
  static String googleMapsPlatformAPIKey2 = 'AIzaSyD5CBTWvMaL6gU0X7gfdcnkpFmo-aNfgx4';
  // -----------------------------------------------------------------------------

  /// NOTES AND NOTIFICATIONS

  // --------------------
  /// URL will be reassigned in NoteFireOps.create if note.sender == bldrsSenderID
  // i bet the below link will be expired soon : today is 2 Oct 2022 => validate my claim when u see this again please
  static const String bldrsLogoStaticURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/admin%2Fbldrs_notification_icon?alt=media&token=d4f781f3-ea1b-4974-b6e3-990da03c980b';
  // --------------------
  static const String bldrsSenderID = 'Bldrs.net';
  static const String bldrsFCMIconFireStorageFileName = 'bldrs_notification_icon';
  // -----------------------------------------------------------------------------

  /// EMAIL SIGNATURE

  // --------------------
  static const String ragehBzCardURL = 'https://ci5.googleusercontent.com/proxy/XqVwTyaQh6FTf2ZNCA6gk3c1zrUyxY4puLCQhJJ_EP1SsIB4MR4EXhW_akV66hTig6766fbLBxGfERIK7I_CFi7PXcTJedd_ULrce0cE3nbfkl6Pfb9fWoSMnSl4OLbCXZHJaukPcxldiDi4gw2wWYgzcpQA5VRAAy6hIpBiWioewpq0wywcrF5MQ4k8nNqJPsjOAUjXNsOlbSJLsKyc9OIZng=s0-d-e1-ft#https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/email%2Frageh_label.png?alt=media&token=1a9d7bd4-5e07-4a0a-b59d-36a10155feaa';
  static const String onGooglePlayLabelURL = 'https://ci5.googleusercontent.com/proxy/3dSxOLvFgZvdsnr6AShbmDcBMDhzMHydImh6E8AucWflvTUKQUhdTTU4Iwb40t-LrZtMye64krE44IqpfCb_XCGkvLErOlCf7Prt5HKDeKmc13PI28FEkBqdpIl0r_CLXg58makNPuHq7dBwvBzvNFPcOYTpFKktwcsnvdMh6f4_Q2fBP6au9LqxDYp-ouJG41EgU0Y58yhLPB-jAMH9mQsHVWfCAJ9ZfQ=s0-d-e1-ft#https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/email%2Fgoogle_play_badge.png?alt=media&token=d82991b3-68fd-4f31-aaf9-b0866f42ef91';
  static const String onAppStoreLabelURL = 'https://ci4.googleusercontent.com/proxy/PZJqkW_c9C9tKoNeOAn9NK4PNIiticPlHl_dpoFY2g22bzdou5fKjOjspOjbnoIJxFsWTdVryk74fezFT4X638oeQuv3QcW9wFA_4BKKcNpDglXjrkbbrTOpyZMSB1i6vmc4Sa4VJOj0lKRfMUSzR801haknSiV4DRrElVQw84e8WlEZ0WfKtVk30daDK079AnDBjVyRq4DaciFa7AP3bADWRsjpFLY=s0-d-e1-ft#https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/email%2Fapp_store_badge.png?alt=media&token=053ef29a-21b9-4609-8197-ae9647f93f09';
  // -----------------------------------------------------------------------------
}
