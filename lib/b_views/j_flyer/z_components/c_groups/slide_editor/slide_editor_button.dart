import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SlideEditorButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorButton({
    required this.size,
    required this.icon,
    required this.verse,
    required this.onTap,
    this.isDisabled,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double size;
  final String icon;
  final Verse verse;
  final Function onTap;
  final bool? isDisabled;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double getVerseZoneHeight({
    required double buttonSize,
  }){
    return buttonSize * 0.4;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getBoxHeight({
    required double buttonSize,
  }){
    final double _verseZoneHeight = getVerseZoneHeight(buttonSize: buttonSize);
    return buttonSize + _verseZoneHeight;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _verseZoneHeight = getVerseZoneHeight(
      buttonSize: size,
    );

    return SizedBox(
      width: size + (2 * Ratioz.appBarMargin),
      height: size + _verseZoneHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          BldrsBox(
            width: size,
            height: size,
            icon: icon,
            iconSizeFactor: 0.6,
            margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            isDisabled: isDisabled,
            color: Colorz.white20,
            onTap: onTap,
          ),

          BldrsText(
            width: size + (2 * Ratioz.appBarMargin),
            height: _verseZoneHeight,
            verse: verse,
            weight: VerseWeight.thin,
            scaleFactor: size * 0.014,
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
