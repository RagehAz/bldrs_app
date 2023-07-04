import 'dart:async';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
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
    required ContactModel? contact,
  }) async {

    if (contact != null){

      /// PHONE
      if (contact.type == ContactType.phone){
        await _launchCall(contact.value);
      }
      /// WEB LINK
      else if (ContactModel.checkIsWebLink(contact.type) == true){
        blog('AuthorCard._onContactTap: contactModel WEB LINK: $contact.value');
        await launchURL(contact.value);
      }
      /// EMAIL
      else if (contact.type == ContactType.email){
        blog('AuthorCard._onContactTap: contactModel EMAIL: $contact.value');
        await _launchEmail(
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
  static Future<bool> launchURL(String? link) async {

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
        _uri = Uri.parse(link!);
      }
      else {
        _uri = Uri.parse('http://$link');
      }

      if (await Launch.canLaunchUrl(_uri) == true) {

        unawaited(Launch.launchUrl(
          _uri,
          // mode: LaunchMode.inAppWebView,
          // webOnlyWindowName: ,
          // webViewConfiguration: ,
        ));
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
    required String? email,
    String? emailSubject,
    String? emailBody,
  }) async {

    /// MORE REF : https://www.youtube.com/watch?v=R6mA6_GRMZQ&t=42s


    if (TextCheck.isEmpty(email) == false){

      final String _emailSubject = emailSubject ?? _generateDefaultEmailSubject();
      final String _emailBody = emailBody ?? _generateDefaultEmailBody();

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

        await Keyboard.copyToClipboardAndNotify(
          copy: email,
          milliseconds: 3000,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _generateDefaultEmailSubject(){
    return ''; //xPhrase('phid_bldrs');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _generateDefaultEmailBody(){
    return '';
  }
  // -----------------------------------------------------------------------------

  /// LAUNCH CALL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _launchCall(String? phoneNumber) async {

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
  // --------------------
  /// NOT TESTED
  static Future<void> launchSMS(String? phoneNumber) async {

    if (TextCheck.isEmpty(phoneNumber) == false){

      final Uri _uri = Uri(
        path: phoneNumber,
        scheme: 'sms',
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
    required String? url,
    required String? subject,
  }) async {

    if (url != null && subject != null){

      if (DeviceChecker.deviceIsWindows() == false){
        final RenderBox? _box = getMainContext().findRenderObject() as RenderBox;
        // final String url = '${flyerLink.url} & ${flyerLink.description}';
        await Share.share(
          url,
          subject: subject,
          sharePositionOrigin: _box!.localToGlobal(Offset.zero) & _box.size,
        );
      }
      else {
        blog('cant share on windows');
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> shareBldrsWebsiteURL() async {

    final String? _tagLine = await PhraseProtocols.translate(
        langCode: Localizer.getCurrentLangCode(),
        phid: 'phid_bldrsTagLine',
    );

    await shareURL(
      url: Standards.bldrsWebSiteURL,
      subject: _tagLine,
    );

  }
  // -----------------------------------------------------------------------------



  //
  // static Future<bool> launchSocial(String? link) async {
  //
  //   Uri _uri;
  //   bool _success = false;
  //
  //   if (TextCheck.isEmpty(link) == false){
  //
  //     /// LINK SHOULD CONTAIN 'http://' to work
  //     final bool _containsHttp = TextCheck.stringContainsSubString(
  //       string: link,
  //       subString: 'http://',
  //     );
  //
  //     final bool _containsHttps = TextCheck.stringContainsSubString(
  //       string: link,
  //       subString: 'https://',
  //     );
  //
  //     if (_containsHttp == true || _containsHttps == true){
  //       _uri = Uri.parse(link!);
  //     }
  //     else {
  //       _uri = Uri.parse('http://$link');
  //     }
  //
  //     final bool _canLaunch = await Launch.canLaunchUrl(_uri);
  //
  //     if (_canLaunch == true) {
  //
  //       /// WEB
  //       if (kIsWeb == true) {
  //         unawaited(Launch.launchUrl(
  //           _uri,
  //           // mode: LaunchMode.inAppWebView,
  //           // webOnlyWindowName: ,
  //           // webViewConfiguration: ,
  //         ));
  //         _success = true;
  //       }
  //
  //       else if (DeviceChecker.deviceIsAndroid() == true) {
  //         final bool _isFacebookLink = TextCheck.stringStartsExactlyWith(
  //           text: _uri.path,
  //           startsWith: "https://www.facebook.com/",
  //         );
  //
  //         if (_isFacebookLink == true) {
  //           final url2 = 'fb://facewebmodal/f?href=$_isFacebookLink';
  //           final intent2 = AndroidIntent(action: "action_view", data: url2);
  //           final canWork = await intent2.canResolveActivity();
  //           if (canWork == true){
  //             intent2.launch();
  //           }
  //         }
  //         final intent = AndroidIntent(action: "action_view", data: url);
  //         return intent.launch();
  //       }
  //
  //       else {
  //         if (_canLaunch) {
  //           await launch(url, forceSafariVC: false);
  //         } else {
  //           throw "Could not launch $url";
  //         }
  //       }
  //
  //
  //   }
  //
  //     }
  //     else {
  //       blog('Can Not launch link');
  //     }
  //
  //   }
  //
  //   return _success;
  // }
  //


//
// Future<void> _launchSocialMediaAppIfInstalled({
//   String url,
// }) async {
//   try {
//     bool launched = await launch(url, forceSafariVC: false); // Launch the app if installed!
//
//     if (!launched) {
//       launch(url); // Launch web view if app is not installed!
//     }
//   } catch (e) {
//     launch(url); // Launch web view if app is not installed!
//   }
// }
// And then simply call it like this:
//
// _launchSocialMediaAppIfInstalled(
//   url: 'https://www.instagram.com/avey.world/', //Instagram
// );
//
// _launchSocialMediaAppIfInstalled(
//   url: 'https://www.facebook.com/avey.pal/', // Facebook
// );
//
// _launchSocialMediaAppIfInstalled(
//   url: 'https://twitter.com/avey_pal', // Twitter
// );
//
// _launchSocialMediaAppIfInstalled(
//   url: 'https://www.linkedin.com/company/avey-ai/', // Linkedin
// );
//
// ...
// Don't forget to replace the example page by yours ;) and that's it!

}
