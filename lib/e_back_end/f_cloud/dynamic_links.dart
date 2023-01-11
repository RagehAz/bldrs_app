import 'dart:async';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  // --------------------
  /// private constructor to create instances of this class only in itself
  DynamicLinks.singleton();
  // --------------------
  /// Singleton instance
  static final DynamicLinks _singleton = DynamicLinks.singleton();
  // --------------------
  /// Singleton accessor
  static DynamicLinks get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// FirebaseDynamicLinks SINGLETON

  // --------------------
  /// FirebaseDynamicLinks SINGLETON
  FirebaseDynamicLinks _fireDynamicLinks;
  FirebaseDynamicLinks get firebaseDynamicLinks => _fireDynamicLinks ??= FirebaseDynamicLinks.instance;
  static FirebaseDynamicLinks getFireDynamicLinks() => DynamicLinks.instance.firebaseDynamicLinks;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String bldrsURLPrefix = 'https://bldrs.page.link';
  static const String flyerDynamicLink = 'https://bldrs.page.link/flyer';
  static const String bzPageDynamicLink = 'https://bldrs.page.link/business-page';
  static const String flyerPageDynamicLink = 'https://bldrs.page.link/flyer-page';
  // --------------------
  static const AndroidParameters androidParameters = AndroidParameters(
    packageName: Standards.androidPackageName,
    minimumVersion: 0,
    // fallbackUrl: ,
  );
  // --------------------
  static const IOSParameters iosParameters = IOSParameters(
    bundleId: Standards.iosBundleID,
    minimumVersion: Standards.appVersion,
    appStoreId: Standards.appStoreID,
    // fallbackUrl: ,
    // customScheme: ,
    /// IPAD
    // ipadBundleId: ,
    // ipadFallbackUrl: ,
  );
  // --------------------
  static const GoogleAnalyticsParameters googleAnalyticsParameters = GoogleAnalyticsParameters(
    // source: 'twitter',
    // medium: 'social',
    // campaign: 'example-promo',
    // content: 'Content of the thing',
    // term: 'Term is term',
  );
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : ...
  static Future<void> initDynamicLinks(BuildContext context) async {

    final FirebaseDynamicLinks _dynamicLinks = getFireDynamicLinks();

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
    PendingDynamicLinkData _data;

    await tryAndCatch(
      invoker: 'initializeDynamicLinks',
      functions: () async {

        /// 1 - GET INITIAL LINK AT APP STARTUP
        _data = await getFireDynamicLinks().getInitialLink();

      }
    );

    /// HANDLE LINK ON FOREGROUND
    if (_data != null){
      await _handleDynamicLink(_data);
    }


    // blog('initializeDynamicLinks : END');

  }
  // --------------------
  /// TESTED : old - not needed
  static Future<void> _handleDynamicLink(PendingDynamicLinkData data) async {

    // final FirebaseDynamicLinks _fdl = getFireDynamicLinks();
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
  /// TASK : TEST ME
  static Future<Uri> generateURI({
    @required String dynamicLink,
    @required String title,
    @required String description,
    @required String picURL,
    bool isShortLink = true,
    bool log = false,
  }) async {

    final DynamicLinkParameters _params = _createDynamicLinkParameters(
      dynamicLink: dynamicLink,
      title: title,
      description: description,
      picUrl: picURL,
    );

    Uri _uri;

    /// WHEN SHORT URL
    if (isShortLink == true){

      final ShortDynamicLink _shorDynamicLink = await getFireDynamicLinks().buildShortLink(_params);
      _uri = _shorDynamicLink?.shortUrl;

      if (log == true) {
        blogShortDynamicLink(_shorDynamicLink);
      }

    }

    /// WHEN LONG URL
    else {
      _uri = await getFireDynamicLinks().buildLink(_params);
    }

    if (log == true){
      DynamicLinks.blogURI(uri: _uri,);
    }

    return _uri;
  }
  // --------------------
  /// TASK : TEST ME
  static DynamicLinkParameters _createDynamicLinkParameters({
    @required String dynamicLink,
    @required String title,
    @required String description,
    @required String picUrl,
  }){

    final bool _picIsURL = ObjectCheck.isAbsoluteURL(picUrl);
    assert(picUrl == null || _picIsURL == true, 'pic can only be null or absolute url');

    return DynamicLinkParameters(
      link: Uri.parse(dynamicLink),
      uriPrefix: bldrsURLPrefix,
      androidParameters: androidParameters,
      iosParameters: iosParameters,
      googleAnalyticsParameters: googleAnalyticsParameters,
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(picUrl),
      ),
    );

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
  /// TASK : TEST ME
  static void blogShortDynamicLink(ShortDynamicLink shortDynamicLink){

    if (shortDynamicLink == null){
      blog('blogShortDynamicLink : link is null');
    }
    else {
      Mapper.blogMap(shortDynamicLink.asMap());
    }

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
}

class FlyerShareLink{
  // -----------------------------------------------------------------------------

  const FlyerShareLink();

  // -----------------------------------------------------------------------------

  /// GENERATE

  // --------------------
  /// TASK : TEST ME
  static Future<String> generate({
    @required BuildContext context,
    @required String flyerID,
    int slideIndex = 0,
  }) async {

    String _output;

    if (flyerID != null){

      final FlyerModel _flyer = await FlyerProtocols.fetchFlyer(
        context: context,
        flyerID: flyerID,
      );

      if (_flyer != null){

        final String _posterURL = await _getFlyerPosterURL(
          flyerID: flyerID,
        );

        final Uri _uri = await DynamicLinks.generateURI(
          dynamicLink: _createFlyerShareLinkDynamicLink(
            slideIndex: slideIndex,
            flyerID: flyerID,
          ),
          title: _createFlyerShareLinkTitle(
            context: context,
            flyerType: _flyer.flyerType,
            langCode: 'en',
          ),
          description: _flyer.headline,
          picURL: _posterURL,
          log: true,
          // isShortLink: true,
        );

        _output = _uri.toString();
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static String _createFlyerShareLinkDynamicLink({
    @required String flyerID,
    @required int slideIndex,
  }){

    return 'https://bldrs.page.link/flyer/$flyerID/$slideIndex';

  }
  // --------------------
  /// TASK : TEST ME
  static String _createFlyerShareLinkTitle({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required String langCode,
  }){

    final String _phid = FlyerTyper.getFlyerTypePhid(
      flyerType: flyerType,
      pluralTranslation: false,
    );

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    return _chainsProvider.translatePhid(
      phid: _phid,
      langCode: langCode,
    );

  }
  // --------------------
  /// TASK : TEST ME
  static Future<String> _getFlyerPosterURL({
    @required String flyerID,
  }) async {
    final String _posterPath = Storage.generateFlyerPosterPath(flyerID);
    final String _picURL = await FCM.getNootPicURLIfNotURL(_posterPath);
    return _picURL;
  }
  // --------------------
  /// NOT SURE ABOUT THIS
  // String putIDInFlyerDynamicLink (){
  //   return 'https://bldrs.page.link/flyer=${AuthFireOps.superUserID()}';
  // }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : TEST ME
  static String _getFlyerIDFromLink(String link) {
    /// sample link
    /// https://bldrs.page.link/flyer/5FzRLxTgRekkRzKflsjs/0
    final String _withoutIndex = TextMod.removeTextAfterLastSpecialCharacter(link, '/');
    final String _flyerID = TextMod.removeTextBeforeLastSpecialCharacter(_withoutIndex, '/');
    return _flyerID;
  }
  // --------------------
  /// TASK : TEST ME
  static int _getSlideIndexFromLink(String link) {

    final String indexString = TextMod.removeTextBeforeLastSpecialCharacter(link, '/');

    int _index = Numeric.transformStringToInt(indexString);

    /// so return zero if _index was null
    return _index ??= 0;
  }
  // -----------------------------------------------------------------------------

  /// JUMPERS

  // --------------------
  /// TASK : TEST ME
  static Future<void> jumpToFlyerScreenByLink({
    @required BuildContext context,
    @required String link,
  }) async {

    final String _flyerID = _getFlyerIDFromLink(link);
    final int _index = _getSlideIndexFromLink(link);

    blog('jumpToFlyerScreenByLink : flyerID : $_flyerID : index : $_index');

    await Nav.jumpToFlyerPreviewScreen(
      context: context,
      flyerID: _flyerID,
      // index: _index,
    );

  }
  // -----------------------------------------------------------------------------

  /*

  references : SHOULD DELETE WHEN EVERY THING IS GOOD


    /// TASK : TEST ME
    static Future<dynamic> createFlyerDynamicLink({
      @required BuildContext context,
      @required bool isShortURL,
      @required FlyerModel flyerModel,
      @required int slideIndex,
    }) async {


      final DynamicLinkParameters _parameters = DynamicLinkParameters(
        uriPrefix: bldrsURLPrefix,
        link: Uri.parse('https://bldrs.page.link/flyer/${flyerModel.id}/$slideIndex'),
        androidParameters: androidParameters,
        iosParameters: iosParameters,

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

      final FirebaseDynamicLinks _fdl = getFireDynamicLinks();

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

   */

  // -----------------------------------------------------------------------------
}

class ReferralLink{
  // -----------------------------------------------------------------------------

  const ReferralLink();

  // -----------------------------------------------------------------------------
  /*
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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

    final FirebaseDynamicLinks dynamicLink = DynamicLinks.getFireDynamicLinks();


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
      socialMetaTagParameters: const SocialMetaTagParameters(
        title: 'Dynamic link title',
        description: 'Dynamic link description',
        imageUrl: null,
      ),
    );

    final ShortDynamicLink _shortLink = await dynamicLink.buildShortLink(_parameters);

    final Uri _dynamicUrl = _shortLink.shortUrl;

    blog(_dynamicUrl);
    return _dynamicUrl.toString();
  }
   */
  // -----------------------------------------------------------------------------
  void f(){}
}
