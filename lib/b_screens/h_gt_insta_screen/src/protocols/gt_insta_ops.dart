
import 'dart:convert';

import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/rest/rest.dart';
import 'package:basics/helpers/strings/linker.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:http/http.dart';

class GtInstaOps {
  // --------------------------------------------------------------------------

  const GtInstaOps();

  // --------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goGetToken() async {

    // https://www.facebook.com/v19.0/dialog/oauth?
    // client_id={app-id}
    // &redirect_uri={redirect-uri}
    // &state={state-param}
    final Uri uri = Uri(
      scheme: 'https',
      host: 'www.facebook.com',
      path: 'v19.0/dialog/oauth',
      queryParameters: <String, String>{
        'client_id': BldrsKeys.socialKeys.facebookAppID!,
        'redirect_uri': 'https://bldrs.net/redirect',
        'config_id': '925142852526513',
        'response_type': 'token',
      },
    );

    await Launcher.launchURI(uri);

  }
  // --------------------------------------------------------------------------

  /// SCRAPPING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> scrapProfile({
    required String? instagramProfileName,
    required String? facebookAccessToken,
  }) async {
    Map<String, dynamic>? _output;

    final String? _name = extractProfileName(
      urlOrName: instagramProfileName,
    );

    blog('scrapProfile : name : $_name');

    if (
    TextCheck.isEmpty(_name) == false
    &&
    TextCheck.isEmpty(facebookAccessToken) == false
    ){

      final String _script =
'''
business_discovery.username($_name) {
profile_picture_url,
ig_id,
followers_count,
name,
biography,
website,
media {
  media_url,children{media_url}
 }
}''';

      final Uri uri = Uri(
        scheme: 'https',
        host: 'graph.facebook.com',
        path: 'v16.0/17841447816479749',
        queryParameters: <String, String>{
          'fields': _script,
          'access_token': facebookAccessToken!,
        },
      );

      final Response? response = await Rest.get(
          rawLink: uri.toString(),
          invoker: 'GtInstaOps.scrapProfile',
      );

      if (response != null){
        final Map<String, dynamic>? _map = jsonDecode(response.body);
        _output = Mapper.cloneMap(_map);
      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// LINK CLEANING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? extractProfileName({
    required String? urlOrName,
  }){
    String? _name;

    if (TextCheck.isEmpty(urlOrName) == false){

      final bool _isURL = ObjectCheck.isAbsoluteURL(urlOrName);
      if (_isURL == true){
        final String? _domain = Linker.extractWebsiteDomain(link: urlOrName);
        if (_domain == 'instagram.com'){
          _name = TextMod.removeTextBeforeFirstSpecialCharacter(text: urlOrName?.trim(), specialCharacter: 'm');
          _name = TextMod.removeTextBeforeFirstSpecialCharacter(text: _name, specialCharacter: 'm');
          _name = TextMod.removeTextBeforeFirstSpecialCharacter(text: _name, specialCharacter: '/');
          _name = TextMod.removeTextAfterFirstSpecialCharacter(text: _name, specialCharacter: '?');
        }

      }
      else {
        _name = urlOrName?.trim();
      }

    }

    return _name;
  }
  // --------------------------------------------------------------------------
}
