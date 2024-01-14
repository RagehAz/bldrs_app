// ignore_for_file: constant_identifier_names
import 'dart:async';

import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/rest/rest.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

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
  FirebaseDynamicLinks? _fireDynamicLinks;
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
    packageName: BldrsKeys.androidPackageID,
    minimumVersion: 0,
    // fallbackUrl: ,
  );
  // --------------------
  static const IOSParameters iosParameters = IOSParameters(
    bundleId: BldrsKeys.iosBundleID,
    minimumVersion: '0',//Standards.appVersion,
    appStoreId: BldrsKeys.appStoreID,
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
  static Future<void> initDynamicLinks() async {

    if (DeviceChecker.deviceIsIOS() == true || DeviceChecker.deviceIsAndroid() == true) {

      await tryAndCatch(
        invoker: 'initDynamicLinks',
        functions: () async {

          /// FOR APP WHEN WAS TERMINATED
          final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
          if (initialLink != null) {
            await _onDynamicLink(initialLink);
          }

          /// WHILE APP IN BACKGROUND OR FOREGROUND
          getFireDynamicLinks().onLink.listen((PendingDynamicLinkData? dynamicLinkData) async {

            await _onDynamicLink(dynamicLinkData);

          }).onError((Object error) async {
            blog('initDynamicLinks : error : ${error.runtimeType} : $error');
          });

        },
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _onDynamicLink(PendingDynamicLinkData? dynamicLinkData) async {

    if (dynamicLinkData != null){

      final String? _link = dynamicLinkData.link.path;

      blogPendingDynamicLinkData(dynamicLinkData);

      await _jumpByReceivedDynamicLink(
        link: _link,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// RECEIVING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _jumpByReceivedDynamicLink({
    required String? link,
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

        final List<String> _nodes = Pathing.splitPathNodes(link);

        if (Lister.checkCanLoop(_nodes) == true) {
          final String _firstNode = _nodes.first;

          if (_firstNode == flyer_page) {
            await BldrsShareLink.jumpToFlyerScreenByLink(
              link: link,
            );
          }

          else if (_firstNode == user_page) {
            await BldrsShareLink.jumpToUserScreenByLink(
              link: link,
            );
          }

          else if (_firstNode == bz_page) {
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
  static Future<Uri?> generateURI({
    required String? dynamicLink,
    required String? title,
    required String? description,
    required String? picURL,
    bool isShortLink = true,
    bool log = false,
  }) async {

    final DynamicLinkParameters? _params = _createDynamicLinkParameters(
      dynamicLink: dynamicLink,
      title: title,
      description: description,
      picUrl: picURL,
    );

    Uri? _uri;

    if (_params != null){

      /// WHEN SHORT URL
      if (isShortLink == true){

        final ShortDynamicLink? _shorDynamicLink = await getFireDynamicLinks().buildShortLink(_params);
        _uri = _shorDynamicLink?.shortUrl;

        if (log == true) {
          blogShortDynamicLink(_shorDynamicLink);
        }

      }

      /// WHEN LONG URL
      else {
        _uri = await getFireDynamicLinks().buildLink(_params);
      }

    }


    if (log == true){
      Rest.blogURI(uri: _uri,);
    }

    return _uri;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DynamicLinkParameters? _createDynamicLinkParameters({
    required String? dynamicLink,
    required String? title,
    required String? description,
    required String? picUrl,
  }){

    final bool _picIsURL = ObjectCheck.isAbsoluteURL(picUrl);
    assert(picUrl == null || _picIsURL == true, 'pic can only be null or absolute url');

    if (dynamicLink != null){
      return DynamicLinkParameters(
      link: Uri.parse(dynamicLink),
      uriPrefix: https_ll_bldrs_page_link,
      androidParameters: androidParameters,
      iosParameters: iosParameters,
      googleAnalyticsParameters: googleAnalyticsParameters,
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(picUrl!),
      ),
    );
    }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPendingDynamicLinkData(PendingDynamicLinkData? data){

    blog('blogPendingDynamicLinkData : START');
    if (data == null){
      blog('blogPendingDynamicLinkData : data is null');
    }

    else {
      blog('blogPendingDynamicLinkData : START');
      blog('PendingDynamicLinkData : android : ${data.android}');
      blog('PendingDynamicLinkData : android.clickTimestamp : ${data.android?.clickTimestamp}');
      blog('PendingDynamicLinkData : android.minimumVersion : ${data.android?.minimumVersion}');
      blog('PendingDynamicLinkData : ios : ${data.ios}');
      blog('PendingDynamicLinkData : ios.matchType : ${data.ios?.matchType}');
      blog('PendingDynamicLinkData : ios.minimumVersion : ${data.ios?.minimumVersion}');
      blog('PendingDynamicLinkData : utmParameters : ${data.utmParameters}');
      Rest.blogURI(
        uri: data.link,
        invoker: 'PendingDynamicLinkData',
      );
    }

    blog('blogPendingDynamicLinkData : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogShortDynamicLink(ShortDynamicLink? shortDynamicLink){

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
  static Future<String?> generateFlyerLink({
    required String? flyerID,
    required FlyerType? flyerType,
    required String? headline,
    int slideIndex = 0,
  }) async {

    String? _output;

    if (flyerID != null && flyerType != null){

        final String? _posterURL = await _createFlyerPosterURL(
          flyerID: flyerID,
        );

        final String? _title = await  _createFlyerShareLinkTitle(
          flyerType: flyerType,
          langCode: 'en',
        );

        final Uri? _uri = await DynamicLinks.generateURI(
          // '$bldrsURLPrefix/flyer=${Authing.getUserID()}';
          dynamicLink: '${DynamicLinks.https_ll_bldrs_page_link_l_flyer_page}/$flyerID/$slideIndex',
          title: _title,
          description: headline,
          picURL: _posterURL,
          log: true,
          // isShortLink: true,
        );

        _output = _uri.toString();

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> _createFlyerShareLinkTitle({
    required FlyerType flyerType,
    required String? langCode, /// PLAN : IMPLEMENT ME
  }) async {

    final String? _phid = FlyerTyper.getFlyerTypePhid(
      flyerType: flyerType,
      pluralTranslation: false,
    );

    final String? _flyerTypeTranslation = await Localizer.translateByLangCode(
      langCode: langCode ?? Localizer.getCurrentLangCode(),
      phid: _phid,
    );

    return _flyerTypeTranslation;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> _createFlyerPosterURL({
    required String? flyerID,
  }) async {
    final String? _posterPath = StoragePath.flyers_flyerID_poster(flyerID);
    final String? _picURL = await FCM.getNootPicURLIfNotURL(_posterPath);
    return _picURL;
  }
  // -----------------------------------------------------------------------------

  /// FLYER LINK JUMPER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToFlyerScreenByLink({
    required String? link,
  }) async {

    final String? _flyerID = _getFlyerIDFromLink(link);
    final int _index = _getSlideIndexFromLink(link);

    blog('jumpToFlyerScreenByLink : link : ($link) : flyerID : $_flyerID : index : $_index');

    await BldrsNav.jumpToFlyerPreviewScreen(
      flyerID: _flyerID,
      // index: _index,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _getFlyerIDFromLink(String? link) {
    /// sample link
    /// flyer/5FzRLxTgRekkRzKflsjs/0
    final String? _withoutIndex = TextMod.removeTextAfterLastSpecialCharacter(
        text: link,
        specialCharacter: '/',
    );
    final String? _flyerID = TextMod.removeTextBeforeLastSpecialCharacter(
        text: _withoutIndex,
        specialCharacter: '/',
    );

    return _flyerID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int _getSlideIndexFromLink(String? link) {

    final String? indexString = TextMod.removeTextBeforeLastSpecialCharacter(
        text: link,
        specialCharacter: '/',
    );

    int? _index = Numeric.transformStringToInt(indexString);

    /// so return zero if _index was null
    return _index ??= 0;
  }
  // -----------------------------------------------------------------------------

  /// GENERATE BZ LINK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> generateBzLink({
    required BuildContext context,
    required String? bzID,
  }) async {

    String? _output;

    if (bzID != null){

      final BzModel? _bzModel = await BzProtocols.fetchBz(
        bzID: bzID,
      );

      if (_bzModel != null){

        final String? _posterURL = await _createBzPosterURL(
          bzID: bzID,
        );

        final Uri? _uri = await DynamicLinks.generateURI(
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
    required BuildContext context,
    required BzModel? bzModel,
    required String? langCode, /// PLAN : IMPLEMENT LANG CODE
  }){

    final String _line = BzTyper.translateBzTypesIntoString(
      context: context,
      bzForm: bzModel?.bzForm,
      bzTypes: bzModel?.bzTypes,
      oneLine: true,
    );

    blog('_createBzShareLinkTitle : the line is : $_line');

    return _line;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> _createBzPosterURL({
    required String? bzID,
  }) async {
    final String? _posterPath = StoragePath.bzz_bzID_logo(bzID);
    final String? _picURL = await FCM.getNootPicURLIfNotURL(_posterPath);
    return _picURL;
  }
  // -----------------------------------------------------------------------------

  /// BZ LINK JUMPER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToBzScreenByLink({
    required String link,
  }) async {
    /// ${DynamicLinks.bldrsURLPrefix}/bz/bzID
    final String? _bzID = TextMod.removeTextBeforeLastSpecialCharacter(
        text: link,
        specialCharacter: '/',
    );

    blog('jumpToBzScreenByLink : link : ($link) : _bzID : $_bzID');

    await BldrsNav.jumpToBzPreviewScreen(
      bzID: _bzID,
    );

  }
  // -----------------------------------------------------------------------------

  /// GENERATE USER LINK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> generateUserLink({
    required String? userID,
  }) async {

    String? _output;

    if (userID != null){

      final UserModel? _userModel = await UserProtocols.fetch(
        userID: userID,
      );

      if (_userModel != null){

        final String? _posterURL = await _createUserPosterURL(
          userID: userID,
        );

        final Uri? _uri = await DynamicLinks.generateURI(
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
  static Future<String?> _createUserPosterURL({
    required String? userID,
  }) async {
    final String? _posterPath = StoragePath.users_userID_pic(userID);
    final String? _picURL = await FCM.getNootPicURLIfNotURL(_posterPath);
    return _picURL;
  }
  // -----------------------------------------------------------------------------

  /// BZ LINK JUMPER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToUserScreenByLink({
    required String link,
  }) async {
    /// ${DynamicLinks.bldrsURLPrefix}/user/userID
    final String? _userID = TextMod.removeTextBeforeLastSpecialCharacter(
        text: link,
        specialCharacter: '/',
    );

    blog('jumpToUserScreenByLink : link : ($link) : _userID : $_userID');

    await BldrsNav.jumpToUserPreviewScreen(
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
//         packageName: 'net.bldrs.app',
//         minimumVersion: 0,
//         // fallbackUrl: null,
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: 'net.bldrs.app',
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
// }
