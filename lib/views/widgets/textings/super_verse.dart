import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';

enum VerseWeight {
  black,
  bold,
  regular,
  thin,
}

class SuperVerse extends StatelessWidget {
  final String verse;
  final int size;
  final Color color;
  final VerseWeight weight;
  final bool italic;
  final bool shadow;
  final bool centered;
  final bool designMode;
  final double scaleFactor;
  final int maxLines;
  final double margin;
  // final bool softWrap;
  final Color labelColor;
  final Function labelTap;

  SuperVerse({
    this.verse = 'Bldrs.net will shock planet Earth isa',
    this.size = 2,
    this.color = Colorz.White,
    this.weight = VerseWeight.bold,
    this.italic = false,
    this.shadow = false,
    this.centered = true,
    this.designMode = false,
    this.scaleFactor,
    this.maxLines = 1,
    this.margin,
    // this.softWrap = true,
    this.labelColor = Colorz.Nothing,
    this.labelTap,
  });


  @override
  Widget build(BuildContext context) {

    String _verse = verse;
    Color verseColor = color;
    Color boxColor = designMode ? Colorz.BloodTest : Colorz.Nothing;
    double verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    double scalingFactor = scaleFactor == null ? 1: scaleFactor;
    int _maxLines =  maxLines;
    // takes values from 0 to 8 in the entire app
    double verseSizeValue = superVerseSizeValue(context, size, scalingFactor);
    // --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    FontWeight verseWeight = superVerseWeight(weight);
    // --- AVAILABLE FONTS -----------------------------------------------
    String verseFont = superVerseFont(context, weight);
    // --- LETTER SPACING -----------------------------------------------
    double verseLetterSpacing = superVerseLetterSpacing(weight, verseSizeValue);
    // --- WORD SPACING -----------------------------------------------
    double verseWordSpacing = superVerseWordSpacing(verseSizeValue);
    // --- SHADOWS -----------------------------------------------
    double shadowBlur = 0;
    double shadowYOffset = 0;
    double shadowXOffset = superVerseXOffset(weight, verseSizeValue);
    double secondShadowXOffset = -0.35 * shadowXOffset;
    Color leftShadow = color == Colorz.BlackBlack ? Colorz.WhitePlastic : Colorz.BlackBlack;
    Color rightShadow = color == Colorz.BlackBlack ? Colorz.WhiteSmoke : Colorz.WhiteGlass;
    // --- ITALIC -----------------------------------------------
    FontStyle verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;
    // --- VERSE BOX MARGIN -----------------------------------------------
    double _margin = margin == null ? 0 : margin;
    // --- LABEL CORNERS -----------------------------------------------
    double labelCornerValues = superVerseLabelCornerValue(context, size);
    double labelCorner = labelColor == Colorz.Nothing ? 0 : labelCornerValues;
    // --- LABEL PADDINGS -----------------------------------------------
    double sidePaddingValues = superVerseSidePaddingValues(context, size);
    double sidePaddings = labelColor == Colorz.Nothing ? 0 : sidePaddingValues;

    return GestureDetector(
      onTap: labelTap,
      child: Row(
        mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 1,//_maxLines >= 1 ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.all(_margin),
              child: Container(
                padding: EdgeInsets.only(right: sidePaddings, left: sidePaddings),
                margin: EdgeInsets.all(sidePaddings * 0.25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(labelCorner)),
                    color: labelColor
                ),
                child: Text(
                  _verse == null ? '...' : _verse,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: _maxLines,
                  textAlign: centered == true ?
                  TextAlign.center
                      :
                  TextAlign.start,
                  textScaleFactor: 1,
                  style: TextStyle(
                      backgroundColor: boxColor,
                      textBaseline: TextBaseline.alphabetic,
                      height: verseHeight,
                      color: verseColor,
                      fontFamily: verseFont ,
                      fontStyle: verseStyle,
                      letterSpacing: verseLetterSpacing,
                      wordSpacing: verseWordSpacing,
                      fontSize: verseSizeValue,
                      fontWeight: verseWeight,
                      shadows: <Shadow>[
                        if (shadow)
                          Shadow(
                            blurRadius: shadowBlur,
                            color: leftShadow,
                            offset: Offset(shadowXOffset, shadowYOffset),
                          ),
                        Shadow(
                          blurRadius: shadowBlur,
                          color: rightShadow,
                          offset: Offset(secondShadowXOffset, shadowYOffset),
                        )
                      ]
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
