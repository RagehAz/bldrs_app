import 'dart:async';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart' as Launch;

class Launcher {
// --------------------------------------------------------------------------

  const Launcher();

// --------------------------------------------------------------------------

  /// LAUNCH URL

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> launchURL(String link) async {

    Uri _uri;
    bool _success = false;

    /// LINK SHOULD CONTAIN 'http://' to work
    final bool _containsHttp = TextChecker.stringContainsSubString(
      string: link,
      subString: 'http://',
    );

    if (_containsHttp == true){
      _uri = Uri.parse(link);
    }
    else {
      _uri = Uri.parse('http://$link');
    }

    if (await Launch.canLaunchUrl(_uri) == true) {

      unawaited(Launch.launchUrl(_uri));
      _success = true;
    }
    else {
      blog('Can Not launch link');
    }

    return _success;
  }
// --------------------------------------------------------------------------

  /// LAUNCH CALL

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> launchCall(String phoneNumber) async {

    final Uri _uri = Uri(
      path: phoneNumber,
      scheme: 'tel',
    );

    if (await Launch.canLaunchUrl(_uri) == true) {
      await Launch.launchUrl(_uri);
    }

    else {
      blog('cant call');
    }
  }
// --------------------------------------------------------------------------

  /// SHARING

// ----------------------------------------
  static Future<void> shareLink({
    @required BuildContext context,
    @required LinkModel link,
  }) async {

    final RenderBox _box = context.findRenderObject();
    // final String url = '${flyerLink.url} & ${flyerLink.description}';

    await Share.share(
      link.url,
      subject: link.description,
      sharePositionOrigin: _box.localToGlobal(Offset.zero) & _box.size,
    );

  }
// ----------------------------------------
  static Future<void> shareFlyer({
    @required BuildContext context,
    @required LinkModel flyerLink,
  }) async {

    final RenderBox box = context.findRenderObject();

    await Share.share(
      flyerLink.url,
      subject: flyerLink.description,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );

  }
// --------------------------------------------------------------------------
/*
// --------------------------------------------------------------------------
/// old method test
void _onShare(BuildContext context) async {
  // A builder is used to retrieve the context immediately
  // surrounding the RaisedButton.
  //
  // The context's `findRenderObject` returns the first
  // RenderObject in its descendant tree when it's not
  // a RenderObjectWidget. The RaisedButton's RenderObject
  // has its position and size after it's built.
  final RenderBox box = context.findRenderObject();

  List<String> imagePaths = <String>[Iconz.DumUniverse, Iconz.DumBusinessLogo];


  if (imagePaths.isNotEmpty) {
    await Share.shareFiles(imagePaths,
        text: 'text',
        subject: 'subject',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  } else {
    await Share.share(
        'text',
        subject: 'subject',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
/// old method test
// void _onShareWithEmptyOrigin(BuildContext context) async {
//   await Share.share("text");
// }
// --------------------------------------------------------------------------
 */
// --------------------------------------------------------------------------
}
