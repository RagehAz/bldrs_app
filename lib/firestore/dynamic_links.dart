import 'package:bldrs/controllers/router/route_names.dart';
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
  Future<void> xxxHandleDynamicLink() async {

    await dynamicLink.getInitialLink();

    dynamicLink.onLink(

        onSuccess: (PendingDynamicLinkData data) async {
          _xxxHandleSuccessLinking(data);
          },

        onError: (OnLinkErrorException error) async {
          print(error.message.toString());
        });
  }
// -----------------------------------------------------------------------------
  Future<String> xxxCreateReferralLink(String referralCode) async {

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
  void _xxxHandleSuccessLinking(PendingDynamicLinkData data) {
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
  Future<dynamic> createDynamicLink(BuildContext context, bool short) async {

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

    Uri _url;

    /// if short link
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      print(shortLink.toString());
      _url = shortLink.shortUrl;

    }

    /// if long link
    else {
      _url = await parameters.buildUrl();
    }

    return _url.toString();
  }
// -----------------------------------------------------------------------------
  void receiveAndInitializeDynamicLinks () async {

    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null){

      /// according to deepLink value, we will see where to navigate to

      // Navigator.pushNamed(context, deepLink.path);

    }

  }
// -----------------------------------------------------------------------------
}


