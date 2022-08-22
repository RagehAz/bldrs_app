import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/black_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzPgVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPgVerse({
    @required this.flyerBoxWidth,
    @required this.verse,
    @required this.size,
    this.maxLines = 1,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final String verse;
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
}

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
  final String verse;
  final String bzName;
  /// --------------------------------------------------------------------------
  @override
  _BzAboutVerseState createState() => _BzAboutVerseState();
  /// --------------------------------------------------------------------------
}

class _BzAboutVerseState extends State<BzAboutVerse> {
// -----------------------------------------------------------------------------
  int aboutMaxLines = 3;
// -----------------------------------------------------------------------------
  void _expandMaxLines() {
    setState(() {
      aboutMaxLines == 3 ? aboutMaxLines = 100 : aboutMaxLines = 3;
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BlackBox(
      width: widget.flyerBoxWidth,
      onTap: _expandMaxLines,
      child: Column(
        children: <Widget>[

          SuperVerse(
            verse: '${xPhrase(context, 'phid_about')} ${widget.bzName}',
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
}
