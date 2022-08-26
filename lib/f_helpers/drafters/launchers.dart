import 'dart:async';

import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart' as Launch;

class Launcher {
// --------------------------------------------------------------------------

  const Launcher();

// --------------------------------------------------------------------------

  /// JOKER

// ----------------------------------------
  static Future<void> launchContactModel({
    @required BuildContext context,
    @required ContactModel contact,
  }) async {

    if (contact != null){

      /// PHONE
      if (contact.type == ContactType.phone){
        await _launchCall(contact.value);
      }
      /// WEB LINK
      else if (ContactModel.checkIsWebLink(contact.type) == true){
        await _launchURL(contact.value);
      }
      /// EMAIL
      else if (contact.type == ContactType.email){
        await _launchEmail(
          context: context,
          email: contact.value,
          // emailBody: '',
          // emailSubject: '',
        );
      }
      /// OBLIVION
      else {
        blog('will do nothing for this ${contact.type}');
      }

    }

  }
// --------------------------------------------------------------------------

  /// LAUNCH URL

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _launchURL(String link) async {

    Uri _uri;
    bool _success = false;

    if (Stringer.checkStringIsEmpty(link) == false){

      /// LINK SHOULD CONTAIN 'http://' to work
      final bool _containsHttp = TextChecker.stringContainsSubString(
        string: link,
        subString: 'http://',
      );

      final bool _containsHttps = TextChecker.stringContainsSubString(
        string: link,
        subString: 'https://',
      );

      if (_containsHttp == true || _containsHttps == true){
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

    }

    return _success;
  }
// --------------------------------------------------------------------------

  /// LAUNCH EMAIL

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _launchEmail({
    @required BuildContext context,
    @required String email,
    String emailSubject,
    String emailBody,
  }) async {

    if (Stringer.checkStringIsEmpty(email) == false){

      final String _emailSubject = emailSubject ?? _generateDefaultEmailSubject(context);
      final String _emailBody = emailBody ?? _generateDefaultEmailBody(context);

      final Uri _uri = Uri(
        scheme: 'mailto',
        path: email,
        query: 'subject=$_emailSubject&body=$_emailBody',
      );

      if (await Launch.canLaunchUrl(_uri) == true) {
        await Launch.launchUrl(_uri);
      }

      else {
        blog('cant launch email');
      }

    }

  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static String _generateDefaultEmailSubject(BuildContext context){
    return ''; //xPhrase( context, 'phid_bldrs');
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static String _generateDefaultEmailBody(BuildContext context){
    return '';
  }
// --------------------------------------------------------------------------

  /// LAUNCH CALL

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _launchCall(String phoneNumber) async {

    if (Stringer.checkStringIsEmpty(phoneNumber) == false){

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

  }
// --------------------------------------------------------------------------

  /// SHARING

// ----------------------------------------
  static Future<void> shareLink({
    @required BuildContext context,
    @required LinkModel link,
  }) async {

    if (link != null && link.url != null){

      final RenderBox _box = context.findRenderObject();
      // final String url = '${flyerLink.url} & ${flyerLink.description}';

      await Share.share(
        link.url,
        subject: link?.description,
        sharePositionOrigin: _box.localToGlobal(Offset.zero) & _box.size,
      );

    }

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
