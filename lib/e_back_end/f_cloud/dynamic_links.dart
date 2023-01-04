import 'dart:async';

import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

/*

Bldr.net Use cases that require dynamic link

--> FLYER PAGE Url
  -> user1 share flyer
  -> dynamic link generated
  -> user2 clicks link
  -> install app if not installed
  -> open bldrs logo screen then home screen then flyer screen from url
  -> goes back to home screen

--> BZ PAGE url
  -> same steps as sharing a flyer but shows a special bz page then goes back to home page

--> AUTHORSHIP INVITATION
  -> general invitation link
  -> user1 send link to user2
  -> user2 clicks link
  -> install the app if not installed
  -> signs in or signs up
  -> show some authorship reminder dialog
  -> receive a late note from the invitation bz to join
  -> redirect to notes page

--> BLDRS.NET App link
  ->

 */

/// FDL : FIREBASE DYNAMIC LINK
class DynamicLinks {
  // -----------------------------------------------------------------------------

  const DynamicLinks();

  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String _uranus = 'https://en.m.wikipedia.org/wiki/Uranus';
  static const String bzPageDynamicLink = 'https://bldrs.page.link/business-page';
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : ...
  static Future<void> initDynamicLinks(BuildContext context) async {

    final FirebaseDynamicLinks _dynamicLinks = FirebaseDynamicLinks.instance;

    blog('initDynamicLinks : starting to listen to onLink');

    _dynamicLinks.onLink.listen((PendingDynamicLinkData dynamicLinkData) async {

      // Navigator.pushNamed(context, dynamicLinkData.link.path);

      final String _link = dynamicLinkData.link?.path;

      await Dialogs.centerNotice(
          context: context,
          verse: Verse.plain('onLink : $_link, and can navigate baby'),
      );

      final String _userID = TextMod.removeTextBeforeLastSpecialCharacter(_link, '=');

      await Nav.jumpToUserPreviewScreen(
          context: context,
          userID: _userID,
      );

      blogPendingDynamicLinkData(dynamicLinkData);

      if (dynamicLinkData == null){
        blog('initDynamicLinks : link is null');
      }

    }).onError((Object error) {
      blog('initDynamicLinks : error : ${error.runtimeType} : $error');
    });

  }
  // --------------------
  /// TESTED : old - not needed
  static Future<void> initializeDynamicLinks(BuildContext context) async {

    // blog('initializeDynamicLinks : START');

    /// 1 - GET INITIAL LINK AT APP STARTUP
    final PendingDynamicLinkData _data = await FirebaseDynamicLinks.instance.getInitialLink();

    await _handleDynamicLink(_data);

    /// HANDLE LINK ON FOREGROUND

    // blog('initializeDynamicLinks : END');

  }
  // --------------------
  /// TESTED : old - not needed
  static Future<void> _handleDynamicLink(PendingDynamicLinkData data) async {

    // final FirebaseDynamicLinks _fdl = FirebaseDynamicLinks.instance;
    // final Uri _deepLink = data?.link;
    //
    // if (_deepLink != null) {
    //
    //   // await goToFlyerScreenByDynamicLink(
    //   //   context: context,
    //   //   link: _deepLink.toString(),
    //   // );
    //
    //   blog('_handleDynamicLink : deepLink is : $_deepLink');
    //
    // }

    // _fdl.

    // _fdl.onLink.(
    //
    // onSuccess: (PendingDynamicLinkData data) async {
    //   await goToFlyerScreenByDynamicLink(
    //     context: context,
    //     link: data.link.toString(),
    //   );
    // },
    //
    // onError: (OnLinkErrorException error) async {
    //   blog(error.message);
    //
    //   await CenterDialog.showCenterDialog(
    //     context: context,
    //     title: 'ERROR',
    //     body: 'THERE IS SOME ERROR : $error',
    //   );
    // });


  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : ...
  static Future<Uri> createDynamicLink({
    @required String title,
    String description,
    String urlOrPath,
    bool isShortLink = true,
  }) async {

    final String _picURL = await FCM.getNootPicURLIfNotURL(urlOrPath);

    final DynamicLinkParameters _params = DynamicLinkParameters(
      link: Uri.parse('https://bldrs.page.link/flyer=${AuthFireOps.superUserID()}'),
      uriPrefix: Standards.dynamicLinksPrefix,
      androidParameters: const AndroidParameters(
        packageName: Standards.androidPackageName,
        minimumVersion: 0,
        // fallbackUrl: ,
      ),
      iosParameters: const IOSParameters(
        bundleId: Standards.iosBundleID,
        minimumVersion: '1.0.1',
        // fallbackUrl: ,
        // appStoreId: ,
        // customScheme: ,
        // ipadBundleId: ,
        // ipadFallbackUrl: ,
      ),
      googleAnalyticsParameters: const GoogleAnalyticsParameters(
        source: 'twitter',
        medium: 'social',
        campaign: 'example-promo',
        content: 'Content of the thing',
        term: 'Term is term',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(_picURL),
      ),
    );

    final FirebaseDynamicLinks _dynamicLinks = FirebaseDynamicLinks.instance;

    Uri _uri;
    if (isShortLink == true){
      final ShortDynamicLink _shorDynamicLink = await _dynamicLinks.buildShortLink(_params);
      blog('ShortDynamicLink : shortUrl : ${_shorDynamicLink.shortUrl}');
      blog('ShortDynamicLink : previewLink : ${_shorDynamicLink.previewLink}');
      blog('ShortDynamicLink : type : ${_shorDynamicLink.type}');
      blog('ShortDynamicLink : warnings : ${_shorDynamicLink.warnings}');
      _uri = _shorDynamicLink.shortUrl;
    }
    else {
      _uri = await _dynamicLinks.buildLink(_params);
    }

    return _uri;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPendingDynamicLinkData(PendingDynamicLinkData data){
    blog('blogPendingDynamicLinkData : START');
    blog('PendingDynamicLinkData : android : ${data?.android}');
    blog('PendingDynamicLinkData : android.clickTimestamp : ${data?.android?.clickTimestamp}');
    blog('PendingDynamicLinkData : android.minimumVersion : ${data?.android?.minimumVersion}');
    blog('PendingDynamicLinkData : ios : ${data?.ios}');
    blog('PendingDynamicLinkData : ios.matchType : ${data?.ios?.matchType}');
    blog('PendingDynamicLinkData : ios.minimumVersion : ${data?.ios?.minimumVersion}');
    blog('PendingDynamicLinkData : utmParameters : ${data?.utmParameters}');
    blog('blogPendingDynamicLinkData : END');
    blogURI(
      uri: data?.link,
      invoker: 'PendingDynamicLinkData',
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogURI({
    @required Uri uri,
    String invoker = ':',
  }){

    blog('blogURI $invoker : link : $uri');
    blog('blogURI $invoker : link.path : ${uri?.path}');
    blog('blogURI $invoker : link.hashCode : ${uri?.hashCode}');
    blog('blogURI $invoker : link.data : ${uri?.data}');
    blog('blogURI $invoker : link.queryParameters : ${uri?.queryParameters}');
    blog('blogURI $invoker : link.authority : ${uri?.authority}');
    blog('blogURI $invoker : link.fragment : ${uri?.fragment}');
    blog('blogURI $invoker : link.hasAbsolutePath : ${uri?.hasAbsolutePath}');
    blog('blogURI $invoker : link.hasAuthority : ${uri?.hasAuthority}');
    blog('blogURI $invoker : link.hasEmptyPath : ${uri?.hasEmptyPath}');
    blog('blogURI $invoker : link.hasFragment : ${uri?.hasFragment}');
    blog('blogURI $invoker : link.hasPort : ${uri?.hasPort}');
    blog('blogURI $invoker : link.hasQuery : ${uri?.hasQuery}');
    blog('blogURI $invoker : link.hasScheme : ${uri?.hasScheme}');
    blog('blogURI $invoker : link.query : ${uri?.query}');
    blog('blogURI $invoker : link.host : ${uri?.host}');
    blog('blogURI $invoker : link.isAbsolute : ${uri?.isAbsolute}');
    blog('blogURI $invoker : link.pathSegments : ${uri?.pathSegments}');
    blog('blogURI $invoker : link.port : ${uri?.port}');
    blog('blogURI $invoker : link.scheme : ${uri?.scheme}');
    blog('blogURI $invoker : link.userInfo : ${uri?.userInfo}');
    blog('blogURI $invoker : link.queryParametersAll : ${uri?.queryParametersAll}');

    // blog('blogURI $invoker : link.origin : ${uri?.origin}'); // Unhandled Exception: Bad state: Origin is only applicable schemes http and https:
  }
  // -----------------------------------------------------------------------------

  /// OLD CODES

  // --------------------
  static void handleSuccessLinking(PendingDynamicLinkData data) {

    final Uri _deepLink = data?.link;

    if (_deepLink != null) {
      final bool _isRefer = _deepLink.pathSegments.contains('refer');

      if (_isRefer) {

        final String _code = _deepLink.queryParameters['code'];
        blog(_code);

        if (_code != null) {
          navigatorKey.currentState.pushNamed(Routing.dynamicLinkTest, arguments: _code);
        }

      }
    }
  }
  // --------------------
  static Future<String> createReferralLink(String referralCode) async {
    // final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
    //   uriPrefix: 'https://bldrs.page.link',
    //   link: Uri.parse('https://fluttertutorial.com/refer?code=$referralCode'),
    //   androidParameters: AndroidParameters(
    //     packageName: 'com.devscore.flutter_tutorials',
    //   ),
    //   socialMetaTagParameters: SocialMetaTagParameters(
    //     title: 'Refer A Friend',
    //     description: 'Refer and earn',
    //     imageUrl: Uri.parse(
    //         'https://www.insperity.com/wp-content/uploads/Referral-_Program1200x600.png'),
    //   ),
    // );

    final FirebaseDynamicLinks dynamicLink = FirebaseDynamicLinks.instance;


    final DynamicLinkParameters _parameters = DynamicLinkParameters(
      uriPrefix: 'https://bldrs.page.link',
      link: Uri.parse('https://bldrs.page.link/flyer'),
      androidParameters: const AndroidParameters(
        packageName: 'com.bldrs.net',
        minimumVersion: 0,
        // fallbackUrl: null,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.bldrs.net',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Dynamic link title',
        description: 'Dynamic link description',
        imageUrl: Uri.parse(_uranus),
      ),
    );

    final ShortDynamicLink _shortLink = await dynamicLink.buildShortLink(_parameters);

    final Uri _dynamicUrl = _shortLink.shortUrl;

    blog(_dynamicUrl);
    return _dynamicUrl.toString();
  }
  // --------------------
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // --------------------
  static Future<dynamic> createFlyerDynamicLink({
    @required BuildContext context,
    @required bool isShortURL,
    @required FlyerModel flyerModel,
    @required int slideIndex,
  }) async {


    final DynamicLinkParameters _parameters = DynamicLinkParameters(
      uriPrefix: 'https://bldrs.page.link',
      link: Uri.parse(
          'https://bldrs.page.link/flyer/${flyerModel.id}/$slideIndex'),
      androidParameters: const AndroidParameters(
        packageName: 'com.bldrs.net',
        minimumVersion: 0,
        // fallbackUrl: null,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.bldrs.net',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: FlyerTyper.getFlyerTypePhid(
          flyerType: flyerModel.flyerType,
          pluralTranslation: false,
        ),
        description: flyerModel.slides[slideIndex].headline,
        imageUrl: Uri.parse(flyerModel.slides[slideIndex].picPath),
      ),
    );

    Uri _url;

    final FirebaseDynamicLinks _fdl = FirebaseDynamicLinks.instance;

    /// if short link
    if (isShortURL) {
      final ShortDynamicLink shortLink = await _fdl.buildShortLink(_parameters);
      blog(shortLink.toString());
      _url = shortLink.shortUrl;
    }

    /// if long link
    else {
      _url = await _fdl.buildLink(_parameters);
    }

    return _url.toString();
  }
  // --------------------
  static String getFlyerIDFromDynamicLink(String link) {
    /// sample link
    /// https://bldrs.page.link/flyer/5FzRLxTgRekkRzKflsjs/0
    final String _withoutIndex = TextMod.removeTextAfterLastSpecialCharacter(link, '/');
    final String _flyerID = TextMod.removeTextBeforeLastSpecialCharacter(_withoutIndex, '/');
    return _flyerID;
  }
  // --------------------
  static int getSlideIndexFromDynamicLink(String link) {

    final String indexString = TextMod.removeTextBeforeLastSpecialCharacter(link, '/');

    int _index = Numeric.transformStringToInt(indexString);

    /// so return zero if _index was null
    return _index ??= 0;
  }
  // --------------------
  static Future<void> goToFlyerScreenByDynamicLink({
    @required BuildContext context,
    @required String link,
  }) async {

    // final int _index = DynamicLinks.getSlideIndexFromDynamicLink(link);
    final String _flyerID = DynamicLinks.getFlyerIDFromDynamicLink(link);

    await Nav.jumpToFlyerPreviewScreen(
      context: context,
      flyerID: _flyerID,
    );

  }
  // -----------------------------------------------------------------------------
}
