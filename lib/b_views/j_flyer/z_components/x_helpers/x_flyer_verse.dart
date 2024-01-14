import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class FlyerVerses {
  /// --------------------------------------------------------------------------

  const FlyerVerses();

  /// --------------------------------------------------------------------------
  static Verse generateFooterButtonVerse({
    required BuildContext context,
    required String phid,
    required int? count,
    required bool isOn,
  }){

    Verse _output = Verse(
      id: phid,
      translate: true,
    );

    final int _count = count ?? 0;
    if (_count >= 1000){
      _output = Verse(
        id: getCounterCaliber(_count),
        translate: false,
      );
    }

    if (isOn == true){
      _output = Verse(
        id: phid,
        translate: true,
        casing: Casing.upperCase,
      );
    }

    // blog('generateButtonText : $_output : _count : $_count');

    return _output;
  }
  // -----------------------------------------------------------------------------
  static int bzLabelNameSize({
    required bool flyerShowsAuthor,
  }){
    return flyerShowsAuthor == true ? 3 : 4;
  }
  // --------------------
  static int bzLabelNameMaxLines({
    required bool flyerShowsAuthor,
  }){
    return flyerShowsAuthor == true ? 1 : 1;
  }
  // --------------------
  static int bzLabelLocaleSize({
    required bool flyerShowsAuthor,
  }){
    return flyerShowsAuthor == true ? 1 : 2;
  }
  // --------------------
  static double bzLabelVersesScaleFactor({
    required bool flyerShowsAuthor,
    required double flyerBoxWidth,
  }){

    if (flyerShowsAuthor == true){
      return flyerBoxWidth * 0.002;
    }
    else {
      return flyerBoxWidth * 0.0025;
    }

  }
  // --------------------
  static double authorLabelVersesScaleFactor({
    required double flyerBoxWidth,
  }){
   return flyerBoxWidth * 0.0025;
  }
  // --------------------
  static Verse followersCounters({
    required int? followersCount,
    required int? flyersCount,
  }){

    String _followsLine = '';
    String _flyersLine = '';
    String _dot = '';

    if (followersCount != null && followersCount > 0){
      _followsLine = '${getCounterCaliber(followersCount)} ${getWord('phid_followers')}';
    }

    if (flyersCount != null && flyersCount > 0){
      _flyersLine = '${getCounterCaliber(flyersCount)} ${getWord('phid_flyers')}';
    }

    if (_followsLine != '' && _flyersLine != ''){
      _dot = ' . ';
    }

    return Verse(
      id: '$_followsLine$_dot$_flyersLine',
      translate: false,
    );

  }
  // --------------------
}
