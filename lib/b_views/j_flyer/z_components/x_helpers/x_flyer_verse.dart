import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

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
    return flyerShowsAuthor == true ? 1 : 2;
  }
  // --------------------
  static int bzLabelLocaleSize({
    required bool flyerShowsAuthor,
  }){
    return flyerShowsAuthor == true ? 1 : 1;
  }
  // --------------------
  static double bzLabelVersesScaleFactor({
    required BuildContext context,
    required double flyerBoxWidth,
  }){
    return flyerBoxWidth * 0.0021;
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
    required int? authorGalleryCount,
    required int bzGalleryCount,
    required bool showLabel,
  }){

      final String? _galleryCountCalibrated = getCounterCaliber(bzGalleryCount);

      final String _followersCounter =
          (authorGalleryCount == 0 && followersCount == 0)
          ||
          (authorGalleryCount == null && followersCount == null)
          ?
          ''
          :
          showLabel == true ?
          '${Numeric.formatNumToSeparatedKilos(number: authorGalleryCount)} '
          '${getWord('phid_flyers')}'
          :
          /// FIX_FOLLOWERS_NUMBERS
          // '${counterCaliber(followersCount)} '
          // '${word('phid_followers')} . '
          '$_galleryCountCalibrated '
          '${getWord('phid_flyers')}';

      return Verse(
        id: _followersCounter,
        translate: false,
      );

    }
  // --------------------
}
