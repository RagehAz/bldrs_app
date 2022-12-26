import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_black_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:flutter/material.dart';

class BzSlideVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzSlideVerse({
    @required this.flyerBoxWidth,
    @required this.verse,
    @required this.size,
    this.maxLines = 1,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Verse verse;
  final int size;
  final int maxLines;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _margins = maxLines > 1 ? flyerBoxWidth * 0.05 : flyerBoxWidth * 0.02;

    return BlackBox(
      width: flyerBoxWidth,
      child: SuperVerse(
        verse: verse,
        weight: VerseWeight.thin,
        italic: true,
        size: size,
        color: Colorz.white200,
        margin: _margins,
        maxLines: maxLines,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
