import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinksApi {
// -----------------------------------------------------------------------------
//   final String _ragehURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/usersPics%2FrBjNU5WybKgJXaiBnlcBnfFaQSq1.jpg?alt=media&token=9a9db754-7d0c-40f8-b285-1df5e660c282';
  final String _uranus = 'https://en.m.wikipedia.org/wiki/Uranus';
// -----------------------------------------------------------------------------
  final dynamicLink = FirebaseDynamicLinks.instance;
// -----------------------------------------------------------------------------
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// -----------------------------------------------------------------------------
  Future<dynamic> createFlyerDynamicLink({
    @required BuildContext context,
    @required bool isShortURL,
    @required FlyerModel flyerModel,
    @required int slideIndex,
  }) async {

    final DynamicLinkParameters _parameters = DynamicLinkParameters(
      uriPrefix: 'https://bldrs.page.link',
      link: Uri.parse('https://bldrs.page.link/flyer/${flyerModel.flyerID}/$slideIndex'),
      androidParameters: AndroidParameters(
        packageName: 'com.bldrs.net',
        minimumVersion: 0,
        // fallbackUrl: null,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.bldrs.net',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: TextGenerator.flyerTypeSingleStringer(context, flyerModel.flyerType),
        description: flyerModel.slides[slideIndex].headline,
        imageUrl: Uri.parse(flyerModel.slides[slideIndex].pic),
      ),
    );

    Uri _url;

    /// if short link
    if (isShortURL) {
      final ShortDynamicLink shortLink = await _parameters.buildShortLink();
      print(shortLink.toString());
      _url = shortLink.shortUrl;

    }

    /// if long link
    else {
      _url = await _parameters.buildUrl();
    }

    return _url.toString();
  }
// -----------------------------------------------------------------------------
  Future<void> initializeDynamicLinks(BuildContext context) async {

    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    /// THIS WORKS WHEN APP IS DEAD
    if(deepLink != null){

      await goToFlyerScreenByDynamicLink(
        context: context,
        link: deepLink.toString(),
      );

    }

    /// THIS WORKS WHEN APP IN BACKGROUND
    dynamicLink.onLink(

        onSuccess: (PendingDynamicLinkData data) async {

          await goToFlyerScreenByDynamicLink(
            context: context,
            link: data.link.toString(),
          );

          },

        onError: (OnLinkErrorException error) async {

          print(error.message.toString());

          await CenterDialog.showCenterDialog(
            context: context,
            title: 'ERROR',
            body: 'THERE IS SOME ERROR : $error',
            boolDialog: false,
          );

        }

        );
  }
// -----------------------------------------------------------------------------
  static String getFlyerIDFromDynamicLink(String link){
    /// sample link
    /// https://bldrs.page.link/flyer/5FzRLxTgRekkRzKflsjs/0
    String _withoutIndex = TextMod.trimTextAfterLastSpecialCharacter(link, '/');
    String _flyerID = TextMod.trimTextBeforeLastSpecialCharacter(_withoutIndex, '/');
    return _flyerID;
  }
// -----------------------------------------------------------------------------
  static int getSlideIndexFromDynamicLink(String link){
    String indexString = TextMod.trimTextBeforeLastSpecialCharacter(link, '/');

    int _index = Numberers.stringToInt(indexString);

    if (_index == null){
      _index = 0;
    }

    return _index;
  }
// -----------------------------------------------------------------------------
  Future<void> goToFlyerScreenByDynamicLink({BuildContext context, String link}) async {

    String _flyerID = DynamicLinksApi.getFlyerIDFromDynamicLink(link);
    int _index = DynamicLinksApi.getSlideIndexFromDynamicLink(link);

    await Nav.goToNewScreen(
      context,
      FlyerScreen(
        flyerID: _flyerID,
        initialSlideIndex: _index,
      ),
    );

  }
// -----------------------------------------------------------------------------
  Future<String> createReferralLink(String referralCode) async {

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

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://bldrs.page.link',
      link: Uri.parse('https://bldrs.page.link/flyer'),
      androidParameters: AndroidParameters(
        packageName: 'com.bldrs.net',
        minimumVersion: 0,
        // fallbackUrl: null,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.bldrs.net',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Dynamic link title',
        description: 'Dynamic link description',
        imageUrl: Uri.parse(_uranus),
      ),
    );

    final ShortDynamicLink shortLink =
    await parameters.buildShortLink();

    final Uri dynamicUrl = shortLink.shortUrl;
    print(dynamicUrl);
    return dynamicUrl.toString();
  }
// -----------------------------------------------------------------------------
  void handleSuccessLinking(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      var isRefer = deepLink.pathSegments.contains('refer');
      if (isRefer) {
        var code = deepLink.queryParameters['code'];
        print(code.toString());
        if (code != null) {

          navigatorKey.currentState.pushNamed(Routez.DynamicLinkTest, arguments: code);

        }
      }
    }
  }
// -----------------------------------------------------------------------------
}


