import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/d_bz_slide/z_black_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class BzAboutVerse extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzAboutVerse({
    required this.flyerBoxWidth,
    required this.verse,
    required this.bzName,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Verse verse;
  final String? bzName;
  /// --------------------------------------------------------------------------
  @override
  _BzAboutVerseState createState() => _BzAboutVerseState();
/// --------------------------------------------------------------------------
}

class _BzAboutVerseState extends State<BzAboutVerse> {
  // -----------------------------------------------------------------------------
  int aboutMaxLines = 3;
  // --------------------
  void _expandMaxLines() {
    setState(() {
      aboutMaxLines == 3 ? aboutMaxLines = 100 : aboutMaxLines = 3;
    });
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return BlackBox(
      width: widget.flyerBoxWidth,
      onTap: _expandMaxLines,
      child: Column(
        children: <Widget>[

          BldrsText(
            verse: Verse(
              id: '${getWord('phid_about')} ${widget.bzName}',
              translate: false,
            ),
            weight: VerseWeight.thin,
            margin: 10,
            color: Colorz.grey255,
            maxLines: 3,
          ),

          BldrsText(
            verse: widget.verse,
            weight: VerseWeight.thin,
            italic: true,
            size: 3,
            color: Colorz.white200,
            margin: 0,
            maxLines: aboutMaxLines,
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
