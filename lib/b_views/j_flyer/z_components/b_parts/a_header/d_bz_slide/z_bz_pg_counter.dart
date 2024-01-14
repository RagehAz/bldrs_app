import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_black_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BzPgCounter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPgCounter({
    required this.flyerBoxWidth,
    required this.count,
    required this.verse,
    this.icon,
    this.iconSizeFactor = 1,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final int? count;
  final Verse verse;
  final String? icon;
  final double iconSizeFactor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double iconBoxHeight = flyerBoxWidth * 0.08;
    final double iconHeight = iconBoxHeight * iconSizeFactor;
    final double bzPageStripSideMargin = flyerBoxWidth * 0.05;
    final double iconMargin = iconBoxHeight - iconHeight;
    // --------------------
    return BlackBox(
      width: flyerBoxWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: bzPageStripSideMargin),
        child: Row(
          children: <Widget>[

            ///  ICON
            Container(
              width: iconBoxHeight,
              height: iconBoxHeight,
              margin: EdgeInsets.symmetric(
                  horizontal: flyerBoxWidth * 0.01),
              // color: Colorz.BloodTest,
              child: Padding(
                padding: EdgeInsets.all(iconMargin),
                child: icon == null ? const SizedBox() : WebsafeSvg.asset(
                    icon!,
                    width: iconBoxHeight,
                    height: iconBoxHeight,
                    // package: Iconz.bldrsTheme,
                ),
              ),
            ),

            /// COUNT
            BldrsText(
              verse: Verse(
                id: Numeric.formatNumToSeparatedKilos(
                  number: count ?? 0,
                  fractions: 0,
                ),
                translate: false,
              ),
              margin: bzPageStripSideMargin * 0.1,
            ),

            /// VERSE
            BldrsText(
              verse: verse,
              color: Colorz.white200,
              weight: VerseWeight.thin,
              italic: true,
              margin: bzPageStripSideMargin * 0.1,
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
