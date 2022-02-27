import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
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
    const dynamic bzPageBGColor = Colorz.black80;
    final double bzPageDividers = flyerBoxWidth * 0.005;

    final double _margins = maxLines > 1 ? flyerBoxWidth * 0.05 : flyerBoxWidth * 0.02;

    return Padding(
      padding: EdgeInsets.only(top: bzPageDividers),
      child: Container(
        width: flyerBoxWidth,
        color: bzPageBGColor,
        child: SuperVerse(
          verse: verse,
          weight: VerseWeight.thin,
          italic: true,
          size: size,
          color: Colorz.white200,
          margin: _margins,
          maxLines: maxLines,
        ),
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

    const dynamic bzPageBGColor = Colorz.black80;
    final double bzPageDividers = widget.flyerBoxWidth * 0.005;

    final double _margins = widget.flyerBoxWidth * 0.05;

    return GestureDetector(
      onTap: _expandMaxLines,
      child: Padding(
        padding: EdgeInsets.only(top: bzPageDividers),
        child: Container(
          width: widget.flyerBoxWidth,
          color: bzPageBGColor,
          padding: EdgeInsets.only(left: _margins, right: _margins, bottom: _margins),
          child: Column(
            children: <Widget>[

              SuperVerse(
                verse: '${Wordz.about(context)} ${widget.bzName}',
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
        ),
      ),
    );
  }
}
