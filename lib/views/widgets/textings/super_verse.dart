import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
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

    double screenHeight = MediaQuery.of(context).size.height;

    String _verse = verse;
    Color verseColor = color;
    Color boxColor = designMode ? Colorz.BloodTest : Colorz.Nothing;
    double verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    double scalingFactor = scaleFactor == null ? 1: scaleFactor;

    int _maxLines =  maxLines;

    // --- AVAILABLE FONT SIZES -----------------------------------------------
    // takes values from 0 to 8 in the entire app
    double verseSize =
    (size == 0) ? screenHeight * Ratioz.fontSize0 * scalingFactor // -- 8 -- A77A
        :
    (size == 1) ? screenHeight * Ratioz.fontSize1 * scalingFactor // -- 10 -- Nano
        :
    (size == 2) ? screenHeight * Ratioz.fontSize2 * scalingFactor // -- 12 -- Micro
        :
    (size == 3) ? screenHeight * Ratioz.fontSize3 * scalingFactor // -- 14 -- Mini
        :
    (size == 4) ? screenHeight * Ratioz.fontSize4 * scalingFactor // -- 16 -- Medium
        :
    (size == 5) ? screenHeight * Ratioz.fontSize5 * scalingFactor // -- 20 -- Macro
        :
    (size == 6) ? screenHeight * Ratioz.fontSize6 * scalingFactor // -- 24 -- Big
        :
    (size == 7) ? screenHeight * Ratioz.fontSize7 * scalingFactor // -- 28 -- Massive
        :
    (size == 8) ? screenHeight * Ratioz.fontSize8 * scalingFactor // -- 28 -- Gigantic
        :
    screenHeight * Ratioz.fontSize1
    ;


    // --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    FontWeight verseWeight =
    weight == VerseWeight.thin ? FontWeight.w100 :
    weight == VerseWeight.regular ? FontWeight.w600 :
    weight == VerseWeight.bold ? FontWeight.w100 :
    weight == VerseWeight.black ? FontWeight.w600 :
    FontWeight.w100;

    // --- AVAILABLE FONTS -----------------------------------------------
    String verseFont =
    weight == VerseWeight.thin ? getTranslated(context, 'Body_Font') :
    weight == VerseWeight.regular ? getTranslated(context, 'Body_Font') :
    weight == VerseWeight.bold ? getTranslated(context, 'Headline_Font') :
    weight == VerseWeight.black ? getTranslated(context, 'Headline_Font') :
    getTranslated(context, 'Body_Font')
    ;

    // --- LETTER SPACING -----------------------------------------------
    double verseLetterSpacing =
    weight == VerseWeight.thin ? verseSize * 0.035 :
    weight == VerseWeight.regular ? verseSize * 0.09 :
    weight == VerseWeight.bold ? verseSize * 0.05 :
    weight == VerseWeight.black ? verseSize * 0.12
        :
    verseSize * 0
    ;

    // --- WORD SPACING -----------------------------------------------
    double verseWordSpacing =
    // weight == VerseWeight.thin ? verseSize * 0.1 :
    // weight == VerseWeight.regular ? verseSize * 0.1 :
    // weight == VerseWeight.bold ? verseSize * 0.1 :
    // weight == VerseWeight.black ? verseSize * 0.1 :
    verseSize * 0
    ;

    // --- SHADOWS -----------------------------------------------
    double shadowBlur = 0;
    double shadowYOffset = 0;
    double shadowXOffset =
        weight == VerseWeight.thin ? verseSize * -0.07 :
        weight == VerseWeight.regular ? verseSize * -0.09 :
        weight == VerseWeight.bold ? verseSize * -0.11 :
        weight == VerseWeight.black ? verseSize * -0.12:
        verseSize * -0.06;
    double secondShadowXOffset = -0.35 * shadowXOffset;
    Color leftShadow = color == Colorz.BlackBlack ? Colorz.WhitePlastic : Colorz.BlackBlack;
    Color rightShadow = color == Colorz.BlackBlack ? Colorz.WhiteSmoke : Colorz.WhiteGlass;

    // --- ITALIC -----------------------------------------------
    FontStyle verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;

    // --- VERSE BOX MARGIN -----------------------------------------------
    double _margin = margin == null ? 0 : margin;


    // --- LABEL CORNERS -----------------------------------------------
    double labelCornerRatio = 0.4;
    double labelCornerValues =
    (size == 0) ? screenHeight * Ratioz.fontSize0 * labelCornerRatio// -- 8 -- A77A
        :
    (size == 1) ? screenHeight * Ratioz.fontSize1 * labelCornerRatio// -- 10 -- Nano
        :
    (size == 2) ? screenHeight * Ratioz.fontSize2 * labelCornerRatio// -- 12 -- Micro
        :
    (size == 3) ? screenHeight * Ratioz.fontSize3 * labelCornerRatio// -- 14 -- Mini
        :
    (size == 4) ? screenHeight * Ratioz.fontSize4 * labelCornerRatio// -- 16 -- Medium
        :
    (size == 5) ? screenHeight * Ratioz.fontSize5 * labelCornerRatio// -- 20 -- Macro
        :
    (size == 6) ? screenHeight * Ratioz.fontSize6 * labelCornerRatio// -- 24 -- Big
        :
    (size == 7) ? screenHeight * Ratioz.fontSize7 * labelCornerRatio// -- 28 -- Massive
        :
    (size == 8) ? screenHeight * Ratioz.fontSize8 * labelCornerRatio// -- 28 -- Gigantic
        :
     0 // -- 14 -- Medium as default
    ;
    double labelCorner = labelColor == Colorz.Nothing ? 0 : labelCornerValues;

    // --- LABEL PADDINGS -----------------------------------------------
    double sidePaddingRatio = 0.45;
    double sidePaddingValues =
    (size == 0) ? screenHeight * Ratioz.fontSize0 * sidePaddingRatio// -- 8 -- A77A
        :
    (size == 1) ? screenHeight * Ratioz.fontSize1 * sidePaddingRatio// -- 10 -- Nano
        :
    (size == 2) ? screenHeight * Ratioz.fontSize2 * sidePaddingRatio// -- 12 -- Micro
        :
    (size == 3) ? screenHeight * Ratioz.fontSize3 * sidePaddingRatio// -- 14 -- Mini
        :
    (size == 4) ? screenHeight * Ratioz.fontSize4 * sidePaddingRatio// -- 16 -- Medium
        :
    (size == 5) ? screenHeight * Ratioz.fontSize5 * sidePaddingRatio // -- 20 -- Macro
        :
    (size == 6) ? screenHeight * Ratioz.fontSize6 * sidePaddingRatio// -- 24 -- Big
        :
    (size == 7) ? screenHeight * Ratioz.fontSize7 * sidePaddingRatio// -- 28 -- Massive
        :
    (size == 8) ? screenHeight * Ratioz.fontSize8 * sidePaddingRatio// -- 28 -- Gigantic
        :
     0 //
    ;

    double sidePaddings = labelColor == Colorz.Nothing ? 0 : sidePaddingValues;

    return GestureDetector(
      onTap: labelTap,
      child: Row(
        mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
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
                      fontSize: verseSize,
                      fontWeight: verseWeight,
                      shadows: [
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
