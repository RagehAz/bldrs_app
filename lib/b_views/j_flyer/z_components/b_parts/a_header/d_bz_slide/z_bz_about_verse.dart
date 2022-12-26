import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_black_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:flutter/material.dart';

class BzAboutVerse extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzAboutVerse({
    @required this.flyerBoxWidth,
    @required this.verse,
    @required this.bzName,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Verse verse;
  final String bzName;
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

          SuperVerse(
            verse: Verse(
              text: '${xPhrase( context, 'phid_about')} ${widget.bzName}',
              translate: false,
            ),
            weight: VerseWeight.thin,
            margin: 10,
            color: Colorz.grey255,
            maxLines: 3,
          ),

          SuperVerse(
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
