// ignore_for_file: constant_identifier_names
import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:filers/filers.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:rest/rest.dart';
import 'package:stringer/stringer.dart';

/*

--> AUTHORSHIP INVITATION
  -> general invitation link
  -> user1 send link to user2
  -> user2 clicks link
  -> install the app if not installed
  -> signs in or signs up
  -> show some authorship reminder dialog
  -> receive a late note from the invitation bz to join
  -> redirect to notes page

 */

/// => TAMAM
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
  /// URI PREFIX
  static const String https_ll_bldrs_page_link = 'https://bldrs.page.link';
  // --------------------
  static const String bz_page = 'business-page';
  static const String https_ll_bldrs_page_link_l_bz_page = '$https_ll_bldrs_page_link/$bz_page';
  // --------------------
  static const String flyer_page = 'flyer-page';
  static const String https_ll_bldrs_page_link_l_flyer_page = '$https_ll_bldrs_page_link/$flyer_page';
  // --------------------
  static const String user_page = 'user-page';
  static const String https_ll_bldrs_page_link_l_user_page = '$https_ll_bldrs_page_link/$user_page';
  // --------------------
  static const AndroidParameters androidParameters = AndroidParameters(
    packageName: Standards.androidPackageName,
    minimumVersion: 0,
    // fallbackUrl: ,
  );
  // --------------------
  static const IOSParameters iosParameters = IOSParameters(
    bundleId: Standards.iosBundleID,
    minimumVersion: '0',//Standards.appVersion,
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
  /// TESTED : WORKS PERFECT
  static Future<void> initDynamicLinks(BuildContext context) async {

    blog('DynamicLinks.initDynamicLinks : starting to listen to onLink');

    getFireDynamicLinks().onLink.listen((PendingDynamicLinkData dynamicLinkData) async {

      final String _link = dynamicLinkData?.link?.path;

      blogPendingDynamicLinkData(dynamicLinkData);

      await _jumpByReceivedDynamicLink(
        link: _link,
      );

    }).onError((Object error) {
      blog('initDynamicLinks : error : ${error.runtimeType} : $error');
    });

  }
  // -----------------------------------------------------------------------------

  /// RECEIVING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _jumpByReceivedDynamicLink({
    @required String link,
  }) async {

    // link looks like this
    /// /flyer-page/flyerID/0
    /// /user-page/userID
    /// /business-page/bzID

    if (link != null) {

      final bool _canNav = UiProvider.proGetCanNavOnDynamicLink();

      if (_canNav == true) {

        UiProvider.proSetCanNavOnDynamicLink(
          setTo: false,
          notify: true,
        );

        final List<String> _nodes = ChainPathConverter.splitPathNodes(link);

        if (Mapper.checkCanLoopList(_nodes) == true) {
          final String _firstNode = _nodes.first;

          if (_firstNode == flyer_page) {
            await BldrsShareLink.jumpToFlyerScreenByLink(
              link: link,
            );
          } else if (_firstNode == user_page) {
            await BldrsShareLink.jumpToUserScreenByLink(
              link: link,
            );
          } else if (_firstNode == bz_page) {
            await BldrsShareLink.jumpToBzScreenByLink(
              link: link,
            );
          }
        }

      }
    }
  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
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
      Rest.blogURI(uri: _uri,);
    }

    return _uri;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
      uriPrefix: https_ll_bldrs_page_link,
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
    if (data == null){
      blog('blogPendingDynamicLinkData : data is null');
    }

    else {
      blog('blogPendingDynamicLinkData : START');
      blog('PendingDynamicLinkData : android : ${data?.android}');
      blog('PendingDynamicLinkData : android.clickTimestamp : ${data?.android?.clickTimestamp}');
      blog('PendingDynamicLinkData : android.minimumVersion : ${data?.android?.minimumVersion}');
      blog('PendingDynamicLinkData : ios : ${data?.ios}');
      blog('PendingDynamicLinkData : ios.matchType : ${data?.ios?.matchType}');
      blog('PendingDynamicLinkData : ios.minimumVersion : ${data?.ios?.minimumVersion}');
      blog('PendingDynamicLinkData : utmParameters : ${data?.utmParameters}');
      Rest.blogURI(
        uri: data?.link,
        invoker: 'PendingDynamicLinkData',
      );
    }

    blog('blogPendingDynamicLinkData : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogShortDynamicLink(ShortDynamicLink shortDynamicLink){

    if (shortDynamicLink == null){
      blog('blogShortDynamicLink : link is null');
    }
    else {
      Mapper.blogMap(shortDynamicLink.asMap());
    }

  }
  // -----------------------------------------------------------------------------
}

/// => TAMAM
class BldrsShareLink{
  // -----------------------------------------------------------------------------

  const BldrsShareLink();

  // -----------------------------------------------------------------------------

  /// GENERATE FLYER LINK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> generateFlyerLink({
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

        final String _posterURL = await _createFlyerPosterURL(
          flyerID: flyerID,
        );

        final String _title = await  _createFlyerShareLinkTitle(
          context: context,
          flyerType: _flyer.flyerType,
          langCode: 'en',
        );

        final Uri _uri = await DynamicLinks.generateURI(
          // '$bldrsURLPrefix/flyer=${AuthFireOps.superUserID()}';
          dynamicLink: '${DynamicLinks.https_ll_bldrs_page_link_l_flyer_page}/$flyerID/$slideIndex',
          title: _title,
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
  /// TESTED : WORKS PERFECT
  static Future<String> _createFlyerShareLinkTitle({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required String langCode, /// PLAN : IMPLEMENT ME
  }) async {

    final String _phid = FlyerTyper.getFlyerTypePhid(
      flyerType: flyerType,
      pluralTranslation: false,
    );

    final String _flyerTypeTranslation = await PhraseProtocols.translate(
      langCode: langCode ?? Localizer.getCurrentLangCode(context),
      phid: _phid,
    );

    return _flyerTypeTranslation;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> _createFlyerPosterURL({
    @required String flyerID,
  }) async {
    final String _posterPath = Storage.generateFlyerPosterPath(flyerID);
    final String _picURL = await FCM.getNootPicURLIfNotURL(_posterPath);
    return _picURL;
  }
  // -----------------------------------------------------------------------------

  /// FLYER LINK JUMPER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToFlyerScreenByLink({
    @required String link,
  }) async {

    final String _flyerID = _getFlyerIDFromLink(link);
    final int _index = _getSlideIndexFromLink(link);

    blog('jumpToFlyerScreenByLink : link : ($link) : flyerID : $_flyerID : index : $_index');

    await Nav.jumpToFlyerPreviewScreen(
      flyerID: _flyerID,
      // index: _index,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getFlyerIDFromLink(String link) {
    /// sample link
    /// flyer/5FzRLxTgRekkRzKflsjs/0
    final String _withoutIndex = TextMod.removeTextAfterLastSpecialCharacter(link, '/');
    final String _flyerID = TextMod.removeTextBeforeLastSpecialCharacter(_withoutIndex, '/');
    return _flyerID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int _getSlideIndexFromLink(String link) {

    final String indexString = TextMod.removeTextBeforeLastSpecialCharacter(link, '/');

    int _index = Numeric.transformStringToInt(indexString);

    /// so return zero if _index was null
    return _index ??= 0;
  }
  // -----------------------------------------------------------------------------

  /// GENERATE BZ LINK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> generateBzLink({
    @required BuildContext context,
    @required String bzID,
  }) async {

    String _output;

    if (bzID != null){

      final BzModel _bzModel = await BzProtocols.fetchBz(
        context: context,
        bzID: bzID,
      );

      if (_bzModel != null){

        final String _posterURL = await _createBzPosterURL(
          bzID: bzID,
        );

        final Uri _uri = await DynamicLinks.generateURI(
          dynamicLink: '${DynamicLinks.https_ll_bldrs_page_link_l_bz_page}/$bzID',
          title: _createBzShareLinkTitle(
            context: context,
            bzModel: _bzModel,
            langCode: 'en',
          ),
          description: _bzModel.name,
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
  /// TESTED : WORKS PERFECT
  static String _createBzShareLinkTitle({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String langCode, /// PLAN : IMPLEMENT LANG CODE
  }){

    final String _line = BzTyper.translateBzTypesIntoString(
      context: context,
      bzForm: bzModel.bzForm,
      bzTypes: bzModel.bzTypes,
      oneLine: true,
    );

    blog('_createBzShareLinkTitle : the line is : $_line');

    return _line;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> _createBzPosterURL({
    @required String bzID,
  }) async {
    final String _posterPath = Storage.generateBzLogoPath(bzID);
    final String _picURL = await FCM.getNootPicURLIfNotURL(_posterPath);
    return _picURL;
  }
  // -----------------------------------------------------------------------------

  /// BZ LINK JUMPER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToBzScreenByLink({
    @required String link,
  }) async {
    /// ${DynamicLinks.bldrsURLPrefix}/bz/bzID
    final String _bzID = TextMod.removeTextBeforeLastSpecialCharacter(link, '/');

    blog('jumpToBzScreenByLink : link : ($link) : _bzID : $_bzID');

    await Nav.jumpToBzPreviewScreen(
      bzID: _bzID,
    );

  }
  // -----------------------------------------------------------------------------

  /// GENERATE USER LINK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> generateUserLink({
    @required BuildContext context,
    @required String userID,
  }) async {

    String _output;

    if (userID != null){

      final UserModel _userModel = await UserProtocols.fetch(
        context: context,
        userID: userID,
      );

      if (_userModel != null){

        final String _posterURL = await _createUserPosterURL(
          userID: userID,
        );

        final Uri _uri = await DynamicLinks.generateURI(
          dynamicLink: '${DynamicLinks.https_ll_bldrs_page_link_l_user_page}/$userID',
          title: _userModel.name,
          description: _userModel.title,
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
  /// TESTED : WORKS PERFECT
  static Future<String> _createUserPosterURL({
    @required String userID,
  }) async {
    final String _posterPath = Storage.generateUserPicPath(userID);
    final String _picURL = await FCM.getNootPicURLIfNotURL(_posterPath);
    return _picURL;
  }
  // -----------------------------------------------------------------------------

  /// BZ LINK JUMPER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToUserScreenByLink({
    @required String link,
  }) async {
    /// ${DynamicLinks.bldrsURLPrefix}/user/userID
    final String _userID = TextMod.removeTextBeforeLastSpecialCharacter(link, '/');

    blog('jumpToUserScreenByLink : link : ($link) : _userID : $_userID');

    await Nav.jumpToUserPreviewScreen(
      userID: _userID,
    );

  }
  // -----------------------------------------------------------------------------
}

// class ReferralLink{
//   // -----------------------------------------------------------------------------
//
//   const ReferralLink();
//
//   // -----------------------------------------------------------------------------
//   /*
//   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   // --------------------
//   static void handleSuccessLinking(PendingDynamicLinkData data) {
//
//     final Uri _deepLink = data?.link;
//
//     if (_deepLink != null) {
//       final bool _isRefer = _deepLink.pathSegments.contains('refer');
//
//       if (_isRefer) {
//
//         final String _code = _deepLink.queryParameters['code'];
//         blog(_code);
//
//         if (_code != null) {
//           navigatorKey.currentState.pushNamed(Routing.dynamicLinkTest, arguments: _code);
//         }
//
//       }
//     }
//   }
//   // --------------------
//   static Future<String> createReferralLink(String referralCode) async {
//     // final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
//     //   uriPrefix: '${DynamicLinks.bldrsURLPrefix}',
//     //   link: Uri.parse('https://fluttertutorial.com/refer?code=$referralCode'),
//     //   androidParameters: AndroidParameters(
//     //     packageName: 'com.devscore.flutter_tutorials',
//     //   ),
//     //   socialMetaTagParameters: SocialMetaTagParameters(
//     //     title: 'Refer A Friend',
//     //     description: 'Refer and earn',
//     //     imageUrl: Uri.parse(
//     //         'https://www.insperity.com/wp-content/uploads/Referral-_Program1200x600.png'),
//     //   ),
//     // );
//
//     final FirebaseDynamicLinks dynamicLink = DynamicLinks.getFireDynamicLinks();
//
//
//     final DynamicLinkParameters _parameters = DynamicLinkParameters(
//       uriPrefix: '${DynamicLinks.bldrsURLPrefix}',
//       link: Uri.parse('${DynamicLinks.bldrsURLPrefix}/flyer'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.bldrs.net',
//         minimumVersion: 0,
//         // fallbackUrl: null,
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: 'com.bldrs.net',
//         minimumVersion: '0',
//       ),
//       socialMetaTagParameters: const SocialMetaTagParameters(
//         title: 'Dynamic link title',
//         description: 'Dynamic link description',
//         imageUrl: null,
//       ),
//     );
//
//     final ShortDynamicLink _shortLink = await dynamicLink.buildShortLink(_parameters);
//
//     final Uri _dynamicUrl = _shortLink.shortUrl;
//
//     blog(_dynamicUrl);
//     return _dynamicUrl.toString();
//   }
//    */
//   // -----------------------------------------------------------------------------
//   void f(){}
// }
