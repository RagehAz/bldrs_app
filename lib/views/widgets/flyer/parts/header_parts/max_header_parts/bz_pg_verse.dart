import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPgVerse extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final String verse;
  final int size;
  final int maxLines;

  BzPgVerse({
    @required this.flyerZoneWidth,
    this.bzPageIsOn = true,
    @required this.verse,
    @required this.size,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    dynamic bzPageBGColor = Colorz.BlackSmoke;
    double bzPageDividers = flyerZoneWidth * 0.005;

    double _margins =
        maxLines > 1 ? flyerZoneWidth * 0.05 : flyerZoneWidth * 0.02;

    return bzPageIsOn == false
        ? Container()
        : Padding(
            padding: EdgeInsets.only(top: bzPageDividers),
            child: Container(
              width: flyerZoneWidth,
              color: bzPageBGColor,
              child: SuperVerse(
                verse: verse,
                weight: VerseWeight.thin,
                italic: true,
                size: size,
                color: Colorz.WhiteLingerie,
                margin: _margins,
                maxLines: maxLines,
                // designMode: true,
              ),
            ),
          );
  }
}

class BzAboutVerse extends StatefulWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final String verse;
  final String bzName;

  BzAboutVerse({
    @required this.flyerZoneWidth,
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
    dynamic bzPageBGColor = Colorz.BlackSmoke;
    double bzPageDividers = widget.flyerZoneWidth * 0.005;

    double _margins = widget.flyerZoneWidth * 0.05;

    return widget.bzPageIsOn == false
        ? Container()
        : GestureDetector(
            onTap: _expandMaxLines,
            child: Padding(
              padding: EdgeInsets.only(top: bzPageDividers),
              child: Container(
                width: widget.flyerZoneWidth,
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
                      color: Colorz.Grey,
                      maxLines: 3,
                    ),

                    SuperVerse(
                      verse: widget.verse,
                      weight: VerseWeight.thin,
                      italic: true,
                      size: 3,
                      color: Colorz.WhiteLingerie,
                      margin: 0,
                      maxLines: aboutMaxLines,
                      // designMode: true,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
