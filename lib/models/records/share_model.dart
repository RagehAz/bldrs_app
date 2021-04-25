import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// ---------------------------------------------------------------------------
class ShareModel{
  final List<dynamic> slideIndexes;
  final List<DateTime> timeStamps;
  // final String sharedTo;

  ShareModel({
  this.slideIndexes,
  this.timeStamps,
  // this.sharedTo,
  });
// ---------------------------------------------------------------------------
  Map<String, Object> toMap(){
    return {
      'slideIndexes' : slideIndexes,
      'timeStamps' : cipherListOfDateTimes(timeStamps),
    };
  }
// ---------------------------------------------------------------------------
  static ShareModel decipherShareMap(Map<String, dynamic> map){
    return ShareModel(
      slideIndexes: map['slideIndexes'],
      timeStamps: decipherListOfDateTimesStrings(map['timeStamps']),
    );
}
// ---------------------------------------------------------------------------
  static ShareModel addToShareModel(ShareModel existingShareModel, int slideIndex){
    /// --- IF FLYER WAS NEVER SHARED
  if (existingShareModel == null){

    return ShareModel(
      slideIndexes: [slideIndex],
      timeStamps: [DateTime.now()],
    );

  } else {
  /// --- IF FLYER WAS SHARED BEFORE
    return
        ShareModel(
          slideIndexes: <int>[...existingShareModel.slideIndexes, slideIndex],
          timeStamps: <DateTime>[...existingShareModel.timeStamps, DateTime.now()]
        );
  }
}
// ---------------------------------------------------------------------------
  static Future<void> shareFlyer (BuildContext context, LinkModel flyerLink) async {
    final RenderBox box = context.findRenderObject();
    final String text = '${flyerLink.url} & ${flyerLink.description}';

    await Share.share(
      text,
      subject: flyerLink.description,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );


  }
// ----------------------------------------------------------------------------

}
// ---------------------------------------------------------------------------
class LinkModel{
  final String url;
  final String description;

  LinkModel({
    @required this.url,
    @required this.description,
  });

  Map<String, Object> toMap(){
    return {
      'url' : url,
      'description' : description,
    };
  }

  // ---------------------------------------------------------------------------
  static LinkModel bldrsWebSiteLink = LinkModel(
    url: 'www.bldrs.net',
    description: 'Download Bldrs.net App',
  );
// ---------------------------------------------------------------------------
  static LinkModel bldrsAppStoreLink = LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// ---------------------------------------------------------------------------
  static LinkModel bldrsPlayStoreLink = LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// ---------------------------------------------------------------------------


}
// ---------------------------------------------------------------------------
final String _ragehURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/usersPics%2FrBjNU5WybKgJXaiBnlcBnfFaQSq1.jpg?alt=media&token=9a9db754-7d0c-40f8-b285-1df5e660c282';
// ---------------------------------------------------------------------------
Future<void> createDynamicLink(BuildContext context, bool short) async {

  // setState((){
  //   _isCreatingLink = true;
  // });

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
      imageUrl: Uri.parse(_ragehURL),
    ),
  );

  Uri url;
  if(short){
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    print(shortLink.toString());
    url = shortLink.shortUrl;
  } else {
    url = await parameters.buildUrl();
  }

  // setState((){
  //   _linkMessage = url.toString();
  //   _isCreatingLink = false;
  // });

}

void receiveAndInitializeDynamicLinks () async {

  final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri deepLink = data?.link;

  if (deepLink != null){

    /// according to deepLink value, we will see where to navigate to

    // Navigator.pushNamed(context, deepLink.path);

  }

}