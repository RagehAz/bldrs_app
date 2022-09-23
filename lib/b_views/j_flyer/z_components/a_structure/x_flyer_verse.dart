import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
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
        text: Numeric.formatNumToCounterCaliber(context, _count),
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
}
