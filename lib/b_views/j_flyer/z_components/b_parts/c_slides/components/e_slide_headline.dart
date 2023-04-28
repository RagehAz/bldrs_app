import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class SlideHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideHeadline({
    @required this.flyerBoxWidth,
    @required this.text,
    this.verseColor = Colorz.white255,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final String text;
  final Color verseColor;
  /// --------------------------------------------------------------------------
  static const headlineScaleFactor = 0.0032;
  static const headlineSize = 2;
  // --------------------
  @override
  Widget build(BuildContext context) {

    final double _headlineTopMargin = flyerBoxWidth * 0.3;
    final double lengthFactor = text.isEmpty ? 1 : text.length > 100 ? 1 : 1.4;

    /// FLYER TITLE
    return IgnorePointer(
      child: Container(
        width: flyerBoxWidth,
        height: flyerBoxWidth * 0.5,
        // color: Colorz.bloodTest,
        margin: EdgeInsets.only(top: _headlineTopMargin),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: flyerBoxWidth * 0.03),
        child: BldrsText(
          width: flyerBoxWidth,
          verse: Verse.plain(text),
          color: verseColor,
          shadow: true,
          // size: headlineSize,
          scaleFactor: flyerBoxWidth * headlineScaleFactor * lengthFactor,
          labelColor: Colorz.black50,
          maxLines: 5,
          // centered: true,
          margin: EdgeInsets.zero,
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
