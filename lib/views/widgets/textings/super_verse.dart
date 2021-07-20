import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
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
  final Function onTap;
  final bool leadingDot;
  final bool redDot;

  SuperVerse({
    this.verse = 'Bldrs.net will shock planet Earth isa',
    this.size = 2,
    this.color = Colorz.White255,
    this.weight = VerseWeight.bold,
    this.italic = false,
    this.shadow = false,
    this.centered = true,
    this.designMode = false,
    this.scaleFactor = 1,
    this.maxLines = 1,
    this.margin,
    // this.softWrap = true,
    this.labelColor,
    this.onTap,
    this.leadingDot = false,
    this.redDot = false,
  });

  Widget _dot(double _dotSize, Color _color){
    return Container(
      width: _dotSize,
      height: _dotSize,
      decoration: BoxDecoration(
          color: _color,
          shape: BoxShape.circle
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Color _boxColor = designMode ? Colorz.BloodTest : Colorz.Nothing;
    const double verseHeight = 1.42; //1.48; // The sacred golden reverse engineered factor
    double _scalingFactor = scaleFactor == null ? 1: scaleFactor;
    int _maxLines =  maxLines;
    // takes values from 0 to 8 in the entire app
    double verseSizeValue = superVerseSizeValue(context, size, _scalingFactor);
    // --- AVAILABLE FONT WEIGHTS -----------------------------------------------
    FontWeight verseWeight = superVerseWeight(weight);
    // --- AVAILABLE FONTS -----------------------------------------------
    String verseFont = superVerseFont(context, weight);
    // --- LETTER SPACING -----------------------------------------------
    double verseLetterSpacing = superVerseLetterSpacing(weight, verseSizeValue);
    // --- WORD SPACING -----------------------------------------------
    double verseWordSpacing = superVerseWordSpacing(verseSizeValue);
    // --- SHADOWS -----------------------------------------------
    const double _shadowBlur = 0;
    const double _shadowYOffset = 0;
    double _shadowXOffset = superVerseXOffset(weight, verseSizeValue);
    double _secondShadowXOffset = -0.35 * _shadowXOffset;
    Color _leftShadow = color == Colorz.Black230 ? Colorz.White125 : Colorz.Black230;
    Color _rightShadow = color == Colorz.Black230 ? Colorz.White80 : Colorz.White20;
    // --- ITALIC -----------------------------------------------
    FontStyle verseStyle = italic == true ? FontStyle.italic : FontStyle.normal;
    // --- VERSE BOX MARGIN -----------------------------------------------
    double _margin = margin == null ? 0 : margin;
    // --- LABEL -----------------------------------------------
    double _labelCornerValues = superVerseLabelCornerValue(context, size);
    double _labelCorner = labelColor == null ? 0 : _labelCornerValues;
    double _sidePaddingValues = superVerseSidePaddingValues(context, size);
    double _sidePaddings = labelColor == null ? 0 : _sidePaddingValues;
    double _labelHeight = superVerseRealHeight(context, size, scaleFactor, labelColor);
    // --- DOTS -----------------------------------------------
    double _dotSize = verseSizeValue * 0.3;
    // --- RED DOT -----------------------------------------------


    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(_margin),
        child: Row(
          mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: redDot == true ? CrossAxisAlignment.center : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            if (leadingDot == true)
              Padding(
                  padding: EdgeInsets.all(_dotSize),
                  child: _dot(_dotSize, color),
                ),

            Flexible(
              flex: 1,//_maxLines >= 1 ? 1 : 0,
              child: Container(
                padding: EdgeInsets.only(right: _sidePaddings, left: _sidePaddings),
                margin: EdgeInsets.all(_sidePaddings * 0.25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(_labelCorner)),
                    color: labelColor
                ),
                child: Text(
                  verse == null ? '...' : verse,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: _maxLines,
                  textAlign: centered == true ?
                  TextAlign.center
                      :
                  TextAlign.start,
                  textScaleFactor: 1,
                  style: TextStyle(
                      backgroundColor: _boxColor,
                      textBaseline: TextBaseline.alphabetic,
                      height: verseHeight,
                      color: color,
                      fontFamily: verseFont ,
                      fontStyle: verseStyle,
                      letterSpacing: verseLetterSpacing,
                      wordSpacing: verseWordSpacing,
                      fontSize: verseSizeValue,
                      fontWeight: verseWeight,
                      shadows: <Shadow>[
                        if (shadow)
                          Shadow(
                            blurRadius: _shadowBlur,
                            color: _leftShadow,
                            offset: Offset(_shadowXOffset, _shadowYOffset),
                          ),
                        Shadow(
                          blurRadius: _shadowBlur,
                          color: _rightShadow,
                          offset: Offset(_secondShadowXOffset, _shadowYOffset),
                        ),
                      ]
                  ),
                ),
              ),
            ),

            if (redDot == true)
            Container(
              height: _labelHeight,
                margin:
                labelColor == null ?
                EdgeInsets.symmetric(horizontal: _labelHeight * 0.2) :
                EdgeInsets.symmetric(horizontal: _labelHeight * 0.05),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                  labelColor == null ?
                  EdgeInsets.only(top: _labelHeight * 0.2) :
                  EdgeInsets.only(top: _labelHeight * 0.05) ,
                  child: _dot(_dotSize, Colorz.Red255),
                ),
            ),

          ],
        ),
      ),
    );
  }
}