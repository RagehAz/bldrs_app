import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class Launch{
// -----------------------------------------------------------------------------
  static Future<void> launchURL(String link) async {
    /// should make a condition
    /// if it starts with http:// or not
    /// then do whats necessary, as the link should include http://
    if (await canLaunch(link)) {
      await launch(link);
    }else{
      print('Can Not launch link');
    }
  }
// -----------------------------------------------------------------------------
  static Future<void> launchCall(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    }else{
      print('cant call');
    }
  }
// -----------------------------------------------------------------------------
  static Future<void> shareLink (BuildContext context, LinkModel link) async {
    final RenderBox _box = context.findRenderObject();
    // final String url = '${flyerLink.url} & ${flyerLink.description}';

    await Share.share(
      link.url,
      subject: link.description,
      sharePositionOrigin: _box.localToGlobal(Offset.zero) & _box.size,
    );
  }
// -----------------------------------------------------------------------------
// /// old method test
// void _onShare(BuildContext context) async {
//   // A builder is used to retrieve the context immediately
//   // surrounding the RaisedButton.
//   //
//   // The context's `findRenderObject` returns the first
//   // RenderObject in its descendant tree when it's not
//   // a RenderObjectWidget. The RaisedButton's RenderObject
//   // has its position and size after it's built.
//   final RenderBox box = context.findRenderObject();
//
//   List<String> imagePaths = <String>[Iconz.DumUniverse, Iconz.DumBusinessLogo];
//
//
//   if (imagePaths.isNotEmpty) {
//     await Share.shareFiles(imagePaths,
//         text: 'text',
//         subject: 'subject',
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//   } else {
//     await Share.share(
//         'text',
//         subject: 'subject',
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//   }
// }
// /// old method test
// // void _onShareWithEmptyOrigin(BuildContext context) async {
// //   await Share.share("text");
// // }
// -----------------------------------------------------------------------------

  static Future<void> shareFlyer (BuildContext context, LinkModel flyerLink) async {
    final RenderBox box = context.findRenderObject();

    await Share.share(
      flyerLink.url,
      subject: flyerLink.description,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );

  }

}

class LinkModel{
  final String url;
  final String description;

  const LinkModel({
    @required this.url,
    @required this.description,
  });

  Map<String, Object> toMap(){
    return {
      'url' : url,
      'description' : description,
    };
  }

// -----------------------------------------------------------------------------
  static const LinkModel bldrsWebSiteLink = const LinkModel(
    url: 'www.bldrs.net',
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
  static const LinkModel bldrsAppStoreLink = const LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
  static const LinkModel bldrsPlayStoreLink = const LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------


}


