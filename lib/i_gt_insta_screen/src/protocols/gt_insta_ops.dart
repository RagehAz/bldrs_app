import 'dart:convert';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/rest/rest.dart';
import 'package:basics/helpers/strings/linker.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:http/http.dart';
/// => TAMAM
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
  static Future<Map<String, dynamic>?> scrapProfileByURL({
    required String? url,
    required String? facebookAccessToken,
    String? startAfterCursor,
    String? startBeforeCursor,
    int? limit,
  }) async {

    final String? _name = extractProfileName(
      urlOrName: Linker.cleanURL(url),
    );

    return scrapProfileByProfileName(
      facebookAccessToken: facebookAccessToken,
      profileName: _name,
      startAfterCursor: startAfterCursor,
      startBeforeCursor: startBeforeCursor,
      limit: limit,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> scrapProfileByProfileName({
    required String? profileName,
    required String? facebookAccessToken,
    String? startAfterCursor,
    String? startBeforeCursor,
    int? limit,
  }) async {
    Map<String, dynamic>? _output;

    if (
        TextCheck.isEmpty(profileName) == false
        &&
        TextCheck.isEmpty(facebookAccessToken) == false
    ){

      // TO EXPLORE FIELDS
      /// https://developers.facebook.com/tools/explorer/427786221866015/?method=GET&path=me%2Faccounts&version=v19.0

      final String theLimit = limit == null ? '' : '.limit($limit)';
      final String startAfter = startAfterCursor == null ? '' : '.after($startAfterCursor)';
      final String startBefore= startBeforeCursor == null ? '' : '.before($startBeforeCursor)';

      final String _script =
      '''
business_discovery.username($profileName) {
profile_picture_url,
id,
followers_count,
name,
biography,
website,
media$startBefore$startAfter$theLimit {
  media_url,
  caption,
  media_type,
  media_product_type,
  permalink,
  thumbnail_url,
  children{media_url}
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
        await tryAndCatch(
            invoker: 'scrapProfileByProfileName',
            functions: () async {
              final Map<String, dynamic>? _map = jsonDecode(response.body);
              _output = Mapper.cloneMap(_map);
            }
            );
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

    return Linker.removeExtraSlashAtTheEndIfExisted(_name);
  }
  // --------------------------------------------------------------------------
}
