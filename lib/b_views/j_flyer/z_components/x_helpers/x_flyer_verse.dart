import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:flutter/material.dart';

class FlyerVerses {
  /// --------------------------------------------------------------------------

  const FlyerVerses();

  /// --------------------------------------------------------------------------
  static Verse generateFooterButtonVerse({
    @required BuildContext context,
    @required String phid,
    @required int count,
    @required bool isOn,
  }){

    Verse _output = Verse(
      text: phid,
      translate: true,
    );

    final int _count = count ?? 0;
    if (_count >= 1000){
      _output = Verse(
        text: counterCaliber(context, _count),
        translate: false,
      );
    }

    if (isOn == true){
      _output = Verse(
        text: phid,
        translate: true,
        casing: Casing.upperCase,
      );
    }

    // blog('generateButtonText : $_output : _count : $_count');

    return _output;
  }
  // -----------------------------------------------------------------------------
  static int bzLabelNameSize({
    @required bool flyerShowsAuthor,
  }){
    return flyerShowsAuthor == true ? 3 : 4;
  }
  // --------------------
  static int bzLabelNameMaxLines({
    @required bool flyerShowsAuthor,
  }){
    return flyerShowsAuthor == true ? 1 : 2;
  }
  // --------------------
  static int bzLabelLocaleSize({
    @required bool flyerShowsAuthor,
  }){
    return flyerShowsAuthor == true ? 1 : 1;
  }
  // --------------------
  static double bzLabelVersesScaleFactor({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return flyerBoxWidth * 0.0021;
  }
  // --------------------
  static double authorLabelVersesScaleFactor({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
   return flyerBoxWidth / Scale.screenWidth(context);
  }
  // --------------------
  static Verse followersCounters({
    @required BuildContext context,
    @required int followersCount,
    @required int authorGalleryCount,
    @required int bzGalleryCount,
    @required bool showLabel,
  }){

      final String _galleryCountCalibrated = counterCaliber(context, bzGalleryCount);

      final String _followersCounter =
          (authorGalleryCount == 0 && followersCount == 0)
          ||
          (authorGalleryCount == null && followersCount == null)
          ?
          ''
          :
          showLabel == true ?
          '${Numeric.formatNumToSeparatedKilos(number: authorGalleryCount)} '
          '${xPhrase( context, 'phid_flyers')}'
          :
          '${counterCaliber(context, followersCount)} '
          '${xPhrase( context, 'phid_followers')} . '
          '$_galleryCountCalibrated '
          '${xPhrase( context, 'phid_flyers')}';

      return Verse(
        text: _followersCounter,
        translate: false,
      );

    }
  // --------------------
}
