import 'dart:async';

import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:stringer/stringer.dart';
import 'package:url_launcher/url_launcher.dart' as Launch;
/// => TAMAM
class Launcher {
  // -----------------------------------------------------------------------------

  const Launcher();

  // -----------------------------------------------------------------------------

  /// JOKER

  // --------------------
  /// TESTED : WORKS PERFECT
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
        await launchURL(contact.value);
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
  // -----------------------------------------------------------------------------

  /// LAUNCH URL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> launchURL(String link) async {

    Uri _uri;
    bool _success = false;

    if (TextCheck.isEmpty(link) == false){

      /// LINK SHOULD CONTAIN 'http://' to work
      final bool _containsHttp = TextCheck.stringContainsSubString(
        string: link,
        subString: 'http://',
      );

      final bool _containsHttps = TextCheck.stringContainsSubString(
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
  // -----------------------------------------------------------------------------

  /// LAUNCH EMAIL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _launchEmail({
    @required BuildContext context,
    @required String email,
    String emailSubject,
    String emailBody,
  }) async {

    if (TextCheck.isEmpty(email) == false){

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

        await Keyboard.copyToClipboard(
          context: context,
          copy: email,
          milliseconds: 3000,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _generateDefaultEmailSubject(BuildContext context){
    return ''; //xPhrase( context, 'phid_bldrs');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _generateDefaultEmailBody(BuildContext context){
    return '';
  }
  // -----------------------------------------------------------------------------

  /// LAUNCH CALL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _launchCall(String phoneNumber) async {

    if (TextCheck.isEmpty(phoneNumber) == false){

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
  // -----------------------------------------------------------------------------

  /// SHARING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> shareURL({
    @required BuildContext context,
    @required String url,
    @required String subject,
  }) async {

    if (url != null && subject != null){

      final RenderBox _box = context.findRenderObject();
      // final String url = '${flyerLink.url} & ${flyerLink.description}';

      await Share.share(
        url,
        subject: subject,
        sharePositionOrigin: _box.localToGlobal(Offset.zero) & _box.size,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> shareBldrsWebsiteURL({
    @required BuildContext context,
  }) async {

    final String _tagLine = await PhraseProtocols.translate(
        langCode: Localizer.getCurrentLangCode(context),
        phid: 'phid_bldrsTagLine',
    );

    await shareURL(
      context: context,
      url: Standards.bldrsWebSiteURL,
      subject: _tagLine,
    );

  }
  // -----------------------------------------------------------------------------
}
