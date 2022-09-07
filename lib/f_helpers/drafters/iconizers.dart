import 'dart:convert';
import 'dart:core';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Iconizer {
  // -----------------------------------------------------------------------------

  const Iconizer();

  // -----------------------------------------------------------------------------

  /// ARROW

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superArrowENRight(BuildContext context) {

    if (Words.textDirection(context) == 'ltr') {
      return Iconz.arrowRight;
    }

    else {
      return Iconz.arrowLeft;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String superArrowENLeft(BuildContext context) {

    if (Words.textDirection(context) == 'ltr') {
      return Iconz.arrowLeft;
    }

    else {
      return Iconz.arrowRight;
    }

  }
  // -----------------------------------------------------------------------------

  /// BACK ICON

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superBackIcon(BuildContext context) {
    return TextDir.appIsLeftToRight(context) ?
    Iconz.back
        :
    Iconz.backArabic;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String superInverseBackIcon(BuildContext context) {
    return TextDir.appIsLeftToRight(context) ?
    Iconz.backArabic
        :
    Iconz.back;
  }
  // -----------------------------------------------------------------------------

  /// SHARE ICON

  // --------------------
  static String shareAppIcon(){

    String _shareIcon = Iconz.share;

    if (DeviceChecker.deviceIsIOS() == true){
      _shareIcon = Iconz.comApple;
    }

    if (DeviceChecker.deviceIsAndroid() == true){
      _shareIcon = Iconz.comGooglePlay;
    }

    return _shareIcon;
  }
  // -----------------------------------------------------------------------------

  /// DIRECTORY - LOCAL ASSET PATH

  // --------------------
  static String imageDir({
    @required String prefix,
    @required String fileName,
    @required double pixelRatio,
    @required bool isIOS,
  }) {

    /// MediaQueryData data = MediaQuery.of(context);
    /// double ratio = data.devicePixelRatio;
    ///
    /// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    ///
    /// If the platform is not iOS, you would implement the buckets in your code. Combining the logic into one method:
    ///
    /// double markerScale;
    /// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    /// if (isIOS){markerScale = 0.7;}else{markerScale = 1;}

    String directory = '/';

    if (!isIOS) {
      if (pixelRatio >= 1.5) {
        directory = '/2.0x/';
      }

      else if (pixelRatio >= 2.5) {
        directory = '/3.0x/';
      }

      else if (pixelRatio >= 3.5) {
        directory = '/4.0x/';
      }

    }

    return '$prefix$directory$fileName';
  }
  // --------------------
  static Future<List<String>> getLocalAssetsPaths() async {

    final String assets = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> _json = json.decode(assets);
    final List<String> _keys = _json.keys.where((element) => element.startsWith('assets/')).toList();

    final List<String> _allAssetsPaths = <String>[];
    for (final String key in _keys){
      _allAssetsPaths.add(_json[key].first);
    }

    return _allAssetsPaths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getLocalAssetPathFromLocalPaths({
    @required List<String> allAssetsPaths,
    @required String assetName,
  }){

    final List<String> _assetPath = ChainPathConverter.findPathsContainingPhid(
      paths: allAssetsPaths,
      phid: assetName,
    );

    final String _path = _assetPath.isNotEmpty ? _assetPath?.first : null;

    return _path;
  }
  // -----------------------------------------------------------------------------
}
