import 'dart:core';

import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class Iconizer {
  // -----------------------------------------------------------------------------

  const Iconizer();

  // -----------------------------------------------------------------------------

  /// ARROW

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superArrowENRight(BuildContext context) {

    if (Localizer.textDirection() == 'ltr') {
      return Iconz.arrowRight;
    }

    else {
      return Iconz.arrowLeft;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String superArrowENLeft(BuildContext context) {

    if (Localizer.textDirection() == 'ltr') {
      return Iconz.arrowLeft;
    }

    else {
      return Iconz.arrowRight;
    }

  }
  // -----------------------------------------------------------------------------

  /// COLORED ARROW

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superYellowArrowENRight(BuildContext context) {

    if (Localizer.textDirection() == 'ltr') {
      return Iconz.arrowYellowRight;
    }

    else {
      return Iconz.arrowYellowLeft;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String superYellowArrowENLeft(BuildContext context) {

    if (Localizer.textDirection() == 'ltr') {
      return Iconz.arrowYellowLeft;
    }

    else {
      return Iconz.arrowYellowRight;
    }

  }
  // -----------------------------------------------------------------------------

  /// BACK ICON

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superBackIcon(BuildContext context) {
    return UiProvider.checkAppIsLeftToRight() ?
    Iconz.back
        :
    Iconz.backArabic;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String superInverseBackIcon(BuildContext context) {
    return UiProvider.checkAppIsLeftToRight() ?
    Iconz.backArabic
        :
    Iconz.back;
  }
  // -----------------------------------------------------------------------------

  /// SHARE ICON

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /*
  ///
  static String imageDir({
    required String prefix,
    required String fileName,
    required double pixelRatio,
    required bool isIOS,
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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getLocalAssetsPaths() async {
    final List<String> _allAssetsPaths = <String>[];

    final Map<String, dynamic>? _json = await Filers.readLocalJSON(
        path: 'AssetManifest.json',
    );

    if (_json != null){

      final List<String> _keys = _json.keys.toList();

      if (Mapper.checkCanLoopList(_keys) == true){
        for (final String key in _keys){
          _allAssetsPaths.add(_json[key].first);
        }
      }

    }

    return _allAssetsPaths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getLocalAssetPathFromLocalPaths({
    required List<String> allAssetsPaths,
    required String? assetName,
  }){

    final List<String> _assetPath = ChainPathConverter.findPathsContainingPhid(
      paths: allAssetsPaths,
      phid: assetName,
    );

    return _assetPath.isNotEmpty ? _assetPath.first : null;
  }
  // -----------------------------------------------------------------------------
}
