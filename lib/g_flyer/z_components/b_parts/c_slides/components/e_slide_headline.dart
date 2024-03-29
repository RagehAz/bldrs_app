import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';


class SlideHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideHeadline({
    required this.flyerBoxWidth,
    required this.text,
    this.verseColor = Colorz.white255,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final String? text;
  final Color verseColor;
  // --------------------------------------------------------------------------
  static const headlineScaleFactor = 0.0028;
  static const headlineSize = 2;
  // --------------------
  static double getTextSizeFactorByLength(String? text){

    if (TextCheck.isEmpty(text) == true){
      return 1;
    }
    else {
      return text!.length > 100 ? 1 : 1.4;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _headlineTopMargin = flyerBoxWidth * 0.3;
    final double lengthFactor = getTextSizeFactorByLength(text);

    /// FLYER TITLE
    return IgnorePointer(
      child: Container(
        width: flyerBoxWidth,
        height: flyerBoxWidth * 0.5,
        margin: EdgeInsets.only(top: _headlineTopMargin),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: flyerBoxWidth * 0.03),
        // color: Colorz.bloodTest,
        child: Stack(
          children: <Widget>[

            /// BACK
            BldrsText(
              // width: flyerBoxWidth,
              verse: Verse.plain(text),
              color: Colorz.grey255,
              // size: headlineSize,
              scaleFactor: flyerBoxWidth * headlineScaleFactor * lengthFactor,
              labelColor: Colorz.black125,
              maxWidth: flyerBoxWidth,
              maxLines: 5,
              // centered: true,
              margin: EdgeInsets.zero,
              italic: true,
            ),

            /// FRONT
            BldrsText(
              italic: true,
              // width: flyerBoxWidth,
              verse: Verse.plain(text),
              color: verseColor,
              // size: headlineSize,
              scaleFactor: flyerBoxWidth * headlineScaleFactor * lengthFactor,
              labelColor: Colorz.white20,
              maxWidth: flyerBoxWidth,

              maxLines: 5,
              // centered: true,
              margin: EdgeInsets.zero,
            ),

          ],
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
