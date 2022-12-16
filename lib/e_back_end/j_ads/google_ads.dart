import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';

enum AdFormat {
appOpen,
banner,
interstitial,
interstitialVideo,
rewarded,
rewardedInterstitial,
nativeAdvanced,
nativeAdvancedVideo,
}

class GoogleAds {

  // --------------------
  /// private constructor to create instances of this class only in itself
  GoogleAds.singleton();
  // --------------------
  /// Singleton instance
  static final GoogleAds _singleton = GoogleAds.singleton();
  // --------------------
  /// Singleton accessor
  static GoogleAds get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// INSTANCE

  // --------------------
  // /// CONNECTIVITY SINGLETON
  // Connectivity _connectivity;
  // Connectivity get connectivity => _connectivity ??= Connectivity();
  // static Connectivity getConnectivity() => DeviceChecker.instance.connectivity;
  // -----------------------------------------------------------------------------

  /// INITIALIZERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  static Future<void> disposeAd(Ad ad) async {
    await ad?.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  static BannerAd createBannerAd(){

    final BannerAd _myBanner = BannerAd(
      adUnitId: getBannerAdUnitId(
        testMode: true,
      ),
      size: AdSize.banner,
      request: _createAdRequest(),
      listener: createBannerAdListener(),
    );

    return _myBanner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AdRequest _createAdRequest(){

    return const AdRequest(
      // neighboringContentUrls: ,
      // mediationExtrasIdentifier: ,
      // httpTimeoutMillis: ,
      // extras: ,
      // contentUrl: ,
      // keywords: ,
      // nonPersonalizedAds: ,
    );

  }
  // --------------------
  /// TASK : TEST ME
  static BannerAdListener createBannerAdListener(){

    return BannerAdListener(
      /// Called when an ad is successfully received.
      onAdLoaded: (Ad ad){
        blogAd(ad: ad, invoker: 'onAdLoaded',);
      },

      /// Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) async {
        // Dispose the ad here to free resources.
        await disposeAd(ad);
        blogAd(ad: ad, invoker: 'onAdFailedToLoad',);
        blogLoadAdError(error: error, invoker: 'onAdFailedToLoad',);
      },

      /// Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad){
        blogAd(ad: ad, invoker: 'onAdOpened',);
      },

      /// Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad){
        blogAd(ad: ad, invoker: 'onAdClosed',);
      },

      /// Called when an impression occurs on the ad.
      onAdImpression: (Ad ad){
        blogAd(ad: ad, invoker: 'onAdImpression',);
      },

      onPaidEvent: (Ad ad, double valueMicros, PrecisionType precision, String currencyCode) {
        blog('valueMicros : $valueMicros : precision : $precision : currencyCode : $currencyCode : invoker: onPaidEvent',);
        blogAd(ad: ad, invoker: 'onPaidEvent',);
      },

      onAdWillDismissScreen: (Ad ad) {
        blogAd(ad: ad, invoker: 'onAdWillDismissScreen',);
      },

      onAdClicked: (Ad ad) {
        blogAd(ad: ad, invoker: 'onAdClicked',);
      },

    );

  }
  // -----------------------------------------------------------------------------

  /// UNIT ID

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBannerAdUnitId({
    @required bool testMode
  }){

    if (testMode == true || kDebugMode == true){
      return _getTestUnitID(AdFormat.banner);
    }

    else {
      return _getLiveUnitID();
    }

  }
  // --------------------
  ///
  static String _getTestUnitID(AdFormat adFormat){

    /// ANDROID TEST UNIT IDS
    switch (adFormat){
      case AdFormat.appOpen	              : return 'ca-app-pub-3940256099942544/3419835294'; break;
      case AdFormat.banner	              : return 'ca-app-pub-3940256099942544/6300978111'; break;
      case AdFormat.interstitial	        : return 'ca-app-pub-3940256099942544/1033173712'; break;
      case AdFormat.interstitialVideo	    : return 'ca-app-pub-3940256099942544/8691691433'; break;
      case AdFormat.rewarded	            : return 'ca-app-pub-3940256099942544/5224354917'; break;
      case AdFormat.rewardedInterstitial	: return 'ca-app-pub-3940256099942544/5354046379'; break;
      case AdFormat.nativeAdvanced	      : return 'ca-app-pub-3940256099942544/2247696110'; break;
      case AdFormat.nativeAdvancedVideo	  : return 'ca-app-pub-3940256099942544/1044960115'; break;
      default : return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getLiveUnitID(){

    /// ANDROID
    if (DeviceChecker.deviceIsAndroid() == true) {
      return 'ca-app-pub-1416346029613600~1351124048';
    }

    /// IOS
    else if (DeviceChecker.deviceIsIOS() == true) {
      return 'ca-app-pub-1416346029613600~5098797361';
    }

    else {
      return null;
    }


  }

  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogAd({
    @required Ad ad,
    @required String invoker,
  }){

    if (ad == null){
      blog('blogAd : $invoker :ad is null');
    }

    else {
      blog('blogAd ------------------------------------------------------------------- START');
      blog('blogAd : $invoker : ${ad?.adUnitId}');
      blogResponseInfo(ad?.responseInfo);
      blog('blogAd ------------------------------------------------------------------- END');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogResponseInfo(ResponseInfo responseInfo){

    if (responseInfo == null){
      blog('blogResponseInfo : responseInfo is null');
    }
    else {
      blog('responseInfo.responseId                : ${responseInfo?.responseId}');
      blog('responseInfo.mediationAdapterClassName : ${responseInfo?.mediationAdapterClassName}');
      blog('responseInfo.adapterResponses          : ${responseInfo?.adapterResponses}');
      // blog('responseInfo.loadedAdapterResponseInfo : ${responseInfo?.loadedAdapterResponseInfo}');
      // blog('responseInfo.responseExtras            : ${responseInfo?.responseExtras}');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogLoadAdError({
    @required String invoker,
    @required LoadAdError error,
  }){

    if (error == null){
      blog('blogLoadAdError : $invoker : error is null');
    }
    else {
      blog('error?.code :         ${error?.code}');
      blog('error?.domain :       ${error?.domain}');
      blog('error?.message :      ${error?.message}');
      blogResponseInfo(error?.responseInfo);
    }

  }
  // -----------------------------------------------------------------------------
  void f(){}
}
