import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPgVerse extends StatelessWidget {
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final String verse;
  final int size;
  final int maxLines;

  const BzPgVerse({
    @required this.flyerBoxWidth,
    this.bzPageIsOn = true,
    @required this.verse,
    @required this.size,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    const dynamic bzPageBGColor = Colorz.black80;
    final double bzPageDividers = flyerBoxWidth * 0.005;

    final double _margins =
        maxLines > 1 ? flyerBoxWidth * 0.05 : flyerBoxWidth * 0.02;

    return bzPageIsOn == false ? Container()
        : Padding(
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
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final String verse;
  final String bzName;

  const BzAboutVerse({
    @required this.flyerBoxWidth,
    this.bzPageIsOn = true,
    @required this.verse,
    @required this.bzName,
  });

  @override
  _BzAboutVerseState createState() => _BzAboutVerseState();
}

class _BzAboutVerseState extends State<BzAboutVerse> {
  int aboutMaxLines = 3;

  void _expandMaxLines() {
    setState(() {
      aboutMaxLines == 3 ? aboutMaxLines = 100 : aboutMaxLines = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    const dynamic bzPageBGColor = Colorz.black80;
    final double bzPageDividers = widget.flyerBoxWidth * 0.005;

    final double _margins = widget.flyerBoxWidth * 0.05;

    return widget.bzPageIsOn == false
        ? Container()
        : GestureDetector(
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
                      size: 2,
                      weight: VerseWeight.thin,
                      italic: false,
                      margin: 10,
                      color: Colorz.grey225,
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
