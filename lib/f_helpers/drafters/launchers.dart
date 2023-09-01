import 'dart:async';
import 'dart:io';

import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as Launch;
/// => TAMAM
class Launcher {
  // -----------------------------------------------------------------------------

  const Launcher();
  // -----------------------------------------------------------------------------

  /// CLEANUPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cleanURL(String? link){
    String? _output;

    if (TextCheck.isEmpty(link) == false) {

      /// LINK SHOULD CONTAIN 'http://' to work
      final bool _containsHttp = TextCheck.stringContainsSubString(
        string: link,
        subString: 'http://',
      );

      final bool _containsHttps = TextCheck.stringContainsSubString(
        string: link,
        subString: 'https://',
      );

      if (_containsHttp == true || _containsHttps == true) {
        _output = link!;
      }
      else {
        _output = 'http://$link';
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uri? getURIFromLink(String? link){
    Uri? _output;

    final String? _link = cleanURL(link);

    if (_link != null) {
      _output = Uri.parse(_link);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Rect _getShareRect(){
    final RenderBox? _box = getMainContext().findRenderObject() as RenderBox;
    return _box!.localToGlobal(Offset.zero) & _box.size;
  }
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
        await launchURL(contact.value);
      }
      /// EMAIL
      else if (contact.type == ContactType.email){
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

    bool _success = false;


    if (link != null){

      final Uri _uri = Uri.parse(cleanURL(link) ?? '');

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> shareURL({
    required String? url,
    required String? subject,
  }) async {
    bool _success = false;

    final String? _url = cleanURL(url);

    if (_url != null){

      if (DeviceChecker.deviceIsWindows() == false){

        final ShareResult _result = await Share.shareWithResult(
          _url,
          subject: subject,
          sharePositionOrigin: _getShareRect(),
        );

        if (_result.status == ShareResultStatus.success){
          _success = true;
        }

        // blogShareResult(_result);
        // ShareResultStatus.dismissed;
        // ShareResultStatus.success;
        // ShareResultStatus.unavailable;

      }
      else {
        blog('cant share on windows');
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
    return ''; //word('phid_bldrs');
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

  /// LAUNCH APP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> launchStoreApp({
    required String? iosAppID,
    required String? androidPackageID,
    String? webSite,
  }) async {

    if (DeviceChecker.deviceIsAndroid() == true){
      await _launchGooglePlay(androidPackageID: androidPackageID);
    }

    else if (DeviceChecker.deviceIsIOS() == true){
      await _launchAppleAppStore(iosAppID: iosAppID);
    }
    else if (TextCheck.isEmpty(webSite) == false){
      await launchURL(webSite);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _launchGooglePlay({
    required String? androidPackageID,
  }) async {

    if (TextCheck.isEmpty(androidPackageID) == false){

      final Uri uri = Uri.parse('market://details?id=$androidPackageID');

      if (await Launch.canLaunchUrl(uri) == true) {
        await Launch.launchUrl(
          uri,
          mode: Launch.LaunchMode.externalApplication,
        );
      }

      else {
        blog('cant launch google play store');
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _launchAppleAppStore({
    required String? iosAppID,
  }) async {

    if (TextCheck.isEmpty(iosAppID) == false){

      final Uri uri = Uri.parse('https://apps.apple.com/app/id$iosAppID');

      if (await Launch.canLaunchUrl(uri) == true) {
        await Launch.launchUrl(
          uri,
          mode: Launch.LaunchMode.externalApplication,
        );
      }

      else {
        blog('cant launch apple app store');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// FILE SHARING

  // --------------------
  /// TASK : TEST ME
  static Future<void> shareFile({
    required File? file,
    required String? subject,
  }) async {

    if (file == null){

    }

    else {
      final XFile _xFile = XFile(file.path);
      final RenderBox? _box = getMainContext().findRenderObject() as RenderBox;
      final ShareResult _result = await Share.shareXFiles(
        <XFile>[_xFile],
        subject: subject,
        sharePositionOrigin: _box!.localToGlobal(Offset.zero) & _box.size,
      );

      blogShareResult(_result);


    }


  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  static void blogShareResult(ShareResult result){
    blog('share status : ${result.status} : raw : ${result.raw}');
  }
  // -----------------------------------------------------------------------------

  /// BLDRS SPECIFIC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> shareBldrsWebsiteURL() async {

    await shareURL(
      url: Standards.bldrsWebSiteURL,
      subject: getWord('phid_bldrsTagLine'),
    );

  }
  // --------------------
  /// TESTED: WORKS PERFECT (EXCEPT FOR IOS STILL NOT TESTED)
  static Future<void> launchBldrsAppLinkOnStore() async {

    await Launcher.launchStoreApp(
      iosAppID: BldrsKeys.appStoreID,
      androidPackageID: BldrsKeys.androidPackageID,
      webSite: Standards.bldrsWebSiteURL,
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
